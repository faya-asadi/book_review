class ReviewsController< ApplicationController
  before_action :set_book
  before_action :set_user


  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new #(book_id: params[:book_id])
  end

  def create
    @review = Review.new(review_params)
    @review.book = @book
    @review.user = @user
    if @review.save
      flash[:noticed] = "review for #{@book.title} is saved successfully"
        redirect_to book_path(@book)
    else
      render :new
    end
  end

  #edit review
  def edit
     @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.user = @user
    if @review.update(review_params)
      flash[:noticed] = "review is updated successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    #debugger
    @review = Review.find(params[:id])
    @review.destroy
    flash[:noticed] = "review  is deleted successfully"
    redirect_to book_path(@book)
  end


private
  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_user
    @user = User.first
  end

  def review_params
    params.require(:review).permit(:rate, :review)
  end
end
