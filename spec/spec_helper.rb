$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'duck'
require 'rspec/expectations'

RSpec::Matchers.define :match_curl do |expected|
  match do |actual|
    expected = normalize(expected)
    actual = normalize(actual)

    expected == actual
  end

  def normalize(string)
    string.split(/\s/).sort.reject { |l| l == "" }.map do |line|
      if line.end_with? '\\'
        line[0..-2]
      else
        line
      end
    end
  end
end
