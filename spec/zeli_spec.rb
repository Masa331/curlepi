require 'spec_helper'

RSpec.describe Zeli do
  describe '::load' do
    it 'loads curl from give filepath' do
      curl_path = './spec/curls/get_users.sh'
      curl = Zeli.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq "curl https://jsonplaceholder.typicode.com/users"
    end

    it 'parses -X option' do
      curl_path = './spec/curls/post_users.sh'
      curl = Zeli.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq(
        "curl https://jsonplaceholder.typicode.com/users\\\n"\
        "  -v\\\n"\
        "  -X POST")
    end

    it 'parses -v option and --header option' do
      curl_path = './spec/curls/protected_ping.sh'
      curl = Zeli.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq(
        "curl localhost:3000/api/v1/ping/protected_ping.json\\\n"\
        "  -v\\\n"\
        "  --header \"Content-Type: application/json; charset=utf-8\"")
    end

    it 'parses all --header options' do
      curl_path = './spec/curls/multiple_headers.sh'
      curl = Zeli.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq(
        "curl localhost:3000/api/v1/ping/protected_ping.json\\\n"\
        "  -v\\\n"\
        "  --header \"Content-Type: application/json; charset=utf-8\"\\\n"\
        "  --header \"X-Auth-Email: pdonat@seznam.cz\"\\\n"\
        "  --header \"X-Auth-Token: JAaVvDYHCpig0L4PhGjhPx5oHwMisK_gt1SK3g5tJyLUHrp5kycbWpDf2U4X5bY6Ul4\"")
    end

    it 'parses --data param' do
      curl_path = './spec/curls/create_document.sh'
      curl = Zeli.load curl_path
      plain_curl = File.read curl_path

      expect(curl.to_s).to eq(
        "curl http://localhost:3000/api/v1/documents.json\\\n"\
        "  -v\\\n"\
        "  --data \"{\\\"description\\\":\\\"data\\\"}\"")
    end
  end

  describe '#request_type' do
    it 'returns :get for get requests' do
      curl = Zeli.load './spec/curls/get_users.sh'

      expect(curl.request_type).to eq :get
    end

    it 'returns :post for post requests' do
      curl = Zeli.load './spec/curls/post_users.sh'

      expect(curl.request_type).to eq :post
    end
  end

  describe '#data' do
    it 'returns nil if --data params is missing' do
      curl = Zeli.load './spec/curls/get_users.sh'

      expect(curl.data).to eq nil
    end

    it 'returns data if --data params is present' do
      curl = Zeli.load './spec/curls/create_document.sh'

      expect(curl.data).to eq "\"{\\\"description\\\":\\\"data\\\"}\""
    end
  end
end
