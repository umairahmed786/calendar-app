require 'rspec'
require_relative '../event'

# frozen_string_literal: true

describe Event do
  let(:event) {Event.new('Session', 'A new hires standup session.')}
  
  describe '#initialize' do
    it 'creates event with the title and description' do
      expect(event.title).to eq('Session')
      expect(event.description).to eq('A new hires standup session.')
    end
  end

  describe '#title' do
    it 'returns the title of the event' do
      expect(event.title).to eq('Session')
    end

    it 'does not allow the title to change' do
      expect{event.title = 'New title'}.to raise_error(NoMethodError)
    end
  end

  describe '#description' do
    it 'returns the description of the event' do
      expect(event.description).to eq('A new hires standup session.')
    end
    
    it 'allows to change the description of the  event' do
      event.description = 'A new description'
      expect(event.description).to eq('A new description')
    end
  end

  

end

