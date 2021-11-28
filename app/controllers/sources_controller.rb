class SourcesController < ApplicationController
  before_action :set_source, only: [:show, :edit, :update]

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
    
  end

  private
  def source_params
    params.require(:source).permit(:title, :grade_id, :subject_id, :course_id, :content).merge(user_id: current_user.id)
  end

  def set_source
    @source = Source.find(params[:id])
  end
end
