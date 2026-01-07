class CommentsController < ApplicationController
  before_action :require_authentication
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to @post, notice: "Comment added!"
    else
      redirect_to @post, alert: "Comment failed to save."
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == Current.user
        @comment.destroy
        redirect_to @post, notice: "Comment deleted."
    else
        redirect_to @post, alert: "You are not authorized to delete this comment."
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
