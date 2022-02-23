class UsersController < ApplicationController
  before_action :set_user

  def show
    @sources = @user.sources.order(updated_at: 'DESC')
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
end
