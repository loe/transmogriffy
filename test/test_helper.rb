require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

require File.expand_path('../../lib/transmogriffy', __FILE__)

VCR.configure do |c|
  c.default_cassette_options = {
    :decode_compressed_response => true
  }

  c.filter_sensitive_data("<<ACCESS_TOKEN>>") do
    test_github_token
  end

  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

def test_github_token
  ENV['GITHUB_TOKEN']
end
