class FlatsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @flats = policy_scope(Flat)
    @flats = Flat.geocoded #returns flats with coordinates

    @markers = @flats.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def show
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render 'new'
    end
  end

  def update
    @flat = Flat.find(params[:id])
    respond_to do
      if @flat.update flat_params
      end
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price, :photo)
  end
end
