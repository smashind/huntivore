class FavoritesController < ApplicationController
  def create
  	@favorite = current_user.favorites.build(property_id: params[:property_id])

  	if @favorite.save
  		redirect_back fallback_location: :root, notice: "Property was successfully added to favorites."
  	else
  		redirect_back fallback_location: :root, alert: "Something went wrong."
  	end
  end

  def destroy
  	@favorite = Favorite.find(params[:id])

  	@favorite.destroy
  	redirect_back fallback_location: :root, alert: "Removed property from favorites."
  end
end
