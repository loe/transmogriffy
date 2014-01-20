require_relative 'test_helper'

class LighthouseTest < Minitest::Test
  def setup
    @l = Transmogriffy::Lighthouse.new(:path => ENV['LIGHTHOUSE_PATH'], :user_map_path => ENV['GITHUB_USER_MAP_PATH'])
  end

  def test_options
    assert @l.path
  end

  def test_loading_milestones
    refute_empty @l.milestones
  end

  def test_each_milestone_has_a_title
    @l.milestones.each do |m|
      refute_empty m[:title]
    end
  end

  def test_each_milestone_has_a_number
    @l.milestones.each do |m|
      refute_nil m[:number]
    end
  end

  def test_loading_tickets
    refute_empty @l.tickets
  end

  def test_each_ticket_has_a_title
    @l.tickets.each do |t|
      refute_empty t[:title]
    end
  end

  def test_each_ticket_has_a_state
    @l.tickets.each do |t|
      assert ['open', 'closed'].include?(t[:state])
    end
  end

  def test_each_ticket_has_a_user
    @l.tickets.each do |t|
      refute_empty t[:user]
    end
  end
end
