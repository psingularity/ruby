class Train

  attr_reader :type, :number

  attr_accessor :count, :speed

  def initialize(number, type, count)
    @number = number
    @type = type
    @count = count 
  end

  def change_speed(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end  

  def add_route(route)
    @route = route
    @current_position = 0
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
    if current_station != @route.end_station
      @current_position += 1
      puts @route.stations[@current_position]
    else 
      puts "Поезд прибыл"
    end
  end

  def change_station_to_prev
    if current_station != @route.start_station
      @current_position -= 1
      puts @route.stations[@current_position]
    else 
      puts "Поезд прибыл"
    end     
  end

  def coupling_wagons
    if @speed == 0
      puts "Прицепить вагон (add) / отцепить (remove)"
      input = gets.chomp
      if input == "add"
        @count += 1
      elsif input == "remove"
        @count -= 1
      else
        puts "Неверная команда"
      end        
    else 
      puts "Поезд движется. Прицеплять/отцеплать вагоны запрещено"
    end
  end
end
