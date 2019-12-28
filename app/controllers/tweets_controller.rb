class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
    @tweet = Tweet.new
  end

  def index
    if params[:search]
      @tweets = Tweet.where("body LIKE ? ",'%' + params[:search] + '%').order(id: "DESC")
    else
      @tweets = Tweet.all.order(id: "DESC")
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @comments = @tweet.comments
    @comment = Comment.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.save
    redirect_to tweets_path
  end

  private
    def tweet_params
      params.require(:tweet).permit(:body, :cl_image)
    end
end
