require_relative 'test_helper'

class ImporterTest < Minitest::Test
  def setup
    @i = Transmogriffy::Importer.new(:lighthouse_export_path => ENV['LIGHTHOUSE_EXPORT_PATH'])
  end

  def test_it_should_accept_options
    assert @i.lighthouse_export_path
  end

  def test_it_should_load_milestones
    refute_empty @i.milestones
  end
end
