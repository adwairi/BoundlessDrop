class UserController < ApplicationController
  before_action :authenticate_user!
  def show
    @id = current_user.id
    @user = User.find(@id)
    @user.valid?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end


  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end

end
