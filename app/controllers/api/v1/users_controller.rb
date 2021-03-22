class Api::V1::UsersController < Api::BaseController
  skip_before_action :authenticate, only: :create

  def profile
    render json: { current_user: current_user.info }
  end

  def create
    @user = User.new create_params
    if @user.save
      sign_in @user
      render json: { session_token: current_session&.id, current_user: current_user.info }
    else
      render_errors @user.errors.full_messages
    end
  end

  def update
    current_user.assign_attributes profile_params
    if current_user.save
      profile
    else
      render_errors current_user.errors.full_messages
    end
  end

  def destroy
    current_user.destroy
    render_ok
  end

  private

  def create_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def profile_params
    params.permit(:first_name, :last_name)
  end
end
