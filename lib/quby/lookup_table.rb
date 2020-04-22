# frozen_string_literal: true

require 'quby/table_backend/disk_tree'

module Quby
  class LookupTable
    attr_accessor :key

    def initialize(key)
      @key = key
      # fetch csvs from the questionnaire git repo backing when running in qubyamdin
      if self.class.parent_application == "QubyAdmin"
        @backing = Quby::TableBackend::DiskTree.from_git(key)
      else # use file backing when running in roqua or test/ci
        @backing = Quby::TableBackend::DiskTree.from_file(key)
      end
    end

    def lookup(parameters)
      @backing.lookup(parameters)
    end

    def self.parent_application
      Rails.application.class.parent.name
    end
  end
end
