require 'spec_helper'

RSpec.describe Curlepi::Curl do
  describe '#to_s' do
    it 'outputs parsed curl back to string' do
      curl = Curlepi::Curl.new('./spec/fixtures/get_users.sh')

      expect(curl.to_s).to eq "curl https://jsonplaceholder.typicode.com/users"
    end
  end

  describe '#url' do
    it "returns curl's url" do
      curl = Curlepi::Curl.new('./spec/fixtures/get_users.sh')

      expect(curl.url).to eq "https://jsonplaceholder.typicode.com/users"
    end
  end
end
