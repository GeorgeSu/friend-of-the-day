class UsersController < ApplicationController  
    
  before_filter :save_login_state, :only => [:new, :create]
    
  def new
    @user = User.new
    session[:user_id] = @user.id
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    redirect_to home_path
  end
  
  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
end