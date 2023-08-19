class ApplicationController < ActionController::Base
  
    helper_method :current_user, :current_order
   
    private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def current_order
      @current_order ||= if session[:order_id].nil?
        order = current_user.orders.last
        order&.status =='in progress' ? order : current_user.orders.new
       else
        current_user.orders.find_by(id: session[:order_id]) || current_user.orders.new
      end
    end
end
