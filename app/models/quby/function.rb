module Quby
  class Function < ActiveRecord::Base
    set_table_name :functions

    after_save  :write_to_disk

    def definition
      @definition ||= File.read(Rails.root.join("db", "functions", "#{name}.rb")) rescue nil
    end

    def definition=(value)
      @definition = value
    end

    protected

    def write_to_disk
      filename = Rails.root.join("db", "functions", "#{name}.rb")
      logger.info "Writing #{filename}..."
      File.open(filename, "w") {|f| f.write( self.definition ) }
    end

  end
end
