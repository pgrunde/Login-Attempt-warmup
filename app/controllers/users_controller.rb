class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :ensure_current_user


  def index
    @user = User.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end



  def show
    @user = User.order(:email)
  end
end

  private
  def allowed_params
    params.require(:user).permit(:email, :password)
  end



