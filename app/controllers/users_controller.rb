class UsersController < ApplicationController

  include Authentication

  before_action :authentication, only: %i[new create]
  before_action :no_authentication, only: %i[edit update]

    def new
        @user = User.new
    end    


    def create
        create_user
        session[:user_id] = @user.id 
            
        if @user.valid?
          redirect_to mirrors_path
        else
          render :new, status: :unprocessable_entity
        end
      end

   # def create
        #@user = User.new user_params
       # if @user.save
       #   redirect_to mirrors_path
      #  else
      #    render :new
      #  end
   # end 

   def edit
    @user = User.find(session[:user_id])
   end    


def update
   @user = User.find(session[:user_id])   
    @user.update(user_params)
        
    if @user.valid?
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
        params.require(:user).permit(:email, :name, :password, :password_confirmation, :phone_number, :admin)
    end
end
