module Admin::Concerns::AdminAuthentication
    extend ActiveSupport::Concern
      included do
         
        def check_admin
          unless current_user.admin?
            flash[:warning] = 'You don`t have permission to access this page'
            redirect_to mirrors_path
          end
        end
      end
end