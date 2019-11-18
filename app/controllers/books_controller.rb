class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :destroy, :update]

  def show
    #@book = Book.find(params[:id])
  end
#create new book __________________
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:noticed] = "book is saved successfully"
        redirect_to book_path(@book)
    else
      render :new
    end
  end

  #edit book
  def edit
    #@book = Book.find(params[:id])
  end

  def update
    #@book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:noticed] = "book is updated successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

def destroy
  #@book = Book.find(params[:id])
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
end
