class Wagon
  include CompanyManufacturerName

  attr_reader :type, :number, :total_volume, :occupied_volume
  
  def initialize(total_volume)
    @total_volume = total_volume
    @occupied_volume = 0
  end

  def free_volume
    total_volume - occupied_volume
  end

  protected

  attr_writer :number, :total_volume, :occupied_volume

end