class Duck
  class Parser
    class HeaderParser
      def initialize(option)
        @option = option
      end

      def parse!(raw_curl, curl)
        @raw_curl = raw_curl
        @curl = curl

        @curl.headers.merge!(headers)
      end

      def value
        result = @raw_curl.scan(/\s#{@option}\ (.*)(\\)(\s?)/)
        result.map &:first
      end

      def headers
        value.map do |header|
          k, v = header.split(': ')
          k = k[1..-1] if k.start_with? '"'
          v = v[0..-2] if v.end_with? '"'

          [k, v]
        end.to_h
      end
    end
  end
end
