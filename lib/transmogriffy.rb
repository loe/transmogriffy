require 'json'
require 'active_support'
require 'active_support/core_ext'
require 'transmogriffy/version'
require 'transmogriffy/lighthouse'
require 'transmogriffy/github'

module Transmogriffy
  class Migrator
    
    def initialize
      @l = Transmogriffy::Lighthouse.new(:path => ENV['LIGHTHOUSE_PATH'], :user_map_path => ENV['GITHUB_USER_MAP_PATH'])
      @g = Transmogriffy::Github.new(:path => ENV['GITHUB_PATH'])
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
