require "curlepi/version"
require "curlepi/curl"
require "curlepi/raw_curl"

module Curlepi
  def self.from_string(curl)
    curl_string = RawCurl.new(curl)

    Curl.new(curl_string.url, curl_string.options)
  end
end
