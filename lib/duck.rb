require_relative 'duck/version'
require_relative 'duck/parser'
require_relative 'duck/rspec_extension'

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

  attr_accessor :url, :options, :headers

  def initialize
    @options = []
    @headers = {}
  end

  def self.load(filepath)
    raw_curl = File.read(filepath)
    parser = Parser.new(raw_curl, new)
    parser.go!
  end

  def request_type
    :get
  end

  def to_s
    curl = ["curl #{url}"]

    @options.each do |option|
      curl << "  #{option}"
    end

    @headers.each do |k, v|
      curl << "  --header \"#{[k, v].join(': ')}\""
    end

    curl.join("\\\n")
  end
end
