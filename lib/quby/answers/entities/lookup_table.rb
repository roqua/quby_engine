require 'quby/answers/entities/table_backend/disk_table'

module Quby::Answers::Entities
  class LookupTable
    attr_accessor :key

    def self.backend_class
      Quby::Answers::Entities::TableBackend::DiskTable
    end

    def initialize(key)
      @key = key
      @backing = self.class.backend_class.new(key)
    end

    def lookup(parameters)
      @backing.lookup(parameters)
    end
  end
end
