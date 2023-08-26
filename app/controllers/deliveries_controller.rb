# frozen_string_literal: true

class DeliveriesController < ApplicationController
  include Authentication

  before_action :no_authentication

  def new
    if current_order.order_items.empty?
      redirect_to mirrors_path, flash: { warning: I18n.t('cart_is_empty') }
    else
      @delivery = current_order.build_delivery
    end
  end

  def create
    @delivery = current_order.create_delivery(deliveries_params)
    if @delivery.valid?
      redirect_to edit_carts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @delivery = current_order.delivery
  end

  def update
    @delivery = current_order.delivery
    if @delivery.update(deliveries_params)
      redirect_to edit_carts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def deliveries_params
    params.require(:delivery).permit(:delivery_type, :post, :receiver_name, :receiver_surname, :receiver_phone_number,
                                     :city, :region, :receiver_address, :post_office_number)
  end
end
