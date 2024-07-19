class Event
    attr_reader :title
    attr_accessor :description

    def initialize(title, description="No description given.")
        @title=title
        @description=description
    end
end