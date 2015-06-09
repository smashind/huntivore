class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
  	@games = Game.alphabetically.includes(:properties)
  end

  def show
  	@game = Game.find(params[:id])
    redirect_to_good_slug(@game) and return if bad_slug?(@game)
    @games = @game.properties.paginate(page: params[:page], per_page: 10)
  end

  def destroy
  	@game = Game.find(params[:id])
  	@game.destroy
  	redirect_to games_url
  end
end
