class RoomsController < ApplicationController
  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room_id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entry = @room.entries.where.not(user_id: current_user.id)
    end
  end

end
