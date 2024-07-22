require_relative 'calendar'
require_relative 'user_interface'

require 'date'
require 'io/console'

correct_option = true
user_interface = UserInterface.instance
calendar       = Calendar.instance

loop do
  user_interface.show_main_menu
  correct_option ? puts('Choose Option') : puts('Choose correct option')
  choice = gets.chomp.to_i

  case choice
  when 0
    puts 'Please enter valid input.'

  when 1
    date = user_interface.get_date
    title = user_interface.input_and_check_uniqueness_of_title(date)
    print 'Enter description: '
    description = gets.chomp
    calendar.add_event(date, title, description)
    puts 'Event added successfully'
    puts "\nPress any key to continue..."
    STDIN.getch

  when 2
    date   = user_interface.get_date
    events = calendar.events_at(date)
    user_interface.list_events(events)
    puts "\nPress any key to continue..."
    STDIN.getch

  when 3
    # Edit Event
    date   = user_interface.get_date
    events = calendar.events_at(date)
    user_interface.list_events(events)
    title = user_interface.input_and_validate_title(events)
    print 'Enter new description: '
    description = gets.chomp
    calendar.edit_event(date, title, description)
    puts 'Event updated successfully'
    puts "\nPress any key to continue..."
    STDIN.getch

  when 4
    # Delete Event
    date   = user_interface.get_date
    events = calendar.events_at(date)
    user_interface.list_events(events)
    title = user_interface.input_and_validate_title(events)
    calendar.delete_event(date, title)
    puts 'Event deleted successfully'
    puts "\nPress any key to continue..."
    STDIN.getch

  when 5
    # Month view
    year   = user_interface.get_year
    month  = user_interface.get_month
    events = calendar.get_month_events(year, month)
    user_interface.month_view(year, month, events)
    puts "\nPress any key to continue..."
    STDIN.getch

  when 6
    # List month events
    year   = user_interface.get_year
    month  = user_interface.get_month
    events = calendar.get_month_events(year, month)
    user_interface.list_month_events(year, month, events)
    puts "\nPress any key to continue..."
    STDIN.getch

  when 7
    break
  else
    correct_option = false
  end
end
