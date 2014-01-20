require 'transmogriffy/version'
require 'transmogriffy/lighthouse'
require 'transmogriffy/github'

module Transmogriffy
  class Migrator
    
    def initialize
      @l = Transmogriffy::Lighthouse.new(:lighthouse_path => ENV['LIGHTHOUSE_PATH'])
      @g = Transmogriffy::Github.new(:github_path => ENV['GITHUB_PATH'])
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
