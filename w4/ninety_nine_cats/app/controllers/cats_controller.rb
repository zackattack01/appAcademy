class CatsController < ApplicationController
  COLORS = %w{ red orange yellow blue indigo violet black white other}
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to(cat_url(@cat))
    else
      redirect_to(new_cat_url)
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to(cat_url(@cat))
    else
      redirect_to(edit_cat_url)
    end
  end


  private
  def cat_params
    params[:cat].permit(:name, :birth_date, :sex, :description, :color)
  end
end
