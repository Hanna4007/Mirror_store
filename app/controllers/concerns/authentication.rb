module Authentication
    extend ActiveSupport::Concern
      included do
        def authentication
          if current_user.present?
            flash[:warning] = 'You are already signed in!'
            redirect_to mirrors_path
          end
        end
  
        def no_authentication
          unless current_user.present?
            flash[:warning] = 'You are not signed in!'
            redirect_to mirrors_path
          end
        end
      end
  end