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
  end
end
