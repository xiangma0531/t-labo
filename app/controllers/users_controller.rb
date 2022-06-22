class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @sources = @user.sources.order(updated_at: 'DESC')
    @favorites = @user.favorites.order(created_at: 'DESC')
    @followings = @user.followings.order(created_at: 'DESC')
    @followers = @user.followers.order(created_at: 'DESC')
    @rooms = Entry.all.where.not(user_id: current_user.id)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
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
  
  private
  def set_user
    @user = User.find(params[:id])
  end
end
