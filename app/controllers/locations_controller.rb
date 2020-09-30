class LocationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_location, except: %i[create]

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = 'Category was successfully created'
      redirect_to user_path(@location.user)
    else
      render :new
    end
  end

  def update
    if  @location.update(location_params)
      flash[:success] = 'Trainer was successfully updated'
      redirect_to user_path(@location.user)
    else
      render :edit
    end
  end

  private

  def set_location
    @location ||= Location.find_by(params[:location_id])
  end

  def location_params
    params.require(:location).permit(:country, :city, :area, :street, :latitude, :longitude, :user_id)
  end
end
