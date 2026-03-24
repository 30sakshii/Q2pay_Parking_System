require_relative './city'
require_relative './booking'

class ParkingSystem < City
  def initialize
    super()
    @booking_service = Booking.new
  end

  def select_city
    selected_city = nil

    loop do
      puts 'Select City: '
      @cities.each_with_index do |(c,l), index|
        puts "#{index + 1}. #{c}"
      end
      puts "0. Back"
     
      input = gets.chomp
      return nil if input == "0"

      unless input.match?(/\A[1-9]\Z/)
        puts 'Please enter a number!'
        next
      end

      input = input.to_i
      selected_city = @cities.keys[input - 1]

      if selected_city
        puts "Selected City: #{selected_city}"
        break
      else
      puts 'Invalid choice! Try again: '          
      end
    end
    return selected_city
  end


  def select_location(city)
    selected_location = nil

    loop do
      puts 'Select Location: '
      @cities[city].each_with_index do |loc, index|
        puts "#{index + 1}. #{loc}"
      end
       puts "0. Back"

      input = gets.chomp
      return nil if input == "0"

      unless input.match?(/\A[1-9]\Z/)
        puts 'Please enter a number!'
        next
      end

      input = input.to_i
      selected_location = @cities[city][input - 1]

      if selected_location
        puts "Selected Location: #{selected_location}"
        break
      else
        puts 'Invalid choice! Try again: '          
      end
    end
    return selected_location
  end


  def select_building
    selected_building = nil
    keys = @buildings.keys

    loop do
      puts 'Select Building: '
      keys.each_with_index do |b_name, index|
        puts "#{index + 1}. #{b_name}"
      end

      puts "0. Back"

      input = gets.chomp

      return nil if input == "0"

      unless input.match?(/\A[1-9]\Z/)
        puts 'Please enter a number!'
        next
      end

      input = input.to_i
      selected_building = keys[input - 1]

      if selected_building
        puts "Selected Building: #{selected_building}"
        break
      else
        puts 'Invalid choice! Try again: '              
      end
    end
    return selected_building
  end

       
  def select_vehicle
    vehicle = nil

    loop do
      puts 'Select Vehicle Type: '
      puts '1. Bike'
      puts '2. Car'
      puts '0. Back'

      input = gets.chomp
      return nil if input == "0"

      unless input.match?(/\A[1-9]\Z/)
        puts 'Please enter a number!'
        next
      end
     
      input = input.to_i

      if input == 1 || input == 2
        vehicle = input
        break
      else
        puts 'Invalid choice! Try again: '
      end
    end
    return vehicle
  end


  def select_floor(building, vehicle_type)
    selected_floor = nil

    floors = vehicle_type == 1 ? @buildings[building][:bike_floors] : @buildings[building][:car_floors]      
   
    loop do
      puts 'Select Floor: '
      floors.each_with_index do |floor, index|
        puts "#{index + 1}. #{floor}"
      end
      puts "0. Back"

      input = gets.chomp

      return nil if input == "0"

      unless input.match?(/\A[1-9]\Z/)
        puts 'Please enter a number!'
        next
      end

      input = input.to_i
      selected_floor = floors[input - 1]

      if selected_floor
        puts "Selected Floor: #{selected_floor}"
        break
      else
        puts 'Invalid choice! Try again: '        
      end
    end
    return selected_floor
  end


  def select_slot(tower, floor, vehicle_type)
    slots = tower[floor]
    capacity = vehicle_type == 1 ? 3 : 2

    selected_slot = nil

    loop do
      puts 'Available Slots: '

      slots.each_with_index do |(slot, count), index|
        status = count >= capacity ? "FULL" : "#{count}/#{capacity}"
        puts "#{index + 1}. Slot: #{slot} - Status: #{status}"

        related = @booking_service.bookings.select do |b|
          b[:floor] == floor && b[:slot] == slot && b[:end_time] > Time.now
        end

        if related.count >= capacity
          free_time = related.map { |b| b[:end_time] }.min
          puts "   FREE AFTER: #{free_time.strftime('%Y-%m-%d %H:%M:%S')}"
        end
      end

      puts "0. Back"

      input = gets.chomp

      return nil if input == "0"

      unless input.match?(/\A[1-9]\Z/)
        puts 'Please enter a number!'
        next
      end

      input = input.to_i
      selected_slot = slots.keys[input - 1]

      if selected_slot.nil?
        puts 'Invalid choice! Try again.'
      elsif slots[selected_slot] >= capacity
        puts 'Slot FULL! Choose another.'
      else
        slots[selected_slot] += 1
        puts "Selected Slot: #{selected_slot}"
        break
      end
    end

    return selected_slot
  end



  def select_plan(vehicle)
    type = vehicle == 1 ? :bike : :car
    available = @plan[type]
    # puts type
    # puts available
    keys = available.keys
    # puts keys

    loop do
      puts "\nAvailable Plans: "

      available.each_with_index do |(plan, details), index|
        puts "#{index + 1}. #{plan.capitalize}"
        puts "   Price: ₹#{details[:price]}"
        puts "   Info: #{details[:desc]}"
      end

      puts "0. Back"

      puts 'Select Plan: '

      input = gets.chomp

      return nil if input == "0"

      unless input.match?(/\A[1-9]\Z/)
        puts 'Please enter a number!'
        next
      end

      input = input.to_i
      selected_plan = keys[input - 1]

      if selected_plan
        puts "Selected Plan: #{selected_plan}"
        return [selected_plan, available[selected_plan][:price]]
      else
        puts 'Invalid choice! Try again.'
      end
    end
  end


  def book_parking
   
    loop do
      city = select_city
      next if city.nil?

      loop do
        location = select_location(city)
        break if location.nil?

        loop do
          building = select_building
          break if building.nil?

          loop do
            vehicle = select_vehicle
            break if vehicle.nil?

            loop do
              floor = select_floor(building, vehicle)
              break if floor.nil?

              tower = building == :Tower_A ? @tower_a : @tower_b

              loop do
                slot = select_slot(tower, floor, vehicle)
                break if slot.nil?

                plan, price = select_plan(vehicle)
                break if plan.nil?

 

                puts 'Enter your name: '
                name = gets.chomp
                until name.match?(/\A[A-Za-z ]+\z/)
                  puts 'Invalid name special characters not allowed! Try again: '
                  name = gets.chomp
                end

                puts 'Enter your Phone: '
                phone = gets.chomp
                until phone.match?(/\A\d{10}\z/)
                  puts 'Invalid phone number! Only 10 digits allowed. Try again: '
                  phone = gets.chomp
                end

                puts 'Enter your vehicle No: '
               
                codes = ["MH","DL","KA","GJ","RJ"]
                vehicle_no = nil

                loop do
                vehicle_no = gets.chomp.upcase

                if vehicle_no.length != 10
                  puts 'Invalid format! (Example: MH10DR5678) Please Try again: '
                  next
                end
   
                state = vehicle_no.slice(0,2)
                rto = vehicle_no.slice(2,2)
                series = vehicle_no.slice(4,2)
                number = vehicle_no.slice(6,4)

                if !codes.include?(state)
                  puts 'Invalid State code! Try again: '
                elsif !rto.match?(/\A\d{2}\Z/)
                  puts 'Invalid RTO code! Try again: '
                elsif !series.match?(/\A[A-Za-z]{2}\Z/)
                  puts 'Invalid series! Try again: '
                elsif !number.match?(/\A\d{4}\Z/)
                  puts 'Invalid vehicle number! Try again: '
                elsif @booking_service.bookings.any? { |b| b[:vehicle_no] == vehicle_no }
                  puts 'duplicate number! Please enter your own vehicle number: '

                else
                  break
                  end
                end    
   
                start_time = Time.now

                duration = case plan 
                when :daily then 24 * 60 * 60
                when :weekly then 7 * 24 * 60 * 60
                when :monthly then 30 * 24 * 60 * 60
                when :quarterly then 90 * 24 * 60 * 60
                when :yearly then 365 * 24 * 60 * 60
                end

                end_time = start_time + duration
   

                booking = {
                  id: @booking_id,
                  city: city,
                  location: location,
                  building: building,
                  floor: floor,
                  slot: slot,
                  vehicle: vehicle == 1 ? "Bike" : "Car",
                  name: name,
                  phone: phone,
                  vehicle_no: vehicle_no,
                  plan: plan,
                  price: price,
                  start_time: start_time,  
                  end_time: end_time

                }
               

                  @booking_service.add_booking(booking)
                  return
              end
            end
          end
        end
      end
    end
  end


  def view_bookings
    @booking_service.view_bookings
  end

  def view_booking_by_id
    @booking_service.view_booking_by_id
  end

  def delete_booking
    @booking_service.delete_booking(@tower_a, @tower_b)
  end

  def view_booking_by_city
    @booking_service.view_booking_by_city(@cities)
  end

  def view_booking_by_vehicle
    @booking_service.view_booking_by_vehicle
  end

  def view_booking_by_building
    @booking_service.view_booking_by_building(@buildings)
  end
           

 
 

end