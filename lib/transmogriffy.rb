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

    def tickets
      @tickets ||= load_tickets!
    end

    def load_tickets!
      ticket_path = File.join(lighthouse_export_path, 'tickets')

      Dir.open(ticket_path).inject([]) do |list, filename|
        ticket = JSON.parse(File.read(File.join(ticket_path, filename, 'ticket.json')))['tickets']

        list << {:title => ticket['title'], :body => ticket['body'], :assignee => ticket['assigned_user_name'] || ticket['creator_name'], :milestone => ticket['milestone_title']}

        list
      end
    end
  end
end
