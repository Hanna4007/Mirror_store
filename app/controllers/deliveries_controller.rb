class DeliveriesController < ApplicationController
  def new
    current_order
    @delivery = @order.delivery
    @delivery.destroy if @delivery.present?
    @delivery = @order.build_delivery  
  end
  
 def create
    current_order
    @delivery = @order.create_delivery(deliveries_params)
    if @delivery.valid?
      redirect_to order_verification_path 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @delivery = current_order.delivery
  end

  def update
    @delivery = current_order.delivery
    @delivery.update(deliveries_params)
    if @delivery.valid?
      redirect_to order_verification_path 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def deliveries_params
    params.require(:delivery).permit(:delivery_type, :post, :receiver_name, :receiver_surname, :receiver_phone_number, :city, :receiver_address, :post_office_number)
  end
end
