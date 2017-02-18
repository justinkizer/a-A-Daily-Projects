class PostsController < ApplicationController

  before_action :must_be_logged_in, only: [:new, :edit, :update]
  before_action :must_be_post_author, only: [:edit, :update]

  def new
    render :new
  end

  def create
    @post = current_user.posts.new(user_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(user_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def must_be_post_author
    @post = Post.find(params[:id])
    unless current_user.id == @post.author_id
      flash.now[:errors] = ["Only authors can edit their Posts!"]
      render :show
    end
  end

  def user_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end
