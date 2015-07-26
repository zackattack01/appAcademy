class SubsController < ApplicationController
  before_action :get_sub, only: [:show, :edit]
  before_action :redirect_unless_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all # TODO includes posts
    render json: {subs: @subs}
  end

  def show
    render json: @sub
  end

  def new
    @sub = Sub.new
    render text: "subs#new"
  end

  def create
    @sub = Sub.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def get_sub
    @sub = Sub.find(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def redirect_unless_moderator
    get_sub # TODO see if this is unneeded
    unless current_user.is_moderator?(@sub)
      # TODO flash moderator message
      redirect_to sub_url(@sub)
    end
  end
end
