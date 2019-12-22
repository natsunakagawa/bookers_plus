class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @users = User.all
  end

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:update] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render 'show'
    end
  end

  private
  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user.id)
    end
    
  end
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
 
end
