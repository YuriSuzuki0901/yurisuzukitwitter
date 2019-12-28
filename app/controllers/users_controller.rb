class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @follows = @user.followings
    @followers = @user.followers
    @tweets = @user.tweets
    @favorite_tweets = @user.favorite_tweets
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    # binding.pry
    user = User.find(params[:id])
    @users = user.followers
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    current_user.assign_attributes(account_update_params)
    if current_user.save
	  redirect_to tweets_path, notice: 'プロフィールを更新しました'
    else
      render "edit"
    end
  end
  protected



  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :cl_image])
  end



end
