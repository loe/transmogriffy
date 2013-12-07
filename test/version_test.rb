require_relative 'test_helper'

class VersionTest < Minitest::Test
  def test_version_is_present
    assert Transmogriffy::VERSION
  end
end
