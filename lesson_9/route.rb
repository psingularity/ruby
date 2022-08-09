# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(1, station)
    @stations[1..-2] = @stations[1..-2].reverse
  end

  def remove_station(station)
    if station != start_station || station != end_station
      @stations.delete(station)
    else
      puts 'Удалить станцию нельзя!'
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
    raise 'Маршрут должен иметь минимум 2 станции' if stations.length < 2
  end
end
