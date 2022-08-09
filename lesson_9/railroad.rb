# frozen_string_literal: true

require_relative 'accessors'
require_relative 'validation'
require_relative 'instance_counter'
require_relative 'company_manufacturer_name'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class RailRoad
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
      menu_dsr
      @option = gets.chomp
      case @option
      when '1', '2', '3' then submenu
      when '0', 'стоп' then break
      else
        break
      end
    end
  end

  def menu_dsr
    puts 'Введите 1, если вы хотите создать станцию, поезд или маршрут'
    puts 'Введите 2, если вы хотите произвести операции с созданными объектами'
    puts 'Введите 3, если вы хотите вывести текущие данные об объектах'
    puts 'Введите 0 или стоп, если хотите закончить программу'
  end

  def submenu_dsr_one
    puts 'Введите 1, если вы хотите создать станцию'
    puts 'Введите 2, если вы хотите создать поезд'
    puts 'Введите 3, если вы хотите создать маршрут'
  end

  def submenu_dsr_two
    puts 'Введите 1, если хотите добавить/удалить станцию в маршруте'
    puts 'Введите 2, если нужно провести действия с вагонами'
    puts 'Введите 3, если хотите назначить поезду маршрут/переместить поезд по маршруту'
  end

  def submenu_dsr_third
    puts 'Введите 1, если хотите просмотреть список станций'
    puts 'Введите 2, если хотите просмотреть список поездов на станции'
    puts 'Введите 3, если хотите просмотреть информацию о занятых/свободных местах/объеме в поезде'
  end

  def submenu_dsr_wagons
    puts 'Введите 1, если хотите присоединить вагон к поезду'
    puts 'Введите 2, если хотите удалить вагон поезда'
    puts 'Введите 3, если хотите занять место или объем в вагоне'
  end

  def submenu_dsr_stations
    puts 'Введите 1, если хотите добавить станцию в маршрут'
    puts 'Введите 2, если хотите удалить станцию в маршрут'
  end

  def submenu_dsr_trains
    puts 'Введите 1, если нужно назначить поезду маршрут'
    puts 'Введите 2, если хотите переместить поезд по маршруту на следующую станцию'
    puts 'Введите 3, если хотите переместить поезд по маршруту на предыдущую станцию'
  end

  def return_menu
    puts 'Не верная команда, попробуйте заново'
    submenu
  end

  def submenu_one
    submenu_dsr_one
    option = gets.chomp.to_i
    case option
    when 1
      create_station
    when 2
      create_train
    when 3
      stations.length < 2 ? puts('Нет достаточного количества станций.') : create_route
    end
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  def submenu_two
    option = gets.chomp.to_i
    case option
    when 1
      stations.empty? ? puts('Нет станций.') : actions_with_stations
    when 2
      trains.empty? ? puts('Нет поездов.') : actions_with_wagons
    when 3
      trains.empty? ? puts('Нет поездов.') : actions_with_trains
    end
  end

  def actions_with_stations
    submenu_dsr_stations
    option = gets.chomp.to_i
    case option
    when 1
      routes.empty? ? puts('Нет маршрутов.') : add_way_station
    when 2
      routes.empty? ? puts('Нет маршрутов.') : remove_way_station
    end
  end

  def actions_with_wagons
    submenu_dsr_wagons
    option = gets.chomp.to_i
    case option
    when 1
      attach_wagon
    when 2
      disconnect_wagon
    when 3
      take_wagon
    end
  end

  def actions_with_trains
    submenu_dsr_trains
    option = gets.chomp.to_i
    case option
    when 1
      routes.empty? ? puts('Нет маршрутов.') : assign_route_train
    when 2
      train_forward
    when 3
      train_back
    end
  end

  def train_check
    puts 'Выберите поезд, который хотите проверить:'
    all_trains
    puts 'Номер поезда: '
    train_number = gets.chomp.to_i - 1
    train = all_trains[train_number]
    quantity_wagon(train)
  end

  def submenu_third
    option = gets.chomp.to_i
    case option
    when 1
      stations.empty? ? puts('Нет станций.') : all_stations_way
    when 2
      stations.empty? ? puts('Нет станций.') : all_trains_station
    when 3
      trains.empty? ? puts('Нет поездов.') : train_check
    end
  end

  protected

  attr_writer :stations, :trains, :wagons, :routes, :title_stations, :title_station

  # должны быть только внутри класса

  def submenu
    case @option
    when '1'
      submenu_one
    when '2'
      submenu_dsr_two
      submenu_two
    when '3'
      submenu_dsr_third
      submenu_third
    end
  end

  def create_station
    puts 'Введите название станции:'
    @title_station = gets.chomp

    @stations << Station.new(@title_station)
    @title_stations << @title_station
  end

  def create_train
    puts 'Введите номер поезда:'
    number_train = gets.chomp
    number_train.empty? ? puts('Не введен номер поезда.') : type_train(number_train)
  end

  def type_train(number_train)
    puts 'Введите тип поезда: 1-пассажирский / 2-грузовой'
    type_train = gets.chomp.to_i
    case type_train
    when 1
      @trains << PassengerTrain.new(number_train)
    when 2
      @trains << CargoTrain.new(number_train)
    end
  end

  def create_route
    puts 'Все станции:'
    all_stations_way

    puts 'Введите станцию отправления:'
    first_station = gets.chomp.to_i - 1
    puts 'Введите станцию назначения'
    last_station = gets.chomp.to_i - 1
    @routes << Route.new(@stations[first_station], @stations[last_station])
  end

  def all_stations_way
    i = 1
    stations.each do |station|
      puts "#{i}. #{station.title_station}"
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

  def main_way_station
    puts 'Выберите маршрут:'
    all_routes
    route_number = gets.chomp.to_i - 1
    puts 'Введите номер станции:'
    all_stations_way
    @way_station = gets.chomp.to_i - 1
    @number_route = routes[route_number]
  end

  def add_way_station
    main_way_station
    dsr_add_station
  end

  def dsr_add_station
    if @number_route.all_stations.include? stations[@way_station]
      puts "Станция #{stations[@way_station].title_station} уже добавлена в этот маршрут."
    else
      @number_route.add_station(stations[@way_station])
      puts "Станция #{stations[@way_station].title_station} добавлена."
      @number_route.all_stations
    end
  end

  def remove_way_station
    main_way_station
    dsr_rem_station
  end

  def dsr_rem_station
    if @number_route.all_stations.include? stations[@way_station]
      @number_route.remove_station(stations[@way_station])
      puts "Станция #{stations[@way_station].title_station} удалена из этого маршрута."
    else
      puts "Станция #{stations[@way_station].title_station} отсутстует в маршруте поезда."
      @number_route.all_stations
    end
  end

  def main_train_num
    puts 'Выберите поезд:'
    all_trains
    @train_number = gets.chomp.to_i - 1
  end

  def assign_route_train
    main_train_num
    puts 'Выберите маршрут:'
    all_routes
    route_number = gets.chomp.to_i - 1
    num = trains[@train_number]
    dsr_route_train(route_number, num)
  end

  def dsr_route_train(route_number, num)
    num.assign_route(routes[route_number])
    num.current_station.receiving_train(num)
    puts "Поезд #{num.number} (#{num.type}). Станция, на которой находится поезд: #{num.current_station.title_station}"
  end

  def attach_wagon
    main_train_num
    num = trains[@train_number]
    puts 'Сколько вагонов хотите присоединить:'
    w_count = gets.chomp.to_i
    puts 'Количества мест (общий объем) одного вагона:'
    total_volume = gets.chomp.to_i
    count_wagon(num, total_volume, w_count)
    puts num.wagons
  end

  def count_wagon(num, total_volume, w_count)
    if num.type == 'грузовой'
      w_count.times do
        num.add_wagon(CargoWagon.new(total_volume))
      end
    else
      w_count.times do
        num.add_wagon(PassengerWagon.new(total_volume))
      end
    end
  end

  def disconnect_wagon
    main_train_num
    num = trains[@train_number]
    num.wagons.empty? ? puts('Нет вагонов.') : all_wagons(num)
  end

  def all_wagons(num)
    puts("Вагонов: #{num.wagons.length}")
    puts num.wagons
    puts 'Сколько вагонов хотите отсоединить:'
    w_count = gets.chomp.to_i
    w_count.times { num.remove_wagon }
    puts("Вагонов стало: #{num.wagons.length}")
    puts num.wagons
  end

  def train_forward
    main_train_num
    num = trains[@train_number]
    if num.route == []
      puts 'Поезду не назначен маршрут.'
    else
      num.current_station.departure_train(num)
      num.change_station_to_next
      num.current_station.receiving_train(num)
    end
  end

  def train_back
    main_train_num
    num = trains[@train_number]
    if num.route == []
      puts 'Поезду не назначен маршрут.'
    else
      num.current_station.departure_train(num)
      num.change_station_to_prev
      num.current_station.receiving_train(num)
    end
  end

  def take_wagon
    main_train_num
    train_number = @train_number
    train = all_trains[train_number]
    train.wagons.empty? ? puts('У поезда нет вагонов.') : quantity_wagon(train) && num_wagon(train_number)
  end

  def num_wagon(train_number)
    puts 'Номер вагона:'
    wagon_number = gets.chomp.to_i
    puts 'Количество занимаемых мест/объема:'
    volume = gets.chomp.to_i
    free_vol(train_number, wagon_number, volume)
  end

  def free_vol(train_number, wagon_number, volume)
    free_vol = trains[train_number].select_wagon(wagon_number).free_volume
    if volume <= free_vol
      volume.times { trains[train_number].select_wagon(wagon_number).take_volume }
    else
      puts 'Объем или места не должны быть больше допустимого значения'
    end
  end

  def quantity_wagon(train)
    puts "#{train.number}, тип: #{train.type}, количество вагонов: #{train.wagons.length}"
    train.wagons_on_train do |wagon|
      puts "№.#{wagon.number}, тип: #{wagon.type}, свободно: #{wagon.free_volume}, занято: #{wagon.occupied_volume}"
    end
  end

  def all_trains_station
    puts 'Введите номер станции, которую хотите посмотреть:'
    all_stations_way
    station_number = gets.chomp.to_i - 1
    station = stations[station_number]
    station.trains.empty? ? puts('На станции нет поездов.') : full_station(station)
  end

  def full_station(station)
    puts "На станции #{station.title_station} следующие поезда:"
    station.trains_at_station do |train|
      quantity_wagon(train)
    end
  end
end
