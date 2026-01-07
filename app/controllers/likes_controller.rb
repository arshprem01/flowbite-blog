class LikesController < ApplicationController
  before_action :require_authentication
  before_action :set_post

  def create
    @like = @post.likes.create(user: Current.user)
    redirect_to @post, notice: "You liked this post."
  end

  def destroy
    @like = @post.likes.find(params[:id])
    if @like.user == Current.user
        @like.destroy
        redirect_to @post, notice: "You unliked this post."
    else
        redirect_to @post, alert: "You cannot perform this action."
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end
end
