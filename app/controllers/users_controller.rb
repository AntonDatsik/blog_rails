class UsersController < ApplicationController
	before_action :signed_in_user, 	only: [:edit, :update, :index, :destroy]
	before_action :correct_user, 	only: [:edit, :update]
	before_action :admin_user, only: [:destroy]
	
	def index
		 @users = User.paginate(page: params[:page], per_page: 20)
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.paginate(page: params[:page], per_page: 20)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the DAA BLOG!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated succesfully"
			redirect_to @user
		else
			flash.now[:success] = "Name/password invalid"
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:success] = "User deleted."
		redirect_to users_path
	end

	private
	def user_params
		params.require(:user).permit(:name, :password, :password_confirmation, :avatar)
	end

	def correct_user
		@user = User.find(params[:id])
		if !current_user?(@user)
			flash[:error] = "Access is block"
			redirect_to root_url
		end
	end

	def admin_user
		if !current_user.admin?
			redirect_to root_url
		end
	end
end
