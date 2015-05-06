class Property < ActiveRecord::Base
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :favorites
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :accommodates, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 10 }
  validates :user_id, presence: true
  validates :game_list, presence: true
  validates :phone, presence: true

  has_many :property_attachments, dependent: :destroy
  accepts_nested_attributes_for :property_attachments

  has_many :gamings, dependent: :destroy
  has_many :games, through: :gamings

  def game_list
    games.join(", ")
  end

  def game_list=(games_string)
    game_names = games_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_games = game_names.collect { |name| Game.find_or_create_by(name: name) }
    self.games = new_or_found_games
  end

  def self.search(search)
    search_condition = "%" + search + "%"
    where('title ILIKE ? OR description ILIKE ? OR location ILIKE ?', search_condition, search_condition, search_condition)
    .union(joins(:games).where('games.name ILIKE ?', search_condition))
  end

  def to_param
    [id, title.parameterize].join("-")
  end
end
