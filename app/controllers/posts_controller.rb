class PostsController < ApplicationController
  before_action :require_authentication, only: %i[ new create destroy ]

  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = @posts.search(params[:query]) if params[:query].present?
    @posts = @posts.page(params[:page]).per(6)
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = Current.user

    if @post.save
      redirect_to @post, notice: "Post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    if @post.user == Current.user
      @post.destroy
      redirect_to posts_path, notice: "Post deleted successfully."
    else
      redirect_to @post, alert: "You are not authorized to delete this post."
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :banner_image)
  end
end
