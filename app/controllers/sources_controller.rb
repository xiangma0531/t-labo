class SourcesController < ApplicationController
  before_action :set_source, only: [:show, :edit, :update]
  before_action :search_source, only: [:index, :search]

  def index
    @sources = Source.all
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
  end

  def edit
  end

  def update
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
    @results = @p.result
  end

  private
  def source_params
    params.require(:source).permit(:title, :grade_id, :subject_id, :course_id, :content).merge(user_id: current_user.id)
  end

  def set_source
    @source = Source.find(params[:id])
  end

  def search_source
    @p = Source.ransack(params[:q])
  end
end
