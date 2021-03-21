class Api::V1::SessionsController < Api::BaseController
  skip_before_action :authenticate, only: %I[create social_login]

  def create
    @user = User.find_by email: permited_parameter[:email]
    if @user&.authenticate?(params[:password])
      sign_in @user
      render json: { session_token: current_session&.id, current_user: current_user.info }
    else
      render_errors I18n.t('errors.wrong_email_or_password'), :unauthorized
    end
  end

  def destroy
    sign_out
    render_ok
  end
end
