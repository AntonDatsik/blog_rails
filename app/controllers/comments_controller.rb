class CommentsController < ApplicationController
	
	def new
		@comment = Comment.new
	end

	def create
		@comment = current_user.comments.create(comment_params)
		@post = Post.find(comment_params[:post_id])
		@user = current_user
		respond_to do |format|
			format.html { redirect_to @post }
			format.js 	{ }
		end
	end

	def destroy
		@comment = current_user.comments.find_by_id(params[:id])
		@comments_count = Post.find(@comment.post_id).comments.count
		@post = Post.find(@comment.post_id)
		@comment.destroy
		respond_to do |format|
      		format.html { redirect_to @post }
      		format.json { head :no_content }
      		format.js   { render :layout => false }
    	end
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :post_id)
	end
end
