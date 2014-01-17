require 'octokit'

module Transmogriffy
  class Github
    attr_reader :client, :repo

    def initialize(options)
      Octokit.auto_paginate = true
      @client = Octokit::Client.new(:access_token => options[:github_token])
      @repo = Octokit::Repository.new(options[:github_repo])
    end

    def milestones
      @milestones ||= load_milestones!
    end

    def load_milestones!
      # Somewhat annoying that you must define a state or Github only returns
      # milestones.
      @client.list_milestones(@repo, :state => 'open', :sort => 'created', :direction => 'asc').concat(@client.list_milestones(@repo, :state => 'closed', :sort => 'created', :direction => 'asc'))
    end

    def issues
      @issues ||= load_issues!
    end

    def load_issues!
      # Somewhat annoying that you must define a state or Github only returns
      # issues.
      @client.list_issues(@repo, :state => 'open', :sort => 'created', :direction => 'asc').concat(@client.list_issues(@repo, :state => 'open', :sort => 'created', :direction => 'asc'))
    end

    def user_map
      {
        "W. Andrew Loe III" => 'loe',
        "Matthew Anderson" => 'WanderingMatt',
        "Leigh Caplan" => 'texel',
        "Brandon Caplan" => 'bcaplan',
        "Brian Moran" => 'bmo',
        "Charles Mount" => 'cmount'
      }
    end

    def create_milestone(options)
      title = options.delete(:title)

      unless milestones.map(&:title).include?(title)
        puts "Creating milestone: #{title}"
        @client.create_milestone(@repo, title, options)
      end
    end

    def create_issue(options)
      title = options.delete(:title)

      unless issues.map(&:title).include?(title)
        versions = options.delete(:versions)
        state = options.delete(:state)
        
        # Extract the first version and use that as the body.
        body = versions.first[:body]

        # Find the milestone id by its title.
        if m = milestones.find { |m| m.title == options[:milestone] }
          options[:milestone] = m[:number]
        else
          options.delete(:milestone)
        end

        # Find the assignee id by their name.
        options[:assignee] = user_map[options[:assignee]]

        puts "Creating issue: #{title}"
        issue = @client.create_issue(@repo, title, body, options)

        # Append subsequent versions as comments on the issue.
        versions.each do |v|
          if !v[:body].nil? && v[:body] != ""
            b = "#{v[:creator_name]}:\n#{v[:body]}"
            @client.add_comment(@repo, issue[:number], b)
          end
        end

        # Close the issue if necessary
        if state == 'closed'
          @client.close_issue(@repo, issue[:number])
        end
      end
    end
  end
end
