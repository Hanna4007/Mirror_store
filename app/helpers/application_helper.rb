module ApplicationHelper

    def current_order 
        @user = current_user
      if !session[:order_id].nil?
        @order = @user.orders.find(session[:order_id])
      else
        @user.orders.last&.status=='not paid' ? @order = @user.orders.last : @order = @user.orders.new
      end    
    end
end

    
