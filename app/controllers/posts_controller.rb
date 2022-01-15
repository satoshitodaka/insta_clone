class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    user = current_user
    @post = user.posts.new
  end

  def create
    user = User.find(current_user.id)
    @post = user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      render :new
      flash.now[:danger] = '投稿に失敗しました。'
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to posts_path, success: '投稿を更新しました。'
    else
      render :edit
      flash.now[:danger] = '更新に失敗しました。'
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: '削除しました。'
  end

  private

    def post_params
      params.require(:post).permit(:title, :comment, {images: []})
    end

end
