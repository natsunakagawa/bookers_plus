class BooksController < ApplicationController
	
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end
  def show
    @mybook = Book.find(params[:id])
    @user = User.find(@mybook.user.id)
    @book = Book.new 
  end

  def create
    @books = Book.all
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
    @user = User.find(current_user.id)
  	if @book.save
  		flash[:create] = "You have created book successfully"
  		redirect_to book_path(@book)
  	else
  		render 'index'
  	end
  end

   def edit
    @mybook = Book.find(params[:id])
    @user = User.find(@mybook.user.id)
  end
  def update
    @mybook = Book.find(params[:id])
    @user = User.find(@mybook.user.id)
    if @mybook.update(book_params)
      flash[:update] = "You have updated book successfully."
      redirect_to book_path(@mybook)
    else
      render 'show'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def correct_user
    @user = User.find(params[:id])
    if current_user == @user
      redirect_to books_path
    end      
  end
  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
