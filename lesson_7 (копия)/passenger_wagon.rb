class PassengerWagon < Wagon

  @@number = 1

  def initialize(total_volume)  
    @number = @@number
    @@number += 1  
    super
    @type = "пассажирский"
  end

  def take_volume
    self.occupied_volume += 1 if occupied_volume < total_volume
  end

end
