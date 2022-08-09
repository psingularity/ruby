# frozen_string_literal: true

class CargoWagon < Wagon
  @number = 0

  def self.number
    @number += 1
  end

  def initialize(total_volume)
    super
    @type = 'грузовой'
    @number = self.class.number
  end

  def take_volume
    self.occupied_volume += 1 if occupied_volume < total_volume
  end

  protected

  def validate!
    super
    raise 'Нельзя занять места' if occupied_volume < total_volume
  end
end
