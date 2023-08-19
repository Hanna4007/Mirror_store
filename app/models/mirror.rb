class Mirror < ApplicationRecord
  include MirrorPriceCalculation

  has_many_attached :mirror_images
  has_many :order_items
  has_rich_text :description
  
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

  scope :filter_installation, ->(value) { where(installation: value) unless value.blank? }
  scope :filter_lamp, ->(value) { where(lamp: value) unless value.blank? }
  scope :with_field_order, ->(field = nil, order = nil) {
    allowed_fields = ['price_square']
    field = nil if allowed_fields.exclude?(field)
    
    direction = order == 'desc' ? 'desc' : 'asc'
    
    order(field => direction) if field
 }

  
end
