require 'singleton'
require_relative "event.rb"

class Calendar
    include Singleton
    attr_accessor :events
    
    def initialize
        @events=Hash.new{|h,k| h[k] = h.dup.clear}
    end

    def add_event(date, title, description)
        event=Event.new(title, description)
        
        if events[date.year][date.mon][date.mday].empty?()
            events[date.year][date.mon][date.mday]=[event]
        else
            events[date.year][date.mon][date.mday]<<event
        end
    end


    def get_date_events(date)
        events[date.year][date.mon][date.mday]
    end


    def edit_event(date, title, new_description)
        editable_event=events[date.year][date.mon][date.mday].find {|event| event.title==title}
        editable_event.description=new_description
    end

    def delete_event(date, title)
        events[date.year][date.mon][date.mday].delete_if {|event| event.title==title}
    end

    def get_month_events(year,month)
        events[year][month]
    end

end

