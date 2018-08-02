class CommentsController < ApplicationController
  def create
		@comment = Comment.new(params.require(:comment).permit(:user_id, :movie_id, :content))
		flash[:notice] = 'You can\'t have two comments under one movie, please delete old comment first!' if !@comment.save
		redirect_to "/movies/#{params[:movie_id]}"
  end

  def destroy
		Comment.find(params[:id]).destroy
		redirect_to "/movies/#{params[:movie_id]}"
  end
end
