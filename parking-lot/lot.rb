class Lot
  def initialize
    @available_spots = []
  end

  def any_spots?
    @availale_spots.any?
  end

  def add_spot(spot)
    @available_spots.push spot
  end

  def park_car(car)
    spot = @available_spots.shift
    spot.set_listener(self)
    spot.park(car)
  end

  def spot_free(spot)
    @available_spots.push spot
  end

  def capacity
    @available_spots.count
  end
end


class Car
  attr_accessor :location
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def leave!
    location.free!
  end
end

class ParkingSpot

  def initialize
    @parked_car = nil
    @listener = nil
  end

  def set_listener(listener)
    @listener = listener
  end

  def park(car)
    @parked_car = car
    car.location = self
  end

  def free!
    @parked_car = nil
    @listener.spot_free(self)
  end

  def available?
    !@parked_car
  end

end

lot = Lot.new
cars = []
spots = []
100.times do |i|
  cars << Car.new("Car #{i}")
  spot = ParkingSpot.new
  lot.add_spot(spot)
end

loop do
  c = cars.sample
  sleep(1)
  if c.location
    puts "#{c.name} Leaving Spot"
    c.leave!
  else
    puts "#{c.name} Parking"
    lot.park_car(c)
  end
  puts "Lot Capacity: #{lot.capacity}"
end


