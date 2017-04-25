require 'spec_helper'

RSpec.describe Duck do
  describe '::load' do
    it 'loads curl from give filepath' do
      curl_path = './spec/curls/get_users.sh'
      curl = Duck.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq "curl https://jsonplaceholder.typicode.com/users"
    end

    it 'parses -X option' do
      curl_path = './spec/curls/post_users.sh'
      curl = Duck.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq(
        "curl https://jsonplaceholder.typicode.com/users\\\n"\
        "  -v\\\n"\
        "  -X POST")
    end

    it 'parses -v option and --header option' do
      curl_path = './spec/curls/protected_ping.sh'
      curl = Duck.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq(
        "curl localhost:3000/api/v1/ping/protected_ping.json\\\n"\
        "  -v\\\n"\
        "  --header \"Content-Type: application/json; charset=utf-8\"")
    end

    it 'parses all --header options' do
      curl_path = './spec/curls/multiple_headers.sh'
      curl = Duck.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq(
        "curl localhost:3000/api/v1/ping/protected_ping.json\\\n"\
        "  -v\\\n"\
        "  --header \"Content-Type: application/json; charset=utf-8\"\\\n"\
        "  --header \"X-Auth-Email: pdonat@seznam.cz\"\\\n"\
        "  --header \"X-Auth-Token: JAaVvDYHCpig0L4PhGjhPx5oHwMisK_gt1SK3g5tJyLUHrp5kycbWpDf2U4X5bY6Ul4\"")
    end
  end

  describe '#request_type' do
    it 'returns :get for get requests' do
      curl = Duck.load './spec/curls/get_users.sh'

      expect(curl.request_type).to eq :get
    end
  end
end
