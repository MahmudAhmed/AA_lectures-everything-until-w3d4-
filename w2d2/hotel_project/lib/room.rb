class Room
    attr_reader :capacity, :occupants

    def initialize(capacity)
        @capacity = capacity
        @occupants = []
    end

    def full?
        occupants.length >= capacity
    end

    def available_space
        capacity - occupants.length
    end

    def add_occupant(person)
        if !full?
            self.occupants << person
            return true
        else
            return false
        end
    end

    
end
