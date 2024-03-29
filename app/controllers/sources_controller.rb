class SourcesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_source, only: [:show, :edit, :update]
  before_action :search_source, only: [:index, :search]
  before_action :move_to_index, except: [:index, :new, :create, :show, :search]

  def index
    # @sources = Source.all
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.new(source_params)
    if @source.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = @source.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
  end

  def update
    if params[:source][:source_image_id]
      @source.image.purge
    end
    if @source.update(source_params)
      redirect_to source_path(@source.id)
    else
      render :edit
    end
  end

  def destroy
    source = Source.find(params[:id])
    source.destroy
    redirect_to root_path
  end

  def search
    @results = @p.result.order(created_at: 'DESC')
  end

  private
  def source_params
    params.require(:source).permit(:title, :grade_id, :subject_id, :course_id, :content, :image).merge(user_id: current_user.id)
    # 以下、複数枚画像対応用
    # params.require(:source).permit(:title, :grade_id, :subject_id, :course_id, :content, {images: []}).merge(user_id: current_user.id)
  end

  def set_source
    @source = Source.find(params[:id])
  end

  def search_source
    @p = Source.ransack(params[:q])
  end

  def move_to_index
    @source = Source.find(params[:id])
    unless current_user.id == @source.user_id
      redirect_to root_path
    end
  end
end
