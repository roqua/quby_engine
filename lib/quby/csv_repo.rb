require 'pathname'
require 'csv'

module Quby
  module CsvRepo
    def self.validate_key(key)
      raise 'invalid key' unless key =~ /\A[a-z][a-z_0-9]{1,9}\z/
    end

    class Disk
      attr_reader :disk_table_root

      def initialize(disk_table_root)
        @disk_table_root = Pathname.new(disk_table_root)
      end

      def retrieve(key)
        Quby::CsvRepo.validate_key(key)
        path = disk_table_root.join(key + '.csv')
        CSV.read(path, col_sep: ';', skip_blanks: true)
      end
    end
  end
end