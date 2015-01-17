class FavoritesController < ApplicationController
  def create
  	@favorite = current_user.favorites.build(property_id: params[:property_id])

  	if @favorite.save
  		redirect_to :back, notice: "Property was successfully added to favorites."
  	else
  		redirect_to :back, alert: "Something went wrong."
  	end
  end

  def destroy
  	@favorite = Favorite.find(params[:id])

  	@favorite.destroy
  	redirect_to :back, alert: "Removed property from favorites."
  end
end
