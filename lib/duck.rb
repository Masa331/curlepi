require_relative 'duck/version'
require_relative 'duck/parser'

class Duck
  class Option
    attr_accessor :name, :value

    def initialize(name, value)
      @name = name
      @value = value
    end

    def to_s
      [name, value].compact.join(' ')
    end
  end

  attr_accessor :url, :options

  def initialize
    @options = []
  end

  def self.load(filepath)
    raw_curl = File.read(filepath)
    parser = Parser.new(raw_curl, new)
    parser.go!
  end

  def to_s
    curl = ["curl #{url}"]

    @options.sort_by { |o| o.name.length }.each do |option|
      curl << "  #{option}"
    end

    curl.join("\\\n")
  end
end
