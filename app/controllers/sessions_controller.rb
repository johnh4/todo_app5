class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		if params[:remember_me]
  			cookies.permanent[:auth_token] = user.auth_token
  		else
  			cookies[:auth_token] = user.auth_token
  		end
  		redirect_to tasks_path, notice: "Login Successful."
  	else
  		flash.now[:error] = "Login failed."
  		render 'new'
  	end 
  end

  def destroy
  	cookies.delete(:auth_token)
  	redirect_to tasks_path
  end
end
