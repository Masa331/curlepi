class Duck
  class Parser
    class ParamParser
      def initialize(option)
        @option = option
      end

      def parse!(raw_curl, curl)
        @raw_curl = raw_curl
        @curl = curl

        value.each do |value|
          @curl.options << Duck::Option.new(@option, value)
        end

        @curl
      end

      private

      def value
        result = @raw_curl.scan(/\s#{@option}\ (.*)(\\)(\s?)/)

        result.map &:first
      end
    end
  end
end
