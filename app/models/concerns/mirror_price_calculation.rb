module MirrorPriceCalculation 

  def price_calculation
    unit_price = size_unit_price + glass_thickness_coefficient + heater_coefficient
  end 

private    
  def size_unit_price
    size_coefficient = {
          50 => 1.0,
          80 => 1.15,
          100 => 1.3
        }   
        coefficient = size_coefficient[height]        
    unit_price = (price_square * height * width * 0.0001 * coefficient).round
    
  end

  def glass_thickness_coefficient
    glass_thickness==6 ? 635 : 0
  end

  def heater_coefficient
    heater? ? 1110 : 0
  end
 
end