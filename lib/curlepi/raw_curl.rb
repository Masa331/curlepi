module Curlepi
  class RawCurl
    def initialize(string)
      @string = string
    end

    def url
      require 'pry'; binding.pry
      ''
    end

    def options
      []
    end
  end
end
