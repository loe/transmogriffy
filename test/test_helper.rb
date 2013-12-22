require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

require File.expand_path('../../lib/transmogriffy', __FILE__)

VCR.configure do |c|
  c.cassette_library_dir = 'cassettes'
  c.hook_into :webmock
end
