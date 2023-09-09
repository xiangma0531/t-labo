class CourseController < ApplicationController
  
  def user_course
    @courses = Course.where(subject_id: params[:subject_id].to_i)
  end

  def source_course
    @courses = Course.where(subject_id: params[:subject_id].to_i)
  end

end
