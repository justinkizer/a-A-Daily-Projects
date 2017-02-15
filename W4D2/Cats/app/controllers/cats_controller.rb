class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    if @cat
      render :show
    else
      render :index
    end
  end

  def new
    render :new
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
    render :edit
  end

  def create
    @cat = Cat.find_by_id(params[:id])
    if @cat
      redirect_to edit_cat_url(@cat)
    else
      @cat = Cat.create!(cat_params)
      render :show
    end
  end


  def update
    @cat = Cat.find_by_id(params[:id])
    if @cat
      @cat.update!(cat_params)
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
  end

end
