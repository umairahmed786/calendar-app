require "singleton"
require "date"
require_relative 'calendar.rb'

class UserInterface
  include Singleton

  def get_date
    begin
      print "Enter date (YYYY-MM-DD): "
      date = Date.parse(gets.chomp)
    rescue Date::Error
      puts "Please enter valid date: "
      retry
    end

    return date
  end

  def get_new_title(date)
    title=nil
    loop do
      print "Enter title: "
      title = gets.chomp
      if title.empty?
        print "Title cannot be empty.\n"
      elsif Calendar.instance.validate_event(date, title)
        print "Event with same title exists.\n"
      else
        return title
      end
    end
  end

  def get_year
    loop do
      print "Enter year (YYYY): "
      year = gets.chomp

      if year.match?(/^\d+/)
        return year.to_i
      else
        puts "Please enter valid year"
      end
    end
  end

  def get_month
    loop do
      print "Enter month (MM): "
      month = gets.chomp.to_i

      if (1..12).to_a.include?(month)
        return month
      else
        puts "Please enter valid month"
      end
    end
  end


  def list_events(events)
    unless events.empty?()
      events.each {|event| display_event(event)}
    else
      puts "No event to show"
    end
  end

  

  def input_valid_event_title(events)
    title = nil
    loop do
      print "Enter the title of the event: "
      title = gets.chomp
      unless event_exists?(events, title)
        puts "No such event exists. Please enter a valid title: "
      else
        return title
      end
    end
  end

  def month_view(year, month, events)
    first_day = Date.new(year, month, 1)
    last_day = Date.new(year, month, -1)

    dates = (first_day..last_day).to_a

    puts "\n                        #{Date::MONTHNAMES[month]} #{year}\n"
    puts "Su       Mo       Tu       We       Th       Fr       Sa"
    print "         " * dates[0].wday
    dates.each do |date|
      result = date.day.to_s
      no_of_events = events[date.day]&.length
      result += " (#{no_of_events})" if no_of_events != 0
      print result.ljust(9)
      print "\n" if date.saturday?
    end
  end

  def list_month_events(year, month, events)
    if !(events.empty?())
      events.each do |key, val|
        unless val.empty?()
          puts "#{Date.new(year, month, key)} has the following events"

          val.each do |event|
            display_event(event)
          end
        end
      end
    else
      puts "No event to show"
    end
  end

  private
  def event_exists?(events, title)
    events.any? { |event| event.title == title }
  end
  def display_event(event)
    puts "\nTitle: #{event.title}"
    puts "Description: #{event.description}\n"
    puts "-" * 40
  end

end
