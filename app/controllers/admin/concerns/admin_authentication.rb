# frozen_string_literal: true

module Admin
  module Concerns
    module AdminAuthentication
      extend ActiveSupport::Concern
      included do
        def check_admin
          return if current_user.admin?

          redirect_to mirrors_path, flash: { warning: I18n.t('no_access') }
        end
      end
    end
  end
end
