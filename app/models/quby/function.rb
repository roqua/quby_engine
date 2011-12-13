module Quby
  class Function
    attr_accessor :key

    def self.all
      Dir[Rails.root.join("db", "functions", "*.rb")].map do |filename|
        key = File.basename(filename, '.rb')
        self.new(key)
      end
    end

    def initialize(key)
      self.key = key
    end

    def definition
      @definition ||= File.read(Rails.root.join("db", "functions", "#{key}.rb")) rescue nil
    end
  end
end
