class Station

  attr_reader :trains, :title_station

  def initialize(title_station)
    @title_station = title_station
    @trains = []
  end

  def receiving_train(train)
    @trains << train
  end

  def types_trains      
    freight_trains = []
    passenger_trains = [] 
    @trains.select { |train|      
      if train.type == 'грузовой'
       freight_trains << train.number
      end
      if train.type == 'пассажирский'
        passenger_trains << train.number
      end 
    }
    puts "Количество грузовых поездов: #{freight_trains.length}"
    puts "Количество пассажирских поездов: #{passenger_trains.length}"
  end

  def departure_train(train)
    @trains.delete(train)
  end
end
