# frozen_string_literal: true

require 'quby/table_backend/disk_tree'

module Quby
  class LookupTable
    attr_accessor :key

    def self.backend_class
      Quby::TableBackend::DiskTree
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
