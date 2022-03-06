class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @source = Source.find(params[:source_id])
    if @comment.save
      CommentChannel.broadcast_to @source, {comment: @comment, user: @comment.user}
    else
      @error_comment = @comment
      render "sources/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, source_id: params[:source_id])
  end
end
