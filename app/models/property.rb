class Property < ActiveRecord::Base
  belongs_to :user
  has_many :reservations
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :accommodates, presence: true
  validates :price, presence: true
  validates :user_id, presence: true
  validates :game_list, presence: true

  has_many :property_attachments
  accepts_nested_attributes_for :property_attachments

  has_many :reservations

  has_many :gamings
  has_many :games, through: :gamings

  def game_list
    games.join(", ")
  end

  def game_list=(games_string)
    game_names = games_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_games = game_names.collect { |name| Game.find_or_create_by(name: name) }
    self.games = new_or_found_games
  end
end
