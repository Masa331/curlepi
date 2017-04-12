require 'spec_helper'

RSpec.describe Curl do
  describe '::load' do
    it 'loads curl from give filepath' do
      curl = Curl.load('/home/masa331/pracovni/code/ruby/curlepi/spec/curls/get_users.sh')

      expect(curl.to_s).to eq "curl https://jsonplaceholder.typicode.com/users"
    end

    it 'parses -X option' do
      curl = Curl.load('/home/masa331/pracovni/code/ruby/curlepi/spec/curls/post_users.sh')

      expect(curl.to_s)
        .to eq "curl https://jsonplaceholder.typicode.com/users\\\n-X POST"
    end

    it 'parses -v option and all --header options' do
      curl = Curl.load('/home/masa331/pracovni/code/ruby/curlepi/spec/curls/protected_ping.sh')

      expect_response = "curl localhost:3000/api/v1/ping/protected_ping.json\\\n"\
          "--header \"Content-Type: application/json; charset=utf-8\"\\\n"\
          "--header \"X-Auth-Email: pdonat@seznam.cz\"\\\n"\
          "--header \"X-Auth-Token: JAaVvDYHCpig0L4PhGjhPx5oHwMisK_gt1SK3g5tJyLUHrp5kycbWpDf2U4X5bY6Ul4\"\\\n"\
          "-v".split.sort.join(' ')

      expect(curl.to_s.split.sort.join(' '))
        .to eq expected_response
    end
  end
end
