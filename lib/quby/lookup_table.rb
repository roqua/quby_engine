# frozen_string_literal: true

require 'quby/table_backend/range_tree'

module Quby
  class LookupTable
    attr_accessor :key

    def initialize(key)
      @key = key
    end

    def backing
      return @backing if @backing.present?
      all_data = data
      headers = all_data.shift
      compare = all_data.shift
      @backing = Quby::TableBackend::RangeTree.new(headers, compare, all_data)
    end

    def lookup(parameters)
      backing.lookup(parameters)
    end

    def data
      Quby.lookup_table_repo.retrieve(key)
    end
  end
end
