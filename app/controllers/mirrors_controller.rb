# frozen_string_literal: true

class MirrorsController < ApplicationController
  def index
    @mirrors = Mirror.includes(mirror_images_attachments: { blob: :variant_records })
                     .filter_installation(params[:installation])
                     .filter_lamp(params[:lamp])
                     .with_field_order(*params[:order].to_s.split('-'))
  end

  def show
    @mirror = Mirror.find(params[:id])
    @order_items = current_order.order_items.new if current_user.present?
  end
end
