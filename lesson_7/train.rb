require_relative 'railroad'

class Train  

  include CompanyManufacturerName
  include InstanceCounter
  include ValidCheck

  attr_reader :type, :speed, :number, :route, :current_position, :wagons

  NUMBER_TRAIN = /^[а-я0-9]{3}-?[а-я0-9]{2}$/i

  @@trains = []

  def self.find(number)
    @@trains.select{ |train| train.number == number }.first   
  end

  def initialize(number)
    @number = number     
    @wagons = []
    validate!  
    @route = []
    @current_position = 0
    @@trains << self
    register_instance
  end

  def change_speed(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def assign_route(route)
    @route = route    
  end

  def current_station    
    @route.stations[@current_position]    
  end

  def next_station    
    @route.stations[@current_position+1]
  end

  def prev_station    
    @route.stations[@current_position-1]
  end

  def change_station_to_next 
    if @route == [] || @route == nil
      puts "Поезд не имеет маршрута."
    else
      if current_station != @route.end_station   

        @current_position += 1

        puts "Поезд на станции #{@route.stations[@current_position].title_station}"
        puts "Поезд прибыл" if current_station == @route.end_station
      else 
        puts "Поезд прибыл"
      end
    end    
  end

  def change_station_to_prev
    if @route == [] || @route == nil
      puts "Поезд не имеет маршрута."
    else
      if current_station != @route.start_station
        @current_position -= 1
        current_station
        puts "Поезд на станции #{@route.stations[@current_position].title_station}"
        puts "Поезд прибыл" if current_station == @route.start_station
      else 
        puts "Поезд прибыл"
      end  
    end   
  end

  def add_wagon(wagon)
    add_wagon!(wagon)
  end

  def remove_wagon
    remove_wagon!
  end

  def brake?
    @speed.zero?
  end

  def wagons_on_train(&train_wagons)
    return unless block_given?
    wagons.each{ |wagon| train_wagons.call(wagon)}
  end

   def select_wagon(number)
    wagons.find { |wagon| wagon.number == number }
  end

  protected 

  attr_writer :speed, :wagons, :current_position, :type, :number, :route

  # пользователь не может изменять данные из вне

  def add_wagon!(wagon)
    self.wagons << wagon 
  end

  def remove_wagon!
    self.wagons.pop
  end

  def validate!
    raise "Неверный номер поезда." if number !~ NUMBER_TRAIN
    raise 'Такой номер поезда уже существует.' if @@trains.map(&:number).include?(number)
    raise 'Тип поезда не верный.' if type != 'пассажирский' && type != 'грузовой'    
  end
 end
