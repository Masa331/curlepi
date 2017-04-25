require_relative 'zeli/version'
require_relative 'zeli/parser'
require_relative 'zeli/rspec_extension'

class Zeli
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
    return :get if options.empty?

    option = options.find { |o| o.name == '-X' }

    if !option.nil?
      option.value.downcase.to_sym
    else
      :get
    end
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
