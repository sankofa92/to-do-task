class Admin::UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: I18n.t('users.notice.create')
    else
      render :new, alert: I18n.t('users.alert.create')
    end
  end

  def show
    @tasks = @user.tasks.order(end_at: :asc).page(params[:page]).per(10)
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: I18n.t('users.notice.update')
    else
      render :edit, alert: I18n.t('users.alert.update')
    end
  end
  
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: I18n.t('users.alert.destroy')
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
