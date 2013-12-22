require 'minitest/autorun'
require 'vcr'
require File.expand_path('../../lib/transmogriffy', __FILE__)

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/cassettes'
  c.hook_into :faraday # Octokit is built on faraday.
end
