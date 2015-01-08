module GamesHelper

	def edit_game(game_list)
		currentGame = []
		game_list.each do |game|
			currentGame += ["#{game.name}"]
		end
		currentGame.uniq.join(', ')
	end

end
