class City
  def initialize
    @cities = {
            Pune: ["Baner","Wakad","Balewadi"],
            Mumbai: ["Andheri","Dadar","Thane"],
            Nashik: ["CIDCO","Pnchavati","College Road"] 
          }

    @buildings = {
      Tower_A: {bike_floors: [:Floor_1 , :Floor_2], 
                car_floors: [:Floor_3 , :Floor_4] },

      Tower_B: {bike_floors: [:Floor_1 , :Floor_2], 
                car_floors: [:Floor_3 , :Floor_4] }}


    @tower_a = {
      Floor_1: create_slots("A",4), 
      Floor_2: create_slots("B",4),
      Floor_3: create_slots("c",4),
      Floor_4: create_slots("D",4) }

    @tower_b = {
      Floor_1: create_slots("B",4), 
      Floor_2: create_slots("B",4),
      Floor_3: create_slots("c",4),
      Floor_4: create_slots("c",4) }

    @plan = {
      bike: {
        daily: {price: 40, desc: "Per day(24 hrs)"}, 
        weekly: {price: 270, desc: "7 days"}, 
        monthly: {price: 1100, desc: "30 days"}, 
        quarterly: {price: 3400, desc: "90 days"},
        yearly: {price: 14000, desc: "1 year"} },
      

      car:{
          daily: {price: 70, desc: "Per day(24 hrs)"},
          weekly: {price: 460, desc: "7 days"},
          monthly: {price: 1900, desc: "30 days"},
          quarterly: {price: 6000, desc: "90 days" },
          yearly: {price: 25000, desc: "1 year"}}}         
            
    end

  def create_slots(prefix,count)
    slots = {}
    (1..count).each do |i|
      slots ["#{prefix}#{i}".to_sym] = 0
    end
    slots
  end
end
   