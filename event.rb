class Event
  attr_reader :title
  attr_accessor :description

  def initialize(title, description)
    @title       = title
    @description = description
  end
end
