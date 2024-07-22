require 'singleton'
require 'date'
require_relative 'calendar'

#  UserInterface is a singleton class that provides methods to interact with the user through the command line for managing calendar events.
class UserInterface
  include Singleton

  def show_main_menu
    system(`clear`)
    puts "\nCalender Menu"
    puts '1. Add Event'
    puts '2. Show Events List'
    puts '3. Edit Event'
    puts '4. Delete Event'
    puts '5. Month View'
    puts '6. Month Events'
    puts '7. Exit'
  end

  def get_date
    print 'Enter date (YYYY-MM-DD): '
    Date.parse(gets.chomp)
  rescue Date::Error
    puts 'Please enter valid date: '
    retry
  end

  def input_and_check_uniqueness_of_title(date)
    loop do
      print 'Enter title: '
      title = gets.chomp
      if title.empty?
        print "Title cannot be empty.\n"
      elsif Calendar.instance.invalid_event(date, title)
        print "Event with same title exists.\n"
      else
        return title
      end
    end
  end

  def get_year
    loop do
      print 'Enter year (YYYY): '
      year = gets.chomp

      return year.to_i if year.match?(/^\d+/)

      puts 'Please enter valid year'
    end
  end

  def get_month
    loop do
      print 'Enter month (MM): '
      month = gets.chomp.to_i
      return month if (1..12).to_a.include?(month)

      puts 'Please enter valid month'
    end
  end

  def list_events(events)
    if events.empty?
      puts 'No event to show'
    else
      events.each { |event| display_event(event) }
    end
  end

  def input_and_validate_title(events)
    loop do
      print 'Enter the title of the event: '
      title = gets.chomp
      return title if event_exists?(events, title)

      puts 'No such event exists. Please enter a valid title: '
    end
  end

  def month_view(year, month, events)
    first_day = Date.new(year, month, 1)
    last_day = Date.new(year, month, -1)
    dates = (first_day..last_day).to_a

    puts "\n                        #{Date::MONTHNAMES[month]} #{year}\n"
    puts 'Su       Mo       Tu       We       Th       Fr       Sa'
    print '         ' * dates[0].wday
    dates.each do |date|
      result = date.day.to_s
      no_of_events = events[date.day]&.length
      result += " (#{no_of_events})" if no_of_events != 0
      print result.ljust(9)
      print "\n" if date.saturday?
    end
  end

  def list_month_events(year, month, events)
    if events.empty?
      puts 'No event to show'
    else
      events.each do |key, val|
        next if val.empty?

        puts "#{Date.new(year, month, key)} has the following events"

        val.each do |event|
          display_event(event)
        end
      end
    end
  end

  private

  def event_exists?(events, title)
    events.any? { |event| event.title == title }
  end

  def display_event(event)
    puts "\nTitle: #{event.title}"
    puts "Description: #{event.description}\n"
    puts '-' * 40
  end
end
