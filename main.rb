require_relative "calendar.rb"
require_relative "user_interface.rb"

require "date"
require 'io/console'

correct_option = true
loop do
  system(`clear`)
  puts "\nCalender Menu"
  puts "1. Add Event"
  puts "2. Show Events List"
  puts "3. Edit Event"
  puts "4. Delete Event"
  puts "5. Month View"
  puts "6. Month Events"
  puts "7. Exit"

  correct_option ? puts("Choose Option") : puts("Choose correct option")

  choice = gets.chomp.to_i

  case choice

  when 0
    puts "Please enter valid input."
  when 1
    date = UserInterface.instance.get_date

    # Getting title
    title = UserInterface.instance.get_new_title(date)
    # loop do
    #   print "Enter title: "
    #   title = gets.chomp
    #   if title.empty?
    #     print "Title cannot be empty. Please enter a valid title: "
    #   elsif Calendar.instance.validate_event(date, title)
    #     print "Event with same title exists. Please enter a valid title: "
    #   else
    #     break
    #   end
    # end

    # Getting description of the event
    print "Enter description: "
    description = gets.chomp
    Calendar.instance.add_event(date, title, description)
    puts "Event added successfully"

    puts "\nPress any key to continue..."
    STDIN.getch
  when 2
    date   = UserInterface.instance.get_date
    events = Calendar.instance.events_at(date)
    UserInterface.instance.list_events(events)
    puts "\nPress any key to continue..."
    STDIN.getch
  when 3
    # Edit Event
    date   = UserInterface.instance.get_date
    events = Calendar.instance.events_at(date)
    UserInterface.instance.list_events(events)
    title  = UserInterface.instance.input_valid_event_title(events)
    print "Enter new description: "
    description = gets.chomp
    Calendar.instance.edit_event(date, title, description)
    puts "Event updated successfully"
    puts "\nPress any key to continue..."
    STDIN.getch
  when 4
    # Delete Event
    date   = UserInterface.instance.get_date
    events = Calendar.instance.events_at(date)
    UserInterface.instance.list_events(events)
    title  = UserInterface.instance.input_valid_event_title(events)
    Calendar.instance.delete_event(date, title)
    puts "Event deleted successfully"
    puts "\nPress any key to continue..."
    STDIN.getch
  when 5
    # Month view
    year   = UserInterface.instance.get_year
    month  = UserInterface.instance.get_month
    events = Calendar.instance.get_month_events(year, month)
    UserInterface.instance.month_view(year, month, events)
    puts "\nPress any key to continue..."
    STDIN.getch
  when 6
    # List month events
    year   = UserInterface.instance.get_year
    month  = UserInterface.instance.get_month
    events = Calendar.instance.get_month_events(year, month)
    UserInterface.instance.list_month_events(year, month, events)
    puts "\nPress any key to continue..."
    STDIN.getch
  when 7
    break
  else
    correct_option = false
  end
end
