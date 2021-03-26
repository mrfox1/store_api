module Api
  module V1
    module Admin
      class AdminUsersController < AdminBaseController
        def index
          @users = User.all
        end
      end
    end
  end
end
