class ApplicationController < ActionController::Base
    include  ApplicationHelper

    helper_method :current_user
   
    private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
    end
end
