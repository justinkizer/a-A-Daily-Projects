class AlbumsController < ApplicationController

  before_action :must_be_logged_in

  def new
    render :new
  end

  def create
    @album = Album.new(user_params)
    if @album.save
      render :show
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def update
    Album.find(params[:id]).update(user_params)
    flash.now[:errors] = ["Album updated!"]
    @album = Album.find(params[:id])
    render :show
  end

  def destroy
    Album.find(params[:id]).destroy
    flash.now[:errors] = ["Album destroyed!"]
    render :new
  end

  private

  def user_params
    params.require(:album).permit(:name, :band_id, :live_recording)
  end

end
