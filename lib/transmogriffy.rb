require "transmogriffy/version"

module Transmogriffy
  class Importer
    attr_reader :lighthouse_export_path

    def initialize(options)
      @lighthouse_export_path = options[:lighthouse_export_path]
    end
  end
end
