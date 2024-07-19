require 'singleton'

class UserInterface
    include Singleton

    def get_date
        begin
            print "Enter date (YYYY-MM-DD): "
            date=Date.parse(gets.chomp)
        rescue Date::Error
            puts "Please enter valid date: "
            retry
        end

        return date
    end

    
    private def display_event(event)
        puts "\nTitle: #{event.title}"
        puts "Description: #{event.description}\n"
        puts "-"*40
    end

    def list_events(events)
        if !(events.empty?())
            events.each do |event|
                display_event(event)
            end
        else
            puts "No event to show"
        end
    end

    private def event_exists?(events,title)
        events.any? {|event| event.title==title}
    end

    def get_event_title(events)
        title=nil
        loop do
            print "Enter the title of the event: "
            title=gets.chomp
            if !(event_exists?(events,title))
                puts "No such event exists. Please enter a valid title: "
            else
                break
            end
        end
        return title
    end

end
