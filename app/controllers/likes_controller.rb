class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_source, only: [:create, :destroy]

  def create
    like = current_user.likes.find_or_create_by(source_id: params[:source_id], user_id: current_user.id)
  end

  def destroy
    like = Like.find_by(source_id: params[:source_id], user_id: current_user.id)
    like.destroy
  end

  private
  def find_source
    @source = Source.find(params[:source_id])
  end
end
