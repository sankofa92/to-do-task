class Admin::UsersController < ApplicationController

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end
  
end
