require 'singleton'
require_relative 'event'


# class that contains events and perform all the events functions like Add Edit..
class Calendar
  include Singleton
  attr_accessor :events

  def initialize
    @events = Hash.new { |hash, key| hash[key] = hash.dup.clear }
  end

  def add_event(date, title, description)
    event = Event.new(title, description)
    if events_at(date).empty?
      events[date.year][date.mon][date.mday] = [event]
    else
      events_at(date) << event
    end
  end

  def invalid_event(date, title)
    return if events_at(date).empty?

    events_at(date).any? { |event| event.title == title }
  end

  def events_at(date)
    events[date.year][date.mon][date.mday]
  end

  def edit_event(date, title, new_description)
    editable_event = events_at(date).find { |event| event.title == title }
    editable_event.description = new_description
  end

  def delete_event(date, title)
    events_at(date).delete_if { |event| event.title == title }
  end

  def get_month_events(year, month)
    events[year][month]
  end
end
