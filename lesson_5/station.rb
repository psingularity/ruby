class Station

  include InstanceCounter

  attr_reader :trains, :title_station

  class << self
    attr_accessor :stations    
  end

  self.stations = [] 
  
  def self.all 
      stations
  end

  def initialize(title_station)
    @title_station = title_station
    @trains = []
    self.class.stations << self
    register_instance
  end

  def receiving_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

end
