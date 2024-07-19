require_relative "event.rb"
require_relative "calendar.rb"
require_relative "ui.rb"

require 'date'

correct_option=true
loop do 
	system(`clear`)
	puts "\nCalender Menu"
	puts "1. Add Event"
    puts "2. Show Events List"
    puts "3. Edit Event"
	puts "4. Delete Event"
    puts "5. Exit"
	
	correct_option ? puts("Choose Option") : puts("Choose correct option")

	choice=gets.chomp.to_i

	case choice
	when 0
		puts "Oops! You can only enter integer"
	when 1
        
        date=UserInterface.instance.get_date

        # Getting title
        title=nil
        loop do
            print "Enter title: "
            title=gets.chomp
            if title.empty?
                print "Title cannot be empty. Please enter a valid title: "
            else
                break
            end
        end

        # Getting description of the event
        print "Enter description: "
        description=gets.chomp
        

        Calendar.instance.add_event(date,title,description)
        puts "Event added successfully"
        
        sleep(2)

    when 2

        date=UserInterface.instance.get_date

        events=Calendar.instance.get_date_events(date)

        UserInterface.instance.list_events(events)

        sleep(2)    
    
    when 3
        break
    else
		correct_option=false
	end
end