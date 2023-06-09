class OrderController < ApplicationController
  include Authentication
  before_action :no_authentication
  def show
    @order_items = current_order.order_items
  end

end
