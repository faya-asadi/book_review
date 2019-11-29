class BooksController < ApplicationController

  before_action :set_book, only: [ :edit, :destroy, :update]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin_user, only: [:destroy]
  before_action :require_user, except: [:show, :index]


  def index

    if params[:sort]
      @books = Book.order(params[:sort] + ' ' + params[:direction])
    else
       @books =  Book.all
    end
    if params[:filter]
      @books = @books.find_all{|b| b.title.downcase.include? (params[:filter].downcase)}
    end
  end

  def show
    book = Book.find(params[:id])
      if params[:sort]
        book.reviews = []
        @reviews = Review.order(params[:sort] + ' ' + params[:direction])
        book.reviews = @reviews
      end
      @book = book
  end
#create new book __________________
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:noticed] = "book is saved successfully"
        redirect_to book_path(@book)
    else
      render :new
    end
  end

  #edit book
  def edit
  end

  def update
    if @book.update(book_params)
      flash[:noticed] = "book is updated successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

def destroy
  @title = @book.title
  @book.destroy
  flash[:noticed] = "book "+ @title +" is deleted successfully"
  redirect_to books_path
end


private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author)
  end

  def require_same_user
    if  current_user == nil ||( current_user != @book.user && !current_user.admin?)
      flash[:danger]= "you can perform this action only if you're the one who wrote this review!"
      redirect_to root_path
    end
  end
end
