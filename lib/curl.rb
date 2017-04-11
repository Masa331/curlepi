require 'curl/version'
require 'curl/parser'

class Curl

  attr_accessor :url, :x

  def self.load(filepath)
    raw_curl = File.read(filepath)
    parser = Parser.new(raw_curl, new)
    parser.go!
  end

  def to_s
    string = "curl #{url}"
    string << "\n-X #{x}" unless x.nil?

    string
  end

  def url
    @url
  end
end
