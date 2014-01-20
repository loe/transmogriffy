require_relative 'test_helper'

class GithubTest < Minitest::Test
  def setup
    @g = Transmogriffy::Github.new(:github_path => ENV['GITHUB_PATH'])
  end

  def teardown
    FileUtils.rmdir([@g.milestones_path, @g.issues_path])
  end

  def test_options
    assert @g.github_path
  end

  def milestone
    {
      :number => 1,
      :title => 'The Title',
      :description => 'The Description',
      :due_on => Time.now,
      :created_at => Time.now,
      :state => 'open'
    }
  end

  def issue
    {
      
    }
  end

  def test_create_milestone
    @g.create_milestone(milestone)
    m = JSON.parse(File.read(@g.milestone_path(milestone[:number])))
    refute_empty m['title']
  end

end
