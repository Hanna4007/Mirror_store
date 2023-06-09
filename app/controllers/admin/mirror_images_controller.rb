class Admin::MirrorImagesController < ApplicationController

    include Authentication

    before_action :no_authentication
    before_action :check_admin

    def destroy
        @mirror = Mirror.find(params[:mirror_id])
        @mirror.mirror_images.purge_later
        redirect_to edit_admin_mirror_path(@mirror)
    end     

    def check_admin
        unless current_user.admin?
          flash[:warning] = 'You don`t have permission to access this page'
          redirect_to mirrors_path
        end
      end
    
end
