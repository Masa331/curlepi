class Zeli
  class Parser
    class UrlParser
      def parse!(raw_curl, curl)
        @raw_curl = raw_curl
        @curl = curl

        @curl.url = value
      end

      private

      def value
        value = @raw_curl.slice(/(https:\/\/|http:\/\/|localhost:).*(?=\s)/)
        value = value[0..-2] if !value.nil? && value.end_with?('\\')

        URI(value)
      end
    end
  end
end
