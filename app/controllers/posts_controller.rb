class PostsController < ApplicationController
	before_action :signed_in_user

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created"
			redirect_to current_user
		else
			redirect_to root_url
		end
	end

	def new
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
		@user = User.find(@post.user_id)
		@comment = Comment.new
		@comments = @post.comments.paginate(page: params[:page], per_page: 10)
	end

	def destroy
	end
	
	def post_params
		params.require(:post).permit(:title, :body, :picture)
	end
end
