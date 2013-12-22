require 'octokit'

module Transmogriffy
  class Exporter
    attr_reader :github_client

    def initialize(options)
      @github_client = Octokit::Client.new(:oauth_token => options[:github_token])
    end

    def milestones
      ['hi']
    end
  end
end
