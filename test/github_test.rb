require_relative 'test_helper'

class GithubTest < Minitest::Test
  def setup
    @g = Transmogriffy::Github.new(:github_token => ENV['GITHUB_TOKEN'], :github_repo => ENV['GITHUB_REPO'])
  end

  def test_options
    assert @g.repo
  end

  def test_loading_milestones
    VCR.use_cassette('milestones') do
      refute_empty @g.milestones
    end
  end

  def test_loading_issues
    VCR.use_cassette('issues') do
      refute_empty @g.issues
    end
  end
end
