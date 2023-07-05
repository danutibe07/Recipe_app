class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = current_user
  end

  def show
    if params[:id] == 'sign_out'
      sign_out(current_user)
      redirect_to root_path, notice: 'You have been signed out successfully.'
    else
      @user = User.find(params[:id])
    end
  end
end
