class Station

  attr_reader :trains, :title_station

  def initialize(title_station)
    @title_station = title_station
    @trains = []
  end

  def receiving_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

end
