require 'singleton'
require 'date'

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

    def get_year
        loop do
            print "Enter year (YYYY): "
            year = gets.chomp

            if year.match?(/^\d{4}/)
                return year.to_i
            else
                puts "Please enter valid year"
            end
        end
    end

    def get_month
        loop do
            print "Enter month (MM): "
            month = gets.chomp

            if (1..12).include?(month.to_i)
                return month.to_i
            else
                puts "Please enter valid month"
            end
        end
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


    def month_view(year, month,events)
        first_day=Date.new(year,month,1)
        last_day=Date.new(year,month,-1)

        
        dates=(first_day..last_day).to_a

        puts ""
        puts "      #{Date::MONTHNAMES[month]} #{year}"
        puts ""
        puts "Su     Mo     Tu     We     Th     Fr     Sa"
        print "       "*dates[0].wday
        dates.each do |date|
            # print "       "*
            result=date.day.to_s
            no_of_events=events[date.day]&.length
            result += "(#{no_of_events})" if no_of_events!=0
            print result.rjust(2," ")
            print "     "
            print "\n" if date.saturday?
        end
    end
end
