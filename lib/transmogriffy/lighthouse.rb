module Transmogriffy
  class Lighthouse
    attr_reader :path, :user_map

    def initialize(options)
      @path = options[:path]
      @user_map = JSON.parse(File.read(options[:user_map_path]))
    end

    def milestones
      @milestones ||= load_milestones!
    end

    def load_milestones!
      milestone_path = File.join(path, 'milestones')

      # Counter for the milestone number.
      idx = 1

      Dir.open(milestone_path).inject([]) do |list, filename|
        next list if File.directory?(filename)

        milestone = JSON.parse(File.read(File.join(milestone_path, filename)))['milestone']

        list << {
          :number => idx,
          :title => milestone['title'],
          :description => milestone['goals'],
          :due_on => milestone['due_on'],
          :created_at => milestone['created_at'],
          :state => milestone['completed_at'] ? 'closed' : 'open'
        }

        idx = idx + 1

        list
      end
    end

    def tickets
      @tickets ||= load_tickets!
    end

    def load_tickets!
      ticket_path = File.join(path, 'tickets')

      Dir.open(ticket_path).inject([]) do |list, folder|
        next list unless folder.match(/\d+-/)

        ticket = JSON.parse(File.read(File.join(ticket_path, folder, 'ticket.json')))['ticket']

        first_version = ticket['versions'].shift

        comments = ticket['versions'].inject([]) do |m, version|
          if !version['body'].nil? && version['body'] != ''
            m << {
              :user => find_username_for_name(version['user_name']),
              :body => version['body'],
              :created_at => version['created_at'],
              :updated_at => version['updated_at']
            }
          end

          m
        end


        list << {
          :number => ticket['number'],
          :title => ticket['title'],
          :user => find_username_for_name(ticket['user_name']),
          :assignee => find_username_for_name(ticket['assigned_user_name']),
          :milestone => find_milestone_id_by_title(ticket['milestone_title']),
          :labels => (ticket['tag'] || '').split(' ').push(ticket['state']),
          :state => ['closed', 'resolved', 'invalid'].include?(ticket['state']) ? 'closed' : 'open',
          :body => first_version['body'],
          :comments => comments
        }

        list.sort_by! { |t| t[:number] }
      end
    end

    def find_username_for_name(field)
      usermap[field] ? usermap[field] : field
    end

    def find_milestone_id_by_title(title)
      if m = milestones.find { |m| m[:title] == title }
        m[:number]
      else
        nil
      end
    end
  end
end
