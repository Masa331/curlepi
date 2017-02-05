module Curlepi
  class Curl
    attr_accessor :url, :options

    def initialize(url, options)
      @url = url
      @options = options
    end

    def to_s
      @original_raw_curl
    end
  end
end
