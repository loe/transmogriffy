module Transmogriffy
  class Github
    attr_reader :github_path, :milestones_path, :issues_path

    def initialize(options)
      @github_path = options[:github_path]
      @milestones_path = File.join(github_path, 'milestones')
      @issues_path = File.join(github_path, 'issues')

      # Ensure the directories exist.
      FileUtils.mkdir_p(milestones_path)
      FileUtils.mkdir_p(issues_path)
    end

    def create_milestone(options)
      File.open(milestone_path(options[:number]), 'w+') { |f| f.write(options.to_json) }
    end

    def create_issue(options)
      comments = options.delete(:comments)
      File.open(issue_path(options[:number]), 'w+') { |f| f.write(options.to_json) }
      File.open(issue_comments_path(options[:number]), 'w+') { |f| f.write(comments.to_json) }
    end

    def milestone_path(id)
      File.join(milestones_path, "#{id}.json")
    end

    def issue_path(id)
      File.join(issues_path, "#{id}.json")
    end

    def issue_comments_path(id)
      File.join(issues_path, "#{id}.comments.json")
    end
  end
end
