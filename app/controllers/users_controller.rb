class UsersController < ApplicationController

  include Authentication

  before_action :authentication, only: %i[new create]
  before_action :no_authentication, only: %i[edit update]

    def new
        #@current_user = User.new
        @user = User.new
    end    

    def create
      create_user
       session[:user_id] = @user.id 
            
        if @user.valid?
          flash[:success] = I18n.t("welcome_user", name: @user.name)
          redirect_to mirrors_path
        else
          render :new, status: :unprocessable_entity
        end
      end

  def edit   
  end    


def update
    
    if current_user.update(user_params)
      flash[:success] = I18n.t("your_profile_was_updated")
      redirect_to(params[:redirect] || mirrors_path)
    else
      render :edit, status: :unprocessable_entity
    end
  end

    private
    def create_user
        @user = User.create(user_params)
        
      end

    def user_params
        params.require(:user).permit(:email, :name, :password, :password_confirmation, :phone_number)
    end
end
