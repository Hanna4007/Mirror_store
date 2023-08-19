class OrdersController < ApplicationController
  include Authentication
  before_action :no_authentication
  
  def index
    @orders=current_user.orders.includes(:order_items => :mirror)
    .filter_status(params[:status])
    .with_field_order(*params[:focus].to_s.split('-'))
  end

  def show
    @order = Order.includes(:order_items => :mirror).find(params[:id])
    @order_items = @order.order_items
    @delivery = @order.delivery
  end

  def show_current_order
    @order_items = current_order.order_items.includes(mirror: [mirror_images_attachments: :blob])
    @delivery = current_order.delivery
  end

  def order_verification
   current_order
    if @order.order_items.empty?
      redirect_to mirrors_path
      flash[:warning] = 'Your cart is empty. Please add items to your cart before proceeding.'
    else
    @order_items = current_order.order_items.includes(mirror: [mirror_images_attachments: :blob])
    @delivery = current_order.delivery
  end
  end

  def order_confirm
    current_order.update(status: 'confirmed')
    session.delete(:order_id)
    flash[:success] = 'Thank you for your order. We will contact you shortly'
    redirect_to mirrors_path
  end
end
