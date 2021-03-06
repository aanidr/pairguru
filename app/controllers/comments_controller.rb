class CommentsController < ApplicationController
	before_action :authenticate_user!

  def create
		movie = Movie.find(params[:movie_id])
		comment = movie.comments.new(params.require(:comment).permit(:content))
		comment.user_id = current_user.id

		flash[:notice] = 'You can\'t have two comments under one movie, please delete old comment first!' if !comment.save
		redirect_to movie_path(movie)
  end

  def destroy
		movie = Movie.find(params[:movie_id])
		comment = Comment.find(params[:id])
		if comment.user_id == current_user.id
			movie.comments.destroy(comment)
			flash[:notice] = 'Comment has been deleted'
		else
			flash[:error] = 'You are not permitted to do that!'
		end

		redirect_to movie_path(movie)
  end

  def top_commenters
    @commenters = User.joins('INNER JOIN comments ON users.id = comments.user_id').where("comments.created_at > #{7.days.ago.to_date}").limit(10).select('name, COUNT(comments.id) as comments_count').group('users.id').order('comments_count DESC')
  end
end
