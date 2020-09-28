class SessionsController < ApplicationController

	before_action :logged_in_redirect, only: [:new, :create]
    def new
		end
		
		def create
			user = User.find_by(username: session_params[:username])

			if user && user.authenticate(session_params[:password])
				session[:user_id] = user.id
				flash[:success] = "You have successfully logged in!"
				redirect_to root_path
			else
				flash.now[:error] = "Something wrong with your login information"
				render 'new'
			end
		end

		def destroy
			session[:user_id] = nil
			flash[:success] = "You have successfully logged out!"
			redirect_to login_path

		end

		private 
		def session_params
			params.require(:session).permit(:username, :password)
		end

		def logged_in_redirect
			if logged_in?
				flash[:error] = 'you are already logged in'
				redirect_to root_path
			end
		end
end