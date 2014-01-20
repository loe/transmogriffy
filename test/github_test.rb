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
      :number => 1,
      :title => 'The Issue',
      :body => 'Hello',
      :comments => [
        {
          :user => 'W. Andrew Loe III',
          :body => 'commenting.'
        }
      ]
    }
  end

  def test_create_milestone
    @g.create_milestone(milestone)
    m = JSON.parse(File.read(@g.milestone_path(milestone[:number])))
    refute_empty m['title']
  end

  def test_create_issue
    @g.create_issue(issue)
    i = JSON.parse(File.read(@g.issue_path(issue[:number])))
    refute_empty i['title']
  end

  def test_create_comment
    @g.create_issue(issue)
    c = JSON.parse(File.read(@g.issue_comments_path(issue[:number])))
    refute_empty c.first['body']
  end
end
