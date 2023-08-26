# frozen_string_literal: true

class Information < ApplicationRecord
  has_rich_text :delivery_information
  has_rich_text :company_information
  has_rich_text :contact_information
  has_one_attached :contact_image
end
