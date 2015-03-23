class Property < ActiveRecord::Base
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :favorites
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :accommodates, presence: true
  validates :price, presence: true
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

  # def self.searchy(search)
  #   search_condition = "%" + search + "%"
  #   where(
  #     '(title LIKE ? OR description LIKE ? OR location LIKE ?) OR JOINS (games) WHERE (games.name LIKE ?)', search_condition, search_condition, search_condition, search_condition
  #   )
  # end 

  def self.search(search)
    if Rails.env.production?
      search_condition = "%" + search + "%"
      if where('title ILIKE ? OR description ILIKE ? OR location ILIKE ?', search_condition, search_condition, search_condition).any?
        where('title ILIKE ? OR description ILIKE ? OR location ILIKE ?', search_condition, search_condition, search_condition)
      else
        joins(:games).where('games.name ILIKE ?', search_condition)
      end
    else
      search_condition = "%" + search + "%"
      if where('title LIKE ? OR description LIKE ? OR location LIKE ?', search_condition, search_condition, search_condition).any?
        where('title LIKE ? OR description LIKE ? OR location LIKE ?', search_condition, search_condition, search_condition)
      else
        joins(:games).where('games.name LIKE ?', search_condition)
      end 
    end
  end
end
