# frozen_string_literal: true

require 'quby/table_backend/disk_tree'

module Quby
  class LookupTable
    attr_accessor :key

    def initialize(key)
      @key = key
      @backing = Quby::TableBackend::DiskTree.new(data)
    end

    def lookup(parameters)
      @backing.lookup(parameters)
    end

    def data
      Quby.lookup_table_repo.retrieve(key)
    end
  end
end
