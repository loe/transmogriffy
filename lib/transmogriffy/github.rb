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
      puts "Creating milestone: ##{options[:number]}: #{options[:title]}"
      File.open(File.join(milestones_path, "#{options[:number]}.json"), 'w+') { |f| f.write(options.to_json) }
    end

    def create_issue(options)
      puts "Creating issue: ##{options[:number]}: #{options[:title]}"
      comments = options.delete(:comments)
      File.open(File.join(issues_path, "#{options[:number]}.json"), 'w+') { |f| f.write(options.to_json) }
      File.open(File.join(issues_path, "#{options[:number]}.comments.json"), 'w+') { |f| f.write(comments.to_json) }
    end
  end
end
