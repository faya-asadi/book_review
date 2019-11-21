class ReviewsController< ApplicationController
  before_action :set_book
  before_action :set_user
  before_action :set_review, only: [:edit, :update, :destroy, :show]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def show
    if params[:sort]
       @reviewes = Review.order(params[:sort] + ' ' + params[:direction])
    end
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

  end

  def update
    @review.user = @user
    if @review.update(review_params)
      flash[:noticed] = "review is updated successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:noticed] = "review  is deleted successfully"
    redirect_to book_path(@book)
  end


private
  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_user
    @user = current_user
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rate, :review)
  end

  def require_same_user
    if current_user != @review.user
      flash[:danger]= "you can perform this action only if you're the one who wrote this review!"
      redirect_to root_path
    end
  end

end
