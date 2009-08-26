$: << File.dirname(__FILE__)
require 'couchrest'
require 'couchapp'
require 'duck_punches/time'
require 'duck_punches/date_time'
require 'duck_punches/date'

##
# A minimal class to help use CouchDB and CouchRest with Rails.
#
# Provides dot notation access for all attributes, one level deep.
#
#   note.title
#   # Instead of
#   note['title']
#
# You should subclass this so routes are properly generated when making forms.
#
#   class Note < BasicModel
#   	database_name :my_db_name
#	end
#
#   note       = Note.new()
#
#   note       = Note.find('4b463a09321e223b5a7aa1034e28e125')
#   result     = note.save(params[:note])
#
#   notes       = Note.view('notes/by_title-map', :key => 'Restaurant')
#   results     = notes.rows
#
# Subclasses can implement two methods:
#
#   default_attributes() # Should return a hash that all instances will be
#                        # initialized with.
#   on_update()          # Called just before a model is written to the DB.

class BasicModel
  VERSION = '0.1.0'

  attr_accessor :attributes

  def self.db
    full_url_to_database = @database_name
    if full_url_to_database !~ /^http:\/\//
      full_url_to_database = "http://localhost:5984/#{@database_name}"
    end
    database = CouchRest.database!(full_url_to_database)
    if Rails.env == 'development'
      # Synchronize views in development.
      # Assumes existence of "db/couchdb" directory.

      file_manager = CouchApp::FileManager.new(File.basename(full_url_to_database))
      base_dir = File.join(Rails.root, 'db', 'couchdb')

      Dir.foreach(base_dir) do |d|
        file_manager.push_app(File.join(base_dir, d), d) unless d[0] == ?.
      end
    end
    database
  end

  def self.database_name(database_name)
    @database_name ||= database_name
  end

  def database_name
    @database_name
  end

  def db
    self.class.db
  end

  def initialize(attributes={})
    @attributes    = default_attributes.merge(attributes)
  end

  ##
  # To be overridden by subclasses.

  def default_attributes
    {}
  end

  ##
  # Attributes without db details

  def clean_attributes
    attributes = @attributes
    attributes.delete("_id")
    attributes.delete("_rev")
    attributes.delete("created_at")
    attributes.delete("updated_at")
    attributes.delete("type")
    attributes
  end

  def attributes
    @attributes
  end

  def attributes=(hash)
    @attributes = @attributes.merge(hash)
    @attributes
  end

  ##
  # Finds a document by ID and turns it into something
  # usable with Rails.
  #
  #   note = Note.find('283934927362')
  #   note.id
  #   note._rev
  #   note.new_record?
  #   note.title # Any field from the record

  def self.find(id)
    new(self.db.get(id))
  rescue RestClient::ResourceNotFound => exception
    nil
  end

  ##
  # Takes a set of results from a CouchRest view call and turns the
  # rows into Rails-friendly objects.
  #
  #   notes = Note.view('my_db_name', 'notes/by_title')
  #   notes.rows.each {|row| row.id ... }

  def self.view(view_name, options={})
    results = new(self.db.view(view_name, options))
    results.rows.each_with_index do |row, index|
      results.rows[index] = new(row['value'])
    end
    results
  end

  ##
  # Merges attributes with the existing record and saves to CouchDB.
  #
  # If attributes has an "attachment" field, it will be read and
  # formatted for inclusion as a CouchDB attachment to the document.

  def save
    create_or_update
  end

  def update_attributes(attrs)
    self.attributes = attrs
    save
  end

  ##
  # Deletes the document from the database

  def destroy
    doc = {'_id' => self.id, '_rev' => self._rev }
    self.class.db.delete(doc) unless new_record?
    freeze
  end

  alias_method :delete, :destroy

  def freeze
    @attributes.freeze
  end

  def frozen?
    @attributes.frozen
  end

  def has_attribute?(attr_name)
    @attributes.has_key?(attr_name.to_s)
  end

  ##
  # Returns the ID so Rails can use it for forms.

  def id
    _id rescue nil
  end

  def id=(id)
    _id = id
  end

  alias_method :to_param, :id

  def new_record?
    (_rev).nil?
  rescue NameError
    true
  end

  ##
  # Handles getters and setters for the first level of the hash.
  #
  #   record._rev
  #   record.title
  #   record.title = "Streetside bratwurst vendor"

  def method_missing(method_symbol, *arguments)
    method_name = method_symbol.to_s

    if md = /_before_type_cast$/.match(method_name)
      attr_name = md.pre_match
      return self[attr_name] if self.respond_to?(attr_name)
    end

    case method_name[-1..-1]
    when "="
      @attributes[method_name[0..-2]] = arguments.first
    when "?"
      @attributes[method_name[0..-2]] == true
    else
      # Returns nil on failure so forms will work
      @attributes.has_key?(method_name) ? @attributes[method_name] : nil
    end
  end


  def to_xml(options = {})
    options[:root] ||= self.class.to_s.underscore
    attributes.to_xml(options)
  end

  def to_json()
    attributes.to_json()
  end

  alias_method :respond_to_without_attributes?, :respond_to?

  def []=(attr, value)
    @attributes[attr] = value
  end

  def [](attr)
    @attributes[attr]
  end

  private

  def create_or_update
    result = new_record? ? create : update
    result != false
  end

  def update
    handle_attachments
    self.type = self.class.name
    if new_record?
      self.created_at = Time.now
    end
    self.updated_at = Time.now
    self.on_update if self.respond_to?(:on_update)
    result = self.class.db.save(@attributes)
    self._rev = result['rev']
    self
  end

  def create
    update
  end

  def handle_attachments
    # Save an attachment
    if @attributes['attachment'].is_a?(ActionController::UploadedTempfile)
      attachment = @attributes.delete("attachment")
      @attributes["_attachments"] ||= {}
      filename = File.basename(attachment.original_filename)
      @attributes["_attachments"][filename] = {
        "content_type" => attachment.content_type,
        "data" => attachment.read
      }
    else
      @attributes.delete("attachment")
    end
  end

  protected
  def raise_not_implemented_error(*params)
    ValidatingModel.raise_not_implemented_error(*params)
  end

  def self.human_attribute_name(attribute_key_name)
    attribute_key_name.humanize
  end

  def self.human_name
    self.name.humanize
  end

  # these methods must be defined before Validations include
  alias update_attribute raise_not_implemented_error
  alias save! raise_not_implemented_error

  # The following must be defined prior to Callbacks include

  def self.instantiate(record)
    object = allocate
    object.attributes = record
    object
  end

  def self.self_and_descendents_from_active_record#nodoc:
    klass = self
    classes = [klass]
    while klass != klass.base_class
      classes << klass = klass.superclass
    end
    classes
  rescue
    [self]
  end


  public
  include ActiveRecord::Validations
  include ActiveRecord::Callbacks

  protected

  # the following methods must be defined after include so that they overide
  # methods previously included
  class << self
    def raise_not_implemented_error(*params)
      raise NotImplementedError
    end

    alias validates_uniqueness_of raise_not_implemented_error
    alias create! raise_not_implemented_error
  end

end
