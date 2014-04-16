module Quby
  class Function
    attr_accessor :key

    def self.all
      Dir[File.join(Quby.questionnaires_path, "functions", "*.rb")].map do |filename|
        key = File.basename(filename, '.rb')
        new(key)
      end
    end

    def initialize(key)
      self.key = key
    end

    def definition
      @definition ||= File.read(File.join(Quby.questionnaires_path, "functions", "#{key}.rb")) rescue nil
    end
  end
end
