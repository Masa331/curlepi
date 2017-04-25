class Zeli
  class Parser
    class OptionParser
      def initialize(option)
        @option = option
      end

      def parse!(raw_curl, curl)
        @raw_curl = raw_curl
        @curl = curl

        if matches?
          @curl.options << Zeli::Option.new(@option, nil)
        end

        @curl
      end

      def matches?
        @raw_curl.include? @option
      end
    end
  end
end
