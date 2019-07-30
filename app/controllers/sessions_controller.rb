class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      session[:user] = user

      redirect_to root_path
    else
      flash[:alert] = I18n.t("users.alert.login")
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end

end
