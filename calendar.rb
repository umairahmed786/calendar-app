require 'singleton'
require_relative 'event.rb'

# Class that contains events and hadle all the functionality related to events
class Calendar
  include Singleton
  attr_accessor :events

  def initialize
    @events = Hash.new { |hash, key| hash[key] = hash.dup.clear }
  end

  def add_event(date, title, description)
    event = Event.new(title, description)

    if events[date.year][date.mon][date.mday].empty?()
      events[date.year][date.mon][date.mday] = [event]
    else
      events[date.year][date.mon][date.mday] << event
    end
  end

  def validate_event(date, title)
    unless events[date.year][date.mon][date.mday].empty?()
      events[date.year][date.mon][date.mday].any? { |event| event.title == title }
    end
  end

  def events_at(date)
    events[date.year][date.mon][date.mday]
  end

  def edit_event(date, title, new_description)
    editable_event             = events[date.year][date.mon][date.mday].find { |event| event.title == title }
    editable_event.description = new_description
  end

  def delete_event(date, title)
    events[date.year][date.mon][date.mday].delete_if { |event| event.title == title }
  end

  def get_month_events(year, month)
    events[year][month]
  end
end
