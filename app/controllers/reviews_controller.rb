class ReviewsController < ApplicationController

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

  private

  def review_params
    params.require(:review).permit(:rating, :product_id, :description)
  end
end
