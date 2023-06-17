class SessionsController < ApplicationController
    include Authentication

  before_action :authentication, only: %i[new create]
  before_action :no_authentication, only: %i[destroy]


    def new
    end

    def create
        user_params = params.require(:session)
        user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password]) 

        if user.present?
        session[:user_id] = user.id 
        redirect_to mirrors_path
         else
        render :new
        end  
    end

    def destroy
        session.delete(:order_id)
        session.delete(:user_id)
        redirect_to mirrors_path
    end

end
