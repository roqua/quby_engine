# frozen_string_literal: true

require 'spec_helper'

describe Quby::TableBackend::DiskTable do
  let(:table) { described_class.new('test_table') }
  let(:fixture_root) { Rails.root.join('..', 'fixtures', 'lookup_tables').to_s }
  before do
    allow(Quby).to receive(:lookup_table_path).and_return(fixture_root)
  end

  describe '#initialize' do
    let(:expected_path) { Pathname.new(fixture_root).join('test_table') }

    it 'calls dimensions_from_children on the given key\'s directory path inside disk_table_root' do
      expect_any_instance_of(described_class).to receive(:dimensions_from_children).with(expected_path)
      table
    end

    it 'checks paths are within the disk_table_root jail by calling .validate_jailed_path' do
      expect(described_class).to receive(:validate_jailed_path).with(expected_path).and_call_original
      table
    end
  end

  describe '#dimensions_from_children' do
    it 'transforms files into dimensions' do
      leaf_dir_path = Pathname.new(fixture_root).join('test_table', 'age_0_10', 'gender_')
      dimensions = table.dimensions_from_children(leaf_dir_path)
      expect(dimensions.length).to eq(2)
    end
    it 'transforms directories into dimensions' do
      dir_path = Pathname.new(fixture_root).join('test_table')
      dimensions = table.dimensions_from_children(dir_path)
      expect(dimensions.length).to eq(1)
    end
    it 'raises if the path contains both directories and files' do
      dir_path = Pathname.new(fixture_root).join('mix_file_directory')
      expected_message = 'disk_table path contains directories and files mixed together'
      expect { table.dimensions_from_children(dir_path) }.to raise_exception(expected_message)
    end
  end

  describe '#dimensions_from_directories' do
    it 'transforms directories into dimensions' do
      table_dimension_class = Quby::TableBackend::TableDimension
      dir_children = Pathname.new(fixture_root).join('test_table', 'age_11_infinity').children.sort
      f_score_dimension = table_dimension_class.new('score_tscore',
                                                    {(10.0...12.0) => 33.0,
                                                     (12.0...Float::INFINITY) => 35.0})
      m_score_dimension = table_dimension_class.new('score_tscore',
                                                    {(10.0...12.0) => 36.0,
                                                     (12.0...Float::INFINITY) => 38.0})

      dimensions = table.dimensions_from_directories(dir_children)
      expect(dimensions.length).to eq(1)
      expect(dimensions.first.ranges).to eq(['female'] => [f_score_dimension],
                                            ['male'] => [m_score_dimension])
    end
  end

  describe '#dimensions_from_files' do
    it 'returns [TableDimensions] with data from the given csv files' do
      fixture_files = Pathname.new(fixture_root).join('test_table', 'age_0_10', 'gender_').children.sort
      dims = table.dimensions_from_files(fixture_files)
      expect(dims.length).to eq(2)
      expect(dims.first.name).to eq('score_tscore')
      expect(dims.first.ranges).to eq({(0.0...3.0) => 55.0,
                                       (3.0...5.0) => 58.0,
                                       (5.0...Float::INFINITY) => 60.0})
      expect(dims.last.name).to eq('score_tscore_klin')
      expect(dims.last.ranges).to eq({(0.0...2.0) => 22.0,
                                      (2.0...4.0) => 24.0,
                                      (4.0...Float::INFINITY) => 38.0})
    end

    it 'raises a helpful message if there are blank entries in a csv file' do
      fixture_files = Pathname.new(fixture_root).join('failure_table').children.sort
      expected_exception = /blank entry in .*failure_table\/score_with_blanks.csv row 2/
      expect { table.dimensions_from_files(fixture_files) }.to raise_exception(expected_exception)
    end
  end

  describe '#lookup' do
    it 'calls lookup on the root dimensions' do
      parameters = {age: 22, gender: :female, score_tscore: 11}
      expect(table.instance_variable_get(:@root_dimensions)[0]).to receive(:lookup).with(parameters).and_call_original
      expect(table.lookup(parameters)).to eq(33)
    end
  end

  describe '.disk_table_root' do
    before do
      RSpec::Mocks.space.proxy_for(described_class).reset # remove the allow to_receive(:disk_table_root) just for this test
    end

    it 'calls Quby.lookup_table_path and transforms it to a pathname' do
      expect(Quby).to receive(:lookup_table_path).at_least(:once).and_return 'toot'
      expect(described_class.disk_table_root).to eq(Pathname.new('toot'))
    end

    it 'raises if Quby.lookup_table_path is blank' do
      expect(Quby).to receive(:lookup_table_path).and_return nil
      expect { described_class.disk_table_root }.to raise_error('Quby.lookup_table_path not configured')
    end
  end

  describe '.validate_jailed_path' do
    it 'should allow a child file under the .disk_table_root dir' do
      valid_path = File.join(described_class.disk_table_root, 'test_table')
      expect(described_class.validate_jailed_path(valid_path)).to eq(true)
    end

    it 'should not allow a parent directory' do
      invalid_path = File.join(described_class.disk_table_root, '..')
      expect(described_class.validate_jailed_path(invalid_path)).to eq(false)
    end
  end

  describe '.parse_float' do
    it 'transforms float strings into floats' do
      expect(described_class.parse_float('5.5')).to eq(5.5)
    end

    it 'transforms int strings into floats' do
      expect(described_class.parse_float('5')).to eq(5.0)
    end

    it 'transforms \'infinity\' into Float::INFINITY' do
      expect(described_class.parse_float('infinity')).to eq(Float::INFINITY)
    end

    it 'transforms \'minfinity\' into Float::INFINITY' do
      expect(described_class.parse_float('minfinity')).to eq(-Float::INFINITY)
    end

    it 'returns nil if the string is not strictly a float/(m)infinity' do
      expect(described_class.parse_float('a5')).to eq(nil)
    end
  end

  describe '.parse_range' do
    it 'parses [float_string, float_string] into an open ended float range' do
      expect(described_class.parse_range(['3.3', '5'])).to eq(3.3...5)
    end

    it 'fails if there is no second float [float_string, \'\']' do
      expect { described_class.parse_range(['3.3', '']) }.to raise_exception
    end

    it 'fails if there is are more than 2 floats' do
      expect { described_class.parse_range(['3.3', '4', '6']) }.to raise_exception
    end

    it 'returns an AcceptsAnythingRange if the range is empty' do
      expect(described_class.parse_range([])).to be_a(
        Quby::TableBackend::TableDimension::AcceptsAnythingRange)
    end

    it 'passes through string arrays' do
      input = %w(banana apple octopus)
      expect(described_class.parse_range(input)).to eq(input)
    end
  end

  describe 'Quby.lookup_table_path' do
    it 'allows assigning new paths' do
      expect { Quby.lookup_table_path = Rails.root }.to_not raise_exception
    end
  end
end
