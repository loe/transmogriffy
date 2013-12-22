require_relative 'test_helper'

class ImporterTest < Minitest::Test
  def setup
    @i = Transmogriffy::Importer.new(:lighthouse_export_path => ENV['LIGHTHOUSE_EXPORT_PATH'])
  end

  def test_options
    assert @i.lighthouse_export_path
  end

  def test_loading_milestones
    refute_empty @i.milestones
  end

  def test_each_milestone_has_a_title
    @i.milestones.each do |m|
      refute_empty m[:title]
    end
  end

  def test_loading_tickets
    refute_empty @i.tickets
  end

  def test_each_ticket_has_a_title
    @i.tickets.each do |t|
      refute_empty t[:title]
    end
  end

  def test_each_ticket_has_a_state
    @i.tickets.each do |t|
      assert ['open', 'closed'].include?(t[:state])
    end
  end

  def test_each_ticket_has_an_assignee
    @i.tickets.each do |t|
      refute_empty t[:assignee]
    end
  end
end
