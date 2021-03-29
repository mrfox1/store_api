module Api
  module V1
    module Admin
      class AdminUsersController < AdminBaseController
        before_action :set_user, only: %I[show destroy]

        def index
          @users = User.all
        end

        def show; end

        def create_admin
          user = User.find_by(email: permited_parameter[:email])
          if user.present?
            user.assign_attributes(role: 'admin')
          else
            user = User.new(create_params)
            user.admin!
          end
          save_record user
        end

        def destroy
          @user.destroy
          render_ok
        end

        private

        def create_params
          params.permit(
            :email,
            :password
          )
        end

        def set_user
          @user = User.find_by(id: permited_parameter[:id])
          return render_errors I18n.t("errors.not_found"), 404 unless @user.present?
        end
      end
    end
  end
end
