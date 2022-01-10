class CommentChannel < ApplicationCable::Channel
  def subscribed
    @source = Source.find(params[:source_id])
    stream_for @source
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
