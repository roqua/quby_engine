require 'csv'
require 'roo'

BASEDIR = '/Users/arnold/Downloads'
VARIANTS = %w[Leerkrachtvragenlijst_NL Oudervragenlijst_NL Zelfrapportage_NL]

INFINITY = 1.0/0

class BriefScores
  def initialize
    data = [
      ["scale", "gender", "age", "raw", "norm"],
      ["exact", "exact", "range", "range", "exact"]
    ]

    list_files(BASEDIR, VARIANTS[0]).each do |filename|
      xlsx = Roo::Spreadsheet.open(filename)
      gender = xlsx.sheet(0).cell(8, 2)
      min_age = xlsx.sheet(0).cell(10, 2)
      max_age = xlsx.sheet(0).cell(11, 2)
      min_age ||= max_age
      max_age ||= min_age
      max_age += 1 if min_age == max_age

      for x in (1..21).step(2)
        name = xlsx.sheet(0).cell(27, x + 1)
        row_idx = 32

        loop do
          norm = xlsx.sheet(0).cell(row_idx, x)
          raw  = xlsx.sheet(0).cell(row_idx, x + 1)

          next_raw = xlsx.sheet(0).cell(row_idx + 1, x + 1) || 'infinity'

          break if raw.nil? || norm.nil?
          data << [name, gender, "#{min_age}:#{max_age}", "#{raw}:#{next_raw}", norm]
          row_idx += 1
        end
      end
    end

    # puts data.inspect
    csv_filename = VARIANTS[0] + ".csv"
    File.write(csv_filename, data.map(&:to_csv).join)
    puts "Wrote to #{csv_filename}"
  end

  def list_files(basedir, variant)
    Dir["#{basedir}/BRIEF_#{variant}_*.xlsx"]
  end
end

bs = BriefScores.new
# puts bs.read_files
