# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number)
    @type = 'грузовой'
    super
  end
end
