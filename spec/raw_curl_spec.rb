require 'spec_helper'

RSpec.describe Curlepi::RawCurl do
  describe '#url' do
    it 'returns url from string' do
      curl = Curlepi::RawCurl.new('curl https://jsonplaceholder.typicode.com/users')

      expect(curl.url).to eq "https://jsonplaceholder.typicode.com/users"
    end
  end
end
