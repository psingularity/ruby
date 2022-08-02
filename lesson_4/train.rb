class Train

  attr_reader :type, :speed, :number, :route, :current_position, :wagons

  def initialize(number)
    @number = number
    @wagons = []
    @route = []
    @current_position = 0
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
      puts @route.stations[@current_position+1]
  end

  def prev_station    
      puts @route.stations[@current_position-1]
  end

  def change_station_to_next 
    if @route == [] || @route == nil
      puts "Поезд не имеет маршрута."
    else
      if current_station != @route.end_station   

        @current_position += 1
    
        @route.stations[@current_position].receiving_train(@train_number)

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

  protected 

  attr_writer :speed, :wagons, :current_position, :type, :number, :route

  # пользователь не может изменять данные из вне

  def add_wagon!(wagon)
    self.wagons << wagon 
  end

  def remove_wagon!
    self.wagons.pop
  end

end
