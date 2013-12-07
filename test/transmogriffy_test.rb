require_relative 'test_helper'

class ImporterTest < Minitest::Test
  def setup
    @i = Transmogriffy::Importer.new(:lighthouse_export_path => './americano')
  end

  def test_it_should_accept_options
    assert @i.lighthouse_export_path
  end
end
