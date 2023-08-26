# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern
  included do
    def authentication
      return unless current_user.present?

      redirect_to mirrors_path, flash: { warning: I18n.t('you_are_already_signed_in') }
    end

    def no_authentication
      return if current_user.present?

      redirect_to mirrors_path, flash: { warning: I18n.t('you_are_not_signed_in') }
    end

    def no_user
      return if current_user.present?

      @mirror = Mirror.find(order_items_params[:mirror_id])
      redirect_to mirror_path(@mirror), flash: { warning: I18n.t('you_are_not_signed_in') }
    end
  end
end
