# frozen_string_literal: true

module Admin
  class MirrorImagesController < ApplicationController
    include Authentication
    include Admin::Concerns::AdminAuthentication

    before_action :no_authentication
    before_action :check_admin

    def destroy
      @mirror = Mirror.find(params[:mirror_id])
      @mirror.mirror_images.purge_later
      redirect_to edit_admin_mirror_path(@mirror)
    end
  end
end
