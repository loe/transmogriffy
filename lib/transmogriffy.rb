require 'transmogriffy/version'
require 'json'

module Transmogriffy
  class Importer
    attr_reader :lighthouse_export_path
    attr_accessor :milestones

    def initialize(options)
      @lighthouse_export_path = options[:lighthouse_export_path]

      # Switch to the directory, we'll work relatively from here on.
      Dir.chdir(lighthouse_export_path)
    end

    def milestones
      @milestones ||= load_milestones!
    end

    def load_milestones!
      milestone_path = File.join(lighthouse_export_path, 'milestones')

      Dir.open(milestone_path).inject([]) do |list, filename|
        next list if File.directory?(filename)

        milestone = JSON.parse(File.read(File.join(milestone_path, filename)))['milestone']

        list << {:title => milestone['title'], :description => milestone['goals'], :due_on => milestone['due_on'], :state => milestone['completed_at'] ? 'closed' : 'open'}

        list
      end
    end
  end
end
