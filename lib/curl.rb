require 'curl/version'
require 'curl/parser'

class Curl
  class Option
    attr_accessor :name, :value

    def initialize(name, value)
      @name = name
      @value = value
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
    string = "curl #{url}"
    @options.each do |option|
      string << "\\\n#{option.name} #{option.value}"
    end

    string
  end
end
