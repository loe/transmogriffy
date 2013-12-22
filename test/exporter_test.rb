require_relative 'test_helper'

class ExporterTest < Minitest::Test
  def setup
    @e = Transmogriffy::Exporter.new(:github_token => ENV['GITHUB_TOKEN'], :github_repo => ENV['GITHUB_REPO'])
  end

  def test_options
    VCR.use_cassette('github') do
      assert @e.repo
    end
  end

  def test_loading_milestones
    VCR.use_cassette('github') do
      refute_empty @e.milestones
    end
  end
end
