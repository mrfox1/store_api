module Api
  module V1
    module Admin
      class AdminUsersController < AdminBaseController
        def index
          @users = User.all
        end

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

        private

        def create_params
          params.permit(
            :email,
            :password
          )
        end
      end
    end
  end
end
