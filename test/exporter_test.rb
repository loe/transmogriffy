require_relative 'test_helper'

class ExporterTest < Minitest::Test
  def setup
    @e = Transmogriffy::Exporter.new(:github_token => ENV['GITHUB_TOKEN'], :repo => ENV['GITHUB_REPO'])
  end

  def test_options
    assert @e.github_client
  end

  def test_loading_milestones
    refute_empty @e.milestones
  end
end
