module Admin
  class PostsController < ApplicationController
    before_action :require_authentication, :require_admin
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

    private

    def require_admin
      if !Current.user&.admin?
        redirect_to root_path, alert: "You are not authorized to view this page."
      end
    end

    def post_params
      params.require(:post).permit(:title, :body, :banner_image)
    end
  end
end
