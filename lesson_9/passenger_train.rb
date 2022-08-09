# frozen_string_literal: true

class PassengerTrain < Train
  validate :number, :format, /^[а-я0-9]{3}-?[а-я0-9]{2}$/i
  validate :number, :presence
  validate :type, :type, String

  def initialize(number)
    @type = 'пассажирский'
    super
  end
end
