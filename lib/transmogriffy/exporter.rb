require 'octokit'

module Transmogriffy
  class Exporter
    attr_reader :client, :repo

    def initialize(options)
      @client = Octokit::Client.new(:access_token => options[:github_token])
      @repo = Octokit::Repository.new(options[:github_repo])
    end

    def milestones
      @milestones ||= load_milestones!
    end

    def load_milestones!
      @client.list_milestones(@repo)
    end
  end
end
