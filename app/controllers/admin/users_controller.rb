class Admin::UsersController < ApplicationController

  include Authentication
  include Admin::Concerns::AdminAuthentication
  
  before_action :no_authentication
  before_action :check_admin

  def index
    @users = User.filter_phone_number(params[:phone_number])
                  .filter_status(params[:admin])
  end

  def show
    @user = User.find(params[:id])
  end  
     

    def new
        @user = User.new
    end    


    def create
        create_user
                    
        if @user.valid?
          redirect_to mirrors_path
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        @user = User.find(params[:id])
      end
    
      def update
        @user = User.find(params[:id])
                
        if @user.update(user_params)
          redirect_to admin_user_path(@user)
        else
          render :edit, status: :unprocessable_entity
        end
      end

    private
    def create_user
        @user = User.create(user_params)
    end

    def user_params
        params.require(:user).permit(:admin)
    end
end
