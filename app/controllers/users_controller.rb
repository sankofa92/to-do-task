class UsersController < ApplicationController
  # protect_from_forgery prepend: true

  def new
    @user = User.new
    
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to '/login', notice: I18n.t('users.notice.create')
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_comfirmation)
  end
end
