class CommentsController < ApplicationController
  def create
		@comment = Comment.create(params.require(:comment).permit(:user_id, :movie_id, :content))
		redirect_to "/movies/#{params[:movie_id]}"
  end

  def destroy
		Comment.find(params[:id]).destroy
		redirect_to "/movies/#{params[:movie_id]}"
  end
end
