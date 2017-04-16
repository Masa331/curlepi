class Duck
  class Parser
    class ParamMatcher
      def initialize(string, option)
        @string = string
        @option = option
      end

      def matches?
        @string.include? @option
      end

      def value
        result = @string.scan(/(?<=\s#{@option}\ ).*(?=\s)/)

        result.map do |res|
          if !res.nil? && res.end_with?('\\')
            res[0..-2] 
          else
            res
          end
        end
      end

      def option_name
        @option
      end
    end

    class OptionMatcher
      def initialize(string, option)
        @string = string
        @option = option
      end

      def matches?
        @string.include? @option
      end

      def value
        [nil]
      end

      def option_name
        @option
      end
    end

    class UrlParser
      def initialize(string)
        @string = string
      end

      def matches?
        @string.include?('http://') ||
          @string.include?('https://') ||
          @string.include?('https://')
      end

      def value
        value = @string.slice(/(https:\/\/|http:\/\/|localhost:).*(?=\s)/)
        value = value[0..-2] if !value.nil? && value.end_with?('\\')

        value
      end

      def option_name
        :url
      end
    end

    def initialize(raw_curl, curl)
      @raw_curl = raw_curl
      @curl = curl
    end

    def go!
      url_matcher = UrlParser.new(@raw_curl)
      @curl.send("#{url_matcher.option_name}=", url_matcher.value)

      matchers.each do |matcher|
        if matcher.matches?
          matcher.value.each do |value|
            @curl.options << Duck::Option.new(matcher.option_name, value)
          end
        end
      end

      @curl
    end

    def matchers
      [ OptionMatcher.new(@raw_curl, '-v'),
        ParamMatcher.new(@raw_curl, '-X'),
        ParamMatcher.new(@raw_curl, '--header')
      ]
    end
  end
end
