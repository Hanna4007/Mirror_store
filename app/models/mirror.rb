class Mirror < ApplicationRecord

    has_many_attached :mirror_images
    has_many :order_items

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

    
        
    
        
    

end
