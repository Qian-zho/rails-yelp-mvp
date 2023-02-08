class ReviewsController < ApplicationController

  before_action :set_restaurant, only: %i[new create]

  def create

    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)

    if @review.save
      redirect_to @restaurant, notice: "Review was successfully created."
    else
      render :new
    end
  end

  def new
    @review = Review.new
  end


  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_path(@review.restaurant), status: :see_other
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:rating,:content)
  end
end
