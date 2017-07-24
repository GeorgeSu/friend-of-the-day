class UsersController < ApplicationController

  skip_before_filter :authenticate, :only => ['new', 'create']
  before_filter :check_is_user, :except => ['new', 'create', 'show']
  before_filter :set_user, :except => ['new', 'create']
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def new
    @user = User.new
    session[:user_id] = @user.id
    render 'new'
  end
  
  def index
     render 'index' 
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      #EmailStudents.welcome_email(@user).deliver_later

      session[:user_id] = @user.id
      session[:user_email] = @user.email
      redirect_to without_team_path, :notice => "You signed up successfully!"
      # send a confirmation email
      # EmailStudents.welcome_email(@user).deliver_now
      # byebug

    else
      render 'new', :notice => "Form is invalid"
    end
  end



  def update
    @user.update_attributes!(user_params)
  end

  private
  def check_is_user
      
  end
  
  def set_user
    @user = User.find_by_id session[:user_id]
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
