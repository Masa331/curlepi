require 'uri'
require_relative 'parsers/param_parser'
require_relative 'parsers/header_parser'
require_relative 'parsers/option_parser'
require_relative 'parsers/url_parser'

class Zeli
  class Parser
    def initialize(raw_curl, curl)
      @raw_curl = raw_curl
      @curl = curl
    end

    def go!
      parsers.each do |parser|
        parser.parse!(@raw_curl, @curl)
      end

      @curl
    end

    def parsers
      [ UrlParser.new,
        OptionParser.new('-v'),
        ParamParser.new('-X'),
        ParamParser.new('--data'),
        HeaderParser.new('--header')
      ]
    end
  end
end
