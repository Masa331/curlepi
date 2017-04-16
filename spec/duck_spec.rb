require 'spec_helper'

RSpec.describe Duck do
  describe '::load' do
    it 'loads curl from give filepath' do
      curl_path = '/home/masa331/pracovni/code/ruby/curlduck/spec/curls/get_users.sh'
      curl = Duck.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to match_curl(plain_curl)
    end

    it 'parses -X option' do
      curl_path = '/home/masa331/pracovni/code/ruby/curlduck/spec/curls/post_users.sh'
      curl = Duck.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to match_curl(plain_curl)
    end

    it 'parses -v option and --header option' do
      curl_path = '/home/masa331/pracovni/code/ruby/curlduck/spec/curls/protected_ping.sh'
      curl = Duck.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to match_curl(plain_curl)
    end

    it 'parses all --header options' do
      curl_path = '/home/masa331/pracovni/code/ruby/curlduck/spec/curls/multiple_headers.sh'
      curl = Duck.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to match_curl(plain_curl)
    end
  end
end
