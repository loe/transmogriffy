require 'transmogriffy/version'
require 'transmogriffy/lighthouse'
require 'transmogriffy/github'

module Transmogriffy
  class Migrator
    
    def initialize
      @l = Transmogriffy::Lighthouse.new(:lighthouse_export_path => ENV['LIGHTHOUSE_EXPORT_PATH'])
      @g = Transmogriffy::Github.new(:github_token => ENV['GITHUB_TOKEN'], :github_repo => ENV['GITHUB_REPO'])
    end

    def migrate!
      @l.milestones.each do |m|
        @g.create_milestone(m)
      end

      @l.tickets.each do |t|
        @g.create_issue(t)
      end
    end
  end
end
