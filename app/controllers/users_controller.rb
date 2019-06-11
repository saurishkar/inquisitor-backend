class UsersController < ApplicationController
  include UsersHelper
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(permit_params)
    if @user.save
      set_user_session
      redirect_to users_path
    else
      render 'new'
    end
  end

  def logout
    if params[:user_id] == session[:current_user].to_s
      reset_user_session
    end
    redirect_to root_path
  end

  def login
    if User.authenticate(permit_params[:email], permit_params[:password])
      @user = User.find_by_email(permit_params[:email])
      set_user_session
      redirect_to users_path
    else
      redirect_to root_path, notice: "Invalid Email or password"
    end
  end

  private

  def permit_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end
