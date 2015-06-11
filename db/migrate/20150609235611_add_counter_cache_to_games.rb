class AddCounterCacheToGames < ActiveRecord::Migration
  def change
    add_column :games, :properties_count, :integer, default: 0
    # reset cached counts for game with properties only
    # ids = Set.new
    # Property.all.each {|c| ids << c.game_id}
    # ids.each do |game_id|
    #   Game.reset_counters(game_id, :properties)
    # end
  end
end
