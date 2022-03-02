class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]
  def create
    @post = Post.find(params[:post_id])
    UserMailer.with(user_from: current_user, user_to: @post.user, post: @post).like_post.deliver_later if current_user.like(@post)
  end

  def destroy
    @post = Like.find(params[:id]).post
    current_user.unlike(@post)
  end
end
