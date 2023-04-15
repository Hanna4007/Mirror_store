class Mirror < ApplicationRecord
 

    has_many_attached :mirror_images
    has_many :order_items

   #before_validation :update_price

    validates :name, presence: true
    
    validates :height, presence: true
    VALID_HEIGHT = [ 50, 80, 100 ]
    validates :height, inclusion: { in: VALID_HEIGHT }

    validates :width, presence: true
    VALID_WIDTH = [ 50, 80 ]
    validates :width, inclusion: { in: VALID_WIDTH }

    validates :glass_thickness, presence: true
    VALID_GLASS_THICKNESS = [ 4, 6 ]
    validates :glass_thickness, inclusion: { in: VALID_GLASS_THICKNESS }

    VALID_LIGHT = [ 'warm', 'neutral', 'cold' ]
    validates :light, inclusion: { in: VALID_LIGHT }

    validates :price, presence: true

    #def calculate_price
       #if height==50
      #  price=(price_square*height*width*0.0001).round
      # elsif height==80
  # price=(price_square*height*width*0.0001*1.15).round
   # else
   # price=(price_square*height*width*0.0001*1.3).round
  #  end
  #  end

  # private 
  # def update_price
  # self.price = calculate_price
 #end
end
