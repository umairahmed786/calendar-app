require 'rspec'
require 'date'
require_relative '../calendar'
require_relative '../event'

# frozen_string_literal: true

describe Calendar do
  let(:date) {Date.parse('2020-12-12')}
  let(:event) {Event.new('Session', 'A new hire session.')}

  describe 'add_event' do
    it 'add event in the events list' do
      Calendar.instance.add_event(date, 'Session', 'A new hire session.')
      expect(Calendar.instance.events[date.year][date.mon][date.mday][0].title).to eq(event.title)
      expect(Calendar.instance.events[date.year][date.mon][date.mday][0].description).to eq(event.description)
    end
  end

  describe 'edit_event' do
    it 'edit event in the events list' do
      Calendar.instance.edit_event(date, 'Session', 'A new description.')
      event.description = 'A new description.'
      expect(Calendar.instance.events[date.year][date.mon][date.mday][0].title).to eq(event.title)
      expect(Calendar.instance.events[date.year][date.mon][date.mday][0].description).to eq(event.description)
    end
  end

  describe 'delete_event' do
    it 'delete event in the events list' do
      Calendar.instance.delete_event(date, 'Session')
      expect(Calendar.instance.events[date.year][date.mon][date.mday]).to eq([])
    end
  end

end
