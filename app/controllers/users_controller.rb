class UsersController < ApplicationController
  def new
  end
  
  def show
    @videos = @user.microposts.paginate(page: params[:page])
  end
end
