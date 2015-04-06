class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
  	@games = Game.alphabetically
  end

  def show
  	@game = Game.find(params[:id])
    @games = @game.properties.paginate(page: params[:page], per_page: 10)
  end

  def destroy
  	@game = Game.find(params[:id])
  	@game.destroy
  	redirect_to games_url
  end
end
