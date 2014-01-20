require 'json'

module Transmogriffy
  class Lighthouse
    attr_reader :lighthouse_path

    def initialize(options)
      @lighthouse_path = options[:lighthouse_path]
    end

    def milestones
      @milestones ||= load_milestones!
    end

    def load_milestones!
      milestone_path = File.join(lighthouse_path, 'milestones')

      # Counter for the milestone number.
      idx = 0

      Dir.open(milestone_path).inject([]) do |list, filename|
        next list if File.directory?(filename)

        milestone = JSON.parse(File.read(File.join(milestone_path, filename)))['milestone']

        list << {
          :number => idx++,
          :title => milestone['title'],
          :description => milestone['goals'],
          :due_on => milestone['due_on'],
          :created_at => milestone['created_at'],
          :state => milestone['completed_at'] ? 'closed' : 'open'
        }

        list
      end
    end

    def tickets
      @tickets ||= load_tickets!
    end

    def load_tickets!
      ticket_path = File.join(lighthouse_path, 'tickets')

      Dir.open(ticket_path).inject([]) do |list, folder|
        next list unless folder.match(/\d+-/)

        ticket = JSON.parse(File.read(File.join(ticket_path, folder, 'ticket.json')))['ticket']

        first_version = ticket['versions'].shift

        comments = ticket['versions'].map do |version|
            {
              :user => version['user_name'],
              :body => version['body'],
              :created_at => version['created_at'],
              :updated_at => version['updated_at']
            }
          end

        list << {
          :number => ticket['number'],
          :title => ticket['title'],
          :user => ticket['user_name'],
          :assignee => ticket['assigned_user_name'],
          :milestone => ticket['milestone_title'],
          :labels => (ticket['tag'] || '').split(' ').push(ticket['state']),
          :state => ['closed', 'resolved', 'invalid'].include?(ticket['state']) ? 'closed' : 'open',
          :body => first_version['body'],
          :comments => comments
        }

        list.sort_by! { |t| t[:number] }
      end
    end
  end
end
