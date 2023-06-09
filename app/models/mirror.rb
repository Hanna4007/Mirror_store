class Mirror < ApplicationRecord
  has_many_attached :mirror_images
  #accepts_nested_attributes_for :mirror_images, update_only: true
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

  VALID_INSTALLATION = [ 'wall', 'table' ]
  validates :installation, inclusion: { in: VALID_INSTALLATION }

  VALID_LAMP = [ 'built-in', 'outside' ]
  validates :lamp, inclusion: { in: VALID_LAMP }

  validates :price_square, presence: true


# scope :filter_installation_wall, -> { where(heater: true) }
# scope :filter_installation_table, -> { where(heater: false) }
 # scope :filter_instllation, ->(value) { where(heater: value) unless value.blank? }
 # scope :filter_light, ->(value) { where(light: value) unless value.blank? }
  scope :filter_installation, ->(value) { where(installation: value) unless value.blank? }
  scope :filter_lamp, ->(value) { where(lamp: value) unless value.blank? }
  scope :with_field_order, ->(field = nil, order = nil) {
    allowed_fields = ['price']
    field = nil if allowed_fields.exclude?(field)
    
    direction = order == 'desc' ? 'desc' : 'asc'
    
    order(field => direction) if field
 }

 



  def calculated_price
    if height == 50
      unit_price=(price_square*height*width*0.0001).round
    elsif height==80
      unit_price=(price_square*height*width*0.0001*1.15).round
    else
      unit_price=(price_square*height*width*0.0001*1.3).round
    end

    if glass_thickness==6
      unit_price+=635
    else
      unit_price
    end

    if heater==true
      unit_price+=1110
    else
      unit_price
    end 
  end



  private 
 
 # def update_price
  #  self.price = calculated_price
 # end

end
