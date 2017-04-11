class Curl
  class Parser
    class Parser
      def initialize(string, option)
        @string = string
        @option = option
      end

      def matches?
        string.includes? option
      end

      def value
        'hovno'
      end

      def method_name
        option.delete('-')
      end
    end

    class UrlParser
      def initialize(string)
        @string = string
      end

      def matches?
        @string.include?('http://') || @string.include?('https://')
      end

      def url
        value = @string.slice(/https?:\/\/.*(?=\s)/)
        value = value[0..-2] if value.end_with?('\\')

        value
      end
    end

    OPTIONS = []

    def initialize(raw_curl, curl)
      @raw_curl = raw_curl
      @curl = curl
    end

    def go!
      options.each do |option|
        parser = Parser.new(@raw_curl, option)

        if parser.matches?
          @curl.send(parser.method_name, parser.value)
        end
      end

      url_parser = UrlParser.new(@raw_curl)
      if url_parser.matches?
        @curl.url = url_parser.url
      end

      @curl
    end

    def options
      OPTIONS
    end
  end
end
