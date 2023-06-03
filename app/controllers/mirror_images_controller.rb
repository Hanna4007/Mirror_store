class MirrorImagesController < ApplicationController

    def destroy
        @mirror = Mirror.find(params[:mirror_id])
        @mirror.mirror_images.purge_later
        redirect_to edit_mirror_path(@mirror)
    end     
    
end
