class BandsController < ApplicationController

  before_action :must_be_logged_in

  def index
    render :index
  end

  def new
    render :new
  end

  def create
    @band = Band.new(user_params)
    if @band.save
      render :show
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def update
    Band.find(params[:id]).update(user_params)
    flash.now[:errors] = ["Band updated!"]
    @band = Band.find(params[:id])
    render :show
  end

  def destroy
    Band.find(params[:id]).destroy
    flash.now[:errors] = ["Band destroyed!"]
    render :index
  end

  private

  def user_params
    params.require(:band).permit(:name)
  end

end
