require_relative 'ParkingSystem'

class Booking
  attr_reader :bookings
  def initialize
    @bookings = []
    @booking_id = 1
  end

  # CREATE BOOKING
  def add_booking(booking)
    booking[:id] = @booking_id
    @bookings << booking
    puts "\nParking Booked Successfully!"
    puts "Booking ID: #{@booking_id}\n"
    @booking_id += 1
  end

  # VIEW ALL BOOKINGS
  def view_bookings
    if @bookings.empty?
      puts 'No bookings found!'
      return
    end

    puts "\nAll Bookings: "

    @bookings.each do |b|
      puts "\n"
      puts "Booking ID: #{b[:id]}"
      puts "Name: #{b[:name]}"
      puts "City: #{b[:city]}"
      puts "Location: #{b[:location]}"
      puts "Building: #{b[:building]}"
      puts "Floor: #{b[:floor]}"
      puts "Slot: #{b[:slot]}"
      puts "Vehicle: #{b[:vehicle]}"
      puts "Vehicle No: #{b[:vehicle_no]}"
      puts "Plan: #{b[:plan]}"
      puts "Price: #{b[:price]}"
      puts "Start Time: #{b[:start_time]}"
      puts "End Time: #{b[:end_time]}"
      puts "\n"
    end
  end

  # VIEW BY ID
  def view_booking_by_id
    if @bookings.empty?
      puts 'No bookings found!'
      return
    end

    puts 'Enter Booking ID: '
    id = gets.chomp.to_i

    booking = @bookings.find { |b| b[:id] == id }

    if booking
      puts "\nBooking Details:\n"
      puts "\n"
      puts "Booking ID: #{booking[:id]}"
      puts "Name: #{booking[:name]}"
      puts "City: #{booking[:city]}"
      puts "Location: #{booking[:location]}"
      puts "Building: #{booking[:building]}"
      puts "Floor: #{booking[:floor]}"
      puts "Slot: #{booking[:slot]}"
      puts "Vehicle: #{booking[:vehicle]}"
      puts "Vehicle No: #{booking[:vehicle_no]}"
      puts "Plan: #{booking[:plan]}"
      puts "Price: #{booking[:price]}"
      puts "\n"
    else
      puts 'Booking ID not found!'
    end
  end

  # DELETE BOOKING
  def delete_booking(tower_a, tower_b)
    if @bookings.empty?
      puts 'No bookings to delete!'
      return
    end

    puts 'Enter Booking ID to delete: '
    id = gets.chomp.to_i

    booking = @bookings.find { |b| b[:id] == id }

    if booking
      tower = booking[:building] == :Tower_A ? tower_a : tower_b
      tower[booking[:floor]][booking[:slot]] -= 1

      @bookings.delete(booking)
      puts 'Booking deleted successfully!'
      puts @bookings.count
    else
      puts 'Booking ID not found!'
    end
  end

 
  def view_booking_by_city(cities)
    if @bookings.empty?
      puts "No bookings available!"
      return
    end
    keys = cities.keys

    loop do
      puts "Select City: "
      keys.each_with_index do |c, index|
        puts "#{index + 1}. #{c}"
      end

      input = gets.chomp

      unless input.match?(/\A[1-9]\Z/)
        puts "Please enter a number!"
        next
      end

      city = keys[input.to_i - 1]

      if city
        results = @bookings.select { |b| b[:city] == city }

        if results.empty?
          puts "No bookings found for #{city}"
        else
          puts "\nBookings in #{city}: #{results.count}"
          results.each do |b|
            puts "\nBooking ID: #{b[:id]}"
            puts "Name: #{b[:name]}"
            puts "Location: #{b[:location]}"
            puts "Building: #{b[:building]}"
            puts "Floor: #{b[:floor]}"
            puts "Slot: #{b[:slot]}"
            puts "Vehicle: #{b[:vehicle]}"
            puts "Vehicle No: #{b[:vehicle_no]}"
            puts "Plan: #{b[:plan]}"
            puts "Price: #{b[:price]}"
          end
        end
        break
      else
        puts "Invalid choice!"
      end
    end
  end

  def view_booking_by_building(buildings)
    if @bookings.empty?
      puts "No bookings available!"
      return
    end
    keys = buildings.keys

    loop do
      puts "Select Building: "
      keys.each_with_index do |b, index|
        puts "#{index + 1}. #{b}"
      end

      input = gets.chomp

      unless input.match?(/\A[1-9]\Z/)
        puts "Please enter a number!"
        next
      end

      building = keys[input.to_i - 1]

      if building
        results = @bookings.select { |b| b[:building] == building }

        if results.empty?
          puts "No bookings found for #{building}"
        else
          puts "\nBookings in #{building}: #{results.count}"
          results.each do |b|
            puts "\nBooking ID: #{b[:id]}"
            puts "Name: #{b[:name]}"
            puts "City: #{b[:city]}"
            puts "Location: #{b[:location]}"
            puts "Floor: #{b[:floor]}"
            puts "Slot: #{b[:slot]}"
            puts "Vehicle: #{b[:vehicle]}"
            puts "Vehicle No: #{b[:vehicle_no]}"
            puts "Plan: #{b[:plan]}"
          end
        end
        break
      else
        puts "Invalid choice!"
      end
    end
  end

  def view_booking_by_vehicle
    if @bookings.nil? || @bookings.empty?
      puts "No bookings available!"
      return
    end

    puts "Enter vehicle number: "
    vehicle_no = gets.chomp.upcase

    results = @bookings.select { |b| b[:vehicle_no] == vehicle_no }

    if results.empty?
      puts "No bookings found for vehicle number: #{vehicle_no}"
    else
      puts "\nBookings for Vehicle No: #{vehicle_no}: #{results.count}"

      results.each do |b|
        puts "\nBooking ID: #{b[:id]}"
        puts "Name: #{b[:name]}"
        puts "City: #{b[:city]}"
        puts "Location: #{b[:location]}"
        puts "Building: #{b[:building]}"
        puts "Floor: #{b[:floor]}"
        puts "Slot: #{b[:slot]}"
        puts "Vehicle: #{b[:vehicle]}"
        puts "Plan: #{b[:plan]}"
        puts "\n"
      end
    end
  end
end