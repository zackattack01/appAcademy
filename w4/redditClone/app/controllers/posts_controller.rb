class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit]
  before_action :redirect_unless_logged_in, only: [:edit, :update]
  before_action :redirect_unless_moderator, only: [:edit, :update]

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    render json: @post
  end

  def edit
    @subs = Sub.all
    @our_subs = @post.subs
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids)
  end

  def redirect_unless_moderator

    get_post # TODO see if this is unneeded
    unless current_user.is_author?(@post)
      # TODO flash moderator message
      redirect_to post_url(@post)
    end
  end
end
