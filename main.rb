require_relative './ParkingSystem'
system = ParkingSystem.new

loop do 
    puts "Welcome to Parking System"

    puts "1. Book Parking"
    puts "2. View Booking"
    puts "3. View Booking by ID"
    puts "4. Search Booking by City"
    puts "5. Search Booking by Vehicle Number"
    puts "6. Search Booking by Building"
    puts "7. cancel Booking"
    puts "8. Exit"

    choice = gets.chomp.to_i

    case choice 
    when 1 
        system.book_parking
    when 2
        system.view_bookings
    when 3
        system.view_booking_by_id
    when 4
        system.view_booking_by_city
    when 5
        system.view_booking_by_vehicle
    when 6
        system.view_booking_by_building
    when 7
        system.delete_booking
    when 8
        puts "Thank you..."
    else
        puts "Invalid Choice"
    end 
    break if choice == 8
end

