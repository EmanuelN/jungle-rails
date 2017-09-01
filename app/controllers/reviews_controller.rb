class ReviewsController < ApplicationController

  before_filter :require_login

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to :root
    else
      redirect_to @product, :flash => {:error => "Unable to save review"}
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to @product
  end

  private

  def require_login
    if current_user.nil?
      @product = Product.find(params[:product_id])
      redirect_to @product, :flash => {:error => "You must be logged in to access this feature."}
    end
  end

  def review_params
    params.require(:review).permit(:rating, :product_id, :description)
  end
end
