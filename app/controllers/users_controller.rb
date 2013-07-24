class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	user = User.new(user_params)
  	if user.save
  		cookies.permanent[:auth_token] = user.auth_token
  		redirect_to tasks_path, notice: "Sign up successful."
  	else
  		flash.now[:error] = "Sign up failed."
  		render 'new'
  	end
  end


  private

  	def user_params
  		params.require(:user).permit(:email, :password, :password_confirmation)
  	end
end
