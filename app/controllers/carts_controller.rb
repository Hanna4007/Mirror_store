class CartsController < ApplicationController
    include Authentication
    before_action :no_authentication
    
    def show
      @order_items = current_order.order_items.includes(mirror: [mirror_images_attachments: :blob])
      @delivery = current_order.delivery
    end
  
    def edit
      if current_order.order_items.empty?
        redirect_to mirrors_path
        flash[:warning] = I18n.t("cart_is_empty")
      else
        @order_items = current_order.order_items.includes(mirror: [mirror_images_attachments: :blob])
        @delivery = current_order.delivery
      end
    end
  
    def update
      current_order.update(status: 'confirmed')
      session.delete(:order_id)
      flash[:success] = I18n.t("thank_you_for_your_order")
      redirect_to mirrors_path
    end
  end