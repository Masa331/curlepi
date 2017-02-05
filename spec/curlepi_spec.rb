require "spec_helper"

describe Curlepi do
  describe '::from_string' do
    it 'parses string as curl and returns instance of Curl' do
      curl = Curlepi.from_string('curl https://jsonplaceholder.typicode.com/users')

      expect(curl).to be_an_instance_of Curlepi::Curl

    end
  end

  xdescribe '::from_file' do
    it 'loads file as curl and returns instance of Curl' do
      curl = Curlepi.from_file('./spec/fixtures/get_users.sh')

      expect(curl).to be_an_instance_of Curlepi::Curl
    end
  end
end
