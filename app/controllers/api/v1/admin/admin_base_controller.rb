module Api
  module V1
    module Admin
      class AdminBaseController < Api::BaseController
        before_action :check_permissions

        private

        def check_permissions
          return render_errors I18n.t("admin.errors.permission_denied"), 401 if current_user.user?
        end
      end
    end
  end
end
