require_relative 'test_helper'

class ExporterTest < Minitest::Test
  def setup
    @e = Transmogriffy::Exporter.new(:github_token => ENV['GITHUB_TOKEN'], :github_repo => ENV['GITHUB_REPO'])
  end

  def test_options
    assert @e.repo
  end

  def test_loading_milestones
    VCR.use_cassette('milestones') do
      refute_empty @e.milestones
    end
  end

  def test_loading_issues
    VCR.use_cassette('issues') do
      refute_empty @e.issues
    end
  end
end
