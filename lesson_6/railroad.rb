require_relative 'valid_check'
require_relative 'instance_counter'
require_relative "company_manufacturer_name"
require_relative "station"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "route"
require_relative "wagon"
require_relative "cargo_wagon"
require_relative "passenger_wagon"


class RailRoad
  puts "Привет, это программа-абстракция железной дороги"

  attr_reader :stations, :title_stations, :trains, :wagons, :routes, :title_station  

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []

    @title_stations = []
  end

  def menu  
    loop do
      puts "Введите 1, если вы хотите создать станцию, поезд или маршрут"
      puts "Введите 2, если вы хотите произвести операции с созданными объектами"
      puts "Введите 3, если вы хотите вывести текущие данные об объектах"
      puts "Введите 0 или стоп, если хотите закончить программу"

      @option = gets.chomp

      case @option

      when '1','2','3' then submenu 
      when '0', 'стоп' then break 
      else
        puts 'Неверный ввод.'
        break
      end
    end     
  end  

protected

attr_writer :stations, :trains, :wagons, :routes, :title_stations, :title_station

#должны быть только внутри класса

def submenu    
    case @option

    when "1"      
      puts "Что вы хотите создать?"
      puts "Введите 1, если вы хотите создать станцию"
      puts "Введите 2, если вы хотите создать поезд"
      puts "Введите 3, если вы хотите создать маршрут" 

      option = gets.chomp.to_i

      if option == 1
        create_station           
      elsif option == 2
        create_train
      elsif option == 3
        create_route 
      else
        puts "Не верная команда, попробуйте заново"
        submenu
      end     

    when "2"
      puts "Что вы хотите сделать?"
      puts "Введите 1, если хотите добавить станцию в маршруте"
      puts "Введите 2, если хотите удалить станцию в маршруте"
      puts "Введите 3, если нужно назначить поезду маршрут"
      puts "Введите 4, если хотите присоединить вагон к поезду"
      puts "Введите 5, если хотите удалить вагон поезда"
      puts "Введите 6, если хотите переместить поезд по маршруту на следующую станцию"
      puts "Введите 7, если хотите переместить поезд по маршруту на предыдущую станцию"
      
      option = gets.chomp.to_i

      if option == 1
        add_way_station    
      elsif option == 2
        remove_way_station 
      elsif option == 3
        assign_route_train
      elsif option == 4
        attach_wagon
      elsif option == 5
        disconnect_wagon
      elsif option == 6
        train_forward
      elsif option == 7
        train_back
      else
        puts "Не верная команда, попробуйте заново"
        submenu
      end   

    when "3"
      puts "Что вы хотите вывести?"
      puts "Введите 1, если хотите просмотреть список станций"
      puts "Введите 2, если хотите просмотреть список поездов на станции"

      option = gets.chomp.to_i

      if option == 1
        if @stations.length > 0
           all_stations_way
        else
          puts "Нет станций."
        end
       
      elsif option == 2
        all_trains_station 
      else
        puts "Не верная команда, попробуйте заново"
        submenu
      end   

    when "0", "стоп"
      
    else 
      puts "Ошибка ввода"
    end    
  end

  def create_station
    begin
      puts "Введите название станции:"
      @title_station = gets.chomp   

      @stations << Station.new( @title_station)
      @title_stations << @title_station 
    rescue RuntimeError
      system 'clear'
      puts 'Такое название станции уже существует. Повторите, пожалуйста:'
      retry
    end  

  end

  def create_train
    system 'clear'

    begin
      puts "Введите номер поезда:"
      number_train = gets.chomp    

      puts "Введите тип поезда:"
      puts '1 - пассажирский'
      puts '2 - грузовой'

      type_train = gets.chomp.to_i

      case type_train
      when 1
        @trains << PassengerTrain.new(number_train)       
      when 2
        @trains << CargoTrain.new(number_train)        
      end
    rescue RuntimeError
      system 'clear'
      puts 'Неверный номера поезда. Используйте формат - три буквы/(дефис)/две цифры(буквы)'
      retry
    end
  end

  def create_route
    puts "Введите станцию отправления:"
    all_stations_way
    puts "-----------------------"
    first_station = gets.chomp.to_i - 1

    puts "Введите станцию назначения"
    all_stations_way
    puts "-----------------------"
    last_station = gets.chomp.to_i - 1
    @routes << Route.new(all_stations_way[first_station], all_stations_way[last_station])

  end 

  def all_stations_way
    i = 1
    stations.each do |station|
      puts "#{i}. "
      puts  station.title_station 
      i += 1
    end
  end

  def all_trains
    i = 1
    trains.each do |train|
      puts "#{i}. " 
      puts train.number, train.type
      i += 1
    end    
  end

  def all_routes
    i = 1
    routes.each do |route|
      puts "#{i}. " 
      route.all_stations.each do |station|
        puts station.title_station
      end
      i += 1
    end    
  end

  def add_way_station
    system 'clear'
    puts 'Выберите маршрут, в который хотите добавить промежуточную станцию:'
    all_routes
    puts "-----------------------"
    route_number = gets.chomp.to_i - 1
    puts 'Введите номер промежуточной станции:'
    all_stations_way
    puts "-----------------------"
    way_station = gets.chomp.to_i - 1

    if routes[route_number].all_stations.include? stations[way_station]
      puts "Станция #{stations[way_station].title_station} уже добавлена в этот маршрут."
    else 
      routes[route_number].add_station(stations[way_station])
      puts "Станция #{stations[way_station].title_station} добавлена."
      routes[route_number].all_stations
    end  

  end

  def remove_way_station
    system 'clear'
    puts 'Выберите маршрут, из которого хотите удалить промежуточную станцию:'
    all_routes
    puts "-----------------------"
    route_number = gets.chomp.to_i - 1
    puts 'Введите номер промежуточной станции:'
    all_stations_way
    puts "-----------------------"
    way_station = gets.chomp.to_i - 1

    if routes[route_number].all_stations.include? stations[way_station]
      routes[route_number].remove_station(stations[way_station])
      puts "Станция #{stations[way_station].title_station} удалена из этого маршрута."
    else 
      puts "Станция #{stations[way_station].title_station} отсутстует в маршруте поезда."
      routes[route_number].all_stations
    end  
  end

  def assign_route_train
    system 'clear'
    puts "Выберите поезд, к которому хотите назначить маршрут:"
    all_trains
    puts "-----------------------"
    train_number = gets.chomp.to_i - 1
    puts "Выберите маршрут:"
    all_routes
    puts "-----------------------"
    route_number = gets.chomp.to_i - 1
    trains[train_number].assign_route(routes[route_number])

    trains[train_number].current_station.receiving_train(trains[train_number])

    puts "Поезд #{trains[train_number].number} (#{trains[train_number].type})"

    puts "Станция, на которой находится поезд: #{trains[train_number].current_station.title_station}"

  end

  def train_number_brake
    all_trains
    @train_number = gets.chomp.to_i - 1 

    trains[@train_number].brake
  end

  def attach_wagon 
    system 'clear'
    puts "Выберите поезд, к которому хотите присоединить вагон:"
    
    train_number_brake

    if trains[@train_number].type == "грузовой" 
      puts "Сколько вагонов хотите присоединить:"
      @w_count = gets.chomp.to_i      

      @w_count.times { 
        trains[@train_number].add_wagon(CargoWagon.new) 
      } 
      puts trains[@train_number].wagons
    end

    if trains[@train_number].type == "пассажирский"
      puts "Сколько вагонов хотите присоединить:"
      @w_count = gets.chomp.to_i

      @w_count.times { trains[@train_number].add_wagon(PassengerWagon.new) } 

      puts "Сколько вагонов стало:"
      puts trains[@train_number].wagons
    end  

  end

  def disconnect_wagon
    system 'clear'
    puts "Выберите поезд, от которого хотите отсоединить вагон:"

    train_number_brake

    if trains[@train_number].type == "грузовой" 

      puts "Количество вагонов поезда"
      puts trains[@train_number].wagons

      puts "Сколько вагонов хотите отсоединить:"
      @w_count = gets.chomp.to_i 

      @w_count.times { trains[@train_number].remove_wagon } 
    end

    if trains[@train_number].type == "пассажирский"

      puts "Количество вагонов поезда"
      puts trains[@train_number].wagons

      puts "Сколько вагонов хотите отсоединить:"
      @w_count = gets.chomp.to_i 

      @w_count.times { trains[@train_number].remove_wagon } 

      puts "Сколько вагонов стало:"
      puts trains[@train_number].wagons
    end
  end

  def train_forward
    system 'clear'
    puts "Выберите поезд, который нужно переместить:"

    train_number_brake

    if trains[@train_number].route == []
      puts "Поезду не назначен маршрут."
    else
      trains[@train_number].current_station.departure_train(trains[@train_number])

      trains[@train_number].change_station_to_next  

      trains[@train_number].current_station.receiving_train(trains[@train_number])
    end    
  end

  def train_back
    system 'clear'
    puts "Выберите поезд, который нужно переместить:"

    train_number_brake
    if trains[@train_number].route == []
      puts "Поезду не назначен маршрут."
    else
      trains[@train_number].current_station.departure_train(trains[@train_number])

      trains[@train_number].change_station_to_prev

      trains[@train_number].current_station.receiving_train(trains[@train_number])
    end
  end

  def all_trains_station
    system 'clear'
    puts 'Введите номер станции, которую хотите посмотреть:'
    all_stations_way
    puts "-----------------------"
    station_number = gets.chomp.to_i - 1
    if stations[station_number].trains == []
      puts "На станции нет поездов."
    else
      puts stations[station_number].trains
    end
  end

end
