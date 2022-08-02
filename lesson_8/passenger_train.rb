# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    @type = 'пассажирский'
    super
  end
end
