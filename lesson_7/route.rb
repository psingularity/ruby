class Route

  include InstanceCounter
  include ValidCheck

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]  
     validate! 
    register_instance 
  end

  def add_station(station)
    @stations.insert(1,station)
    @stations[1..-2] = @stations[1..-2].reverse
  end

  def remove_station(station)    
    if station != start_station || station != end_station
      @stations.delete(station)
    else
      puts "Удалить станцию нельзя!"
    end
  end 

  def all_stations
    @stations
  end

  def start_station
    stations.first
  end

  def end_station
    stations.last
  end

  protected
  # чтобы нельзя было использовать извне объекта
  attr_writer :stations

  def validate!
    raise 'The route must have at least 2 stations' if stations.length < 2
  end

end
