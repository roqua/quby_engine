require 'quby/answers/entities/table_backend/table_dimension'
module Quby::Answers::Entities::TableBackend
  class DiskTable
    require "pathname"

    def self.disk_table_root
      fail 'Quby.lookup_table_path not configured' if Quby.lookup_table_path.blank?
      Quby.lookup_table_path
    end

    def self.validate_jailed_path(path)
      full_path = File.expand_path(path)
      jail = File.expand_path(disk_table_root)
      full_path.starts_with?(jail)
    end

    # range should either be:
    #  an empty array, which returns a range that will accept any value on an 'include?' call
    #  a 2 long float string array, these will be converted into a float range
    #    float ranges will be open ended on the right side
    #  a varied length non-float string array, to signify a set of categorical options (like 'male', 'female', 'other')
    #    this will be returned as is
    def self.parse_range(range)
      if range.length == 0
        Quby::Answers::Entities::TableBackend::TableDimension::AcceptsAnythingRange.instance
      elsif parse_float(range.first).present?
        parse_float_range(range)
      else
        range
      end
    end

    def self.parse_float_range(range)
      maybe_float_start = parse_float(range[0])
      maybe_float_end = parse_float(range[1])
      if maybe_float_end.present? && range.length == 2
        return (maybe_float_start...maybe_float_end)
      else
        fail "#{range} has a float start but not a float end"
      end
    end

    def self.parse_float(maybe_float_string)
      float = Float(maybe_float_string) rescue nil
      case maybe_float_string
      when 'minfinity' then -Float::INFINITY
      when 'infinity' then Float::INFINITY
      else float
      end
    end

    def initialize(key)
      path = Pathname.new self.class.disk_table_root.join(key)
      fail "path #{path} outside of jail" unless self.class.validate_jailed_path(path)

      @root_dimensions = dimensions_from_children(path)
    end

    def lookup(parameters)
      result = nil
      @root_dimensions.find do |dimension|
        result = dimension.lookup(parameters)
      end
      result
    end

    def dimensions_from_children(directory_path)
      children = Pathname.new(directory_path).children

      # directory names are of the form 'dimensionname_rangestart_rangeend',
      # files use the whole name as the dimension name, so we can use underscores in leaf dimension names
      if children.all?(&:directory?)
        dimensions_from_directories children
      elsif children.all?(&:file?)
        dimensions_from_files children
      else
        fail "disk_table path contains directories and files mixed together"
      end
    end

    def dimensions_from_directories(directory_names)
      dimensions = directory_names.group_by do |child|
        child.expand_path.basename.to_s.split('_').first
      end

      dimensions.map do |dimension_key, pathnames|
        ranges = pathnames.map do |pathname|
          range_key = self.class.parse_range pathname.expand_path.basename.to_s.split('_')[1..-1]
          range_value = dimensions_from_children(pathname)

          [range_key, range_value]
        end.to_h

        TableDimension.new(dimension_key, ranges)
      end
    end

    def dimensions_from_files(file_path_names)
      file_path_names.map do |file_name|
        rows = CSV.read(file_name)
        ranges = rows.each_with_index.map do |(key, value), index|
          fail "blank entry in #{file_name} row #{index + 1}" if key.blank? || value.blank?

          next_key = if (index + 1) < rows.length
                       rows[index + 1].first
                     else
                       Float::INFINITY # the last row defines a range to infinity
                     end
          [(key.to_f...next_key.to_f), value.to_f]
        end.to_h

        TableDimension.new(file_name.basename('.*').to_s, ranges)
      end
    end
  end
end
