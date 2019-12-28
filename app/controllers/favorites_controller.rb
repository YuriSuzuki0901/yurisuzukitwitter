class FavoritesController < ApplicationController
  def create
      @favorite = current_user.favorites.new(tweet_id: params[:tweet_id])
      @favorite.save
      redirect_to tweets_path
  end

  def destroy
    @favorite =  current_user.favorites.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    @favorite.destroy
    redirect_to tweets_path
  end
end
