class SessionsController < ApplicationController
  layout "landing"

  def new
  	if logged_in?
  		redirect_to videos_path
  	end

  end

  def create
	user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to videos_path
    else
      # show invalid password
      flash.now[:danger] = "invalid user/pass"
      render 'new'
    end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end

end
