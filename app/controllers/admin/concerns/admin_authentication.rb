module Admin::Concerns::AdminAuthentication
    extend ActiveSupport::Concern
      included do
         
        def check_admin
          unless current_user.admin?
            flash[:warning] = I18n.t("no_access")
            redirect_to mirrors_path
          end
        end
      end
end