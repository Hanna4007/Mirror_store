# frozen_string_literal: true

class OrdersController < ApplicationController
  include Authentication
  before_action :no_authentication

  def index
    @orders = current_user.orders.includes(order_items: :mirror)
                          .filter_status(params[:status])
                          .with_field_order(*params[:focus].to_s.split('-'))
  end

  def show
    @order = Order.includes(order_items: :mirror).find(params[:id])
    @order_items = @order.order_items
    @delivery = @order.delivery
  end
end
