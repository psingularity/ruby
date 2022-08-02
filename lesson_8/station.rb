# frozen_string_literal: true

class Station
  include InstanceCounter
  include ValidCheck

  attr_reader :trains, :title_station

  TITLE_STATION = /^[а-я0-9]/i.freeze

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
    validate!
    self.class.stations << self
    register_instance
  end

  def receiving_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def trains_at_station(&station_trains)
    return unless block_given?

    trains.each { |train| station_trains.call(train) }
  end

  protected

  attr_writer :trains

  def validate!
    raise 'Неверное название станции.' if title_station !~ TITLE_STATION
    raise 'Такое название станции уже существует' if self.class.stations.map(&:title_station).include?(title_station)
  end
end
