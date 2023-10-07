class CourseController < ApplicationController
  before_action :set_courses
  
  def user_course
  end

  def source_course
  end

  def search_course
    @q_courses = Course.where(subject_id: [params[:subject_id].to_i, 0])
  end

  private
  def set_courses
    @courses = Course.where(subject_id: [params[:subject_id].to_i, 0])
  end

end
