class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
    if @review.save
        redirect_to restaurants_path
      else
        if @review.errors[:user]
          redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
        else
          render :new
        end
      end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review
      @review.destroy
      flash[:notice] = 'Review deleted succesfully'
      redirect_to '/restaurants'
    else
      flash[:alert] = 'Nothing to delete'
      redirect_to restaurants_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
