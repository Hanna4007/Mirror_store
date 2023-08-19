module Authentication
    extend ActiveSupport::Concern
      included do
        def authentication
          if current_user.present?
            flash[:warning] = I18n.t("you_are_already_signed_in")
            redirect_to mirrors_path
          end
        end
  
        def no_authentication
          unless current_user.present?
            flash[:warning] = I18n.t("you_are_not_signed_in")
            redirect_to mirrors_path
          end
        end

        def no_user
          unless current_user.present?
            flash[:warning] = I18n.t("you_are_not_signed_in")
            @mirror = Mirror.find(order_items_params[:mirror_id])
            redirect_to mirror_path(@mirror)
          end
        end
      end
  end