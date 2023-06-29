class OrderController < ApplicationController
  include Authentication
  before_action :no_authentication
  def show
    @order_items = current_order.order_items
    @delivery = current_order.delivery
  end

  def order_verification
    @order_items = current_order.order_items
    @delivery = current_order.delivery
  end

  def order_confirm
    current_order.update(status: 'confirmed')
    session.delete(:order_id)
    flash[:success] = 'Thank you for your order. We will contact you shortly'
    redirect_to mirrors_path
  end
end
