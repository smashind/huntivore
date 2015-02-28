class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :accepted_terms, presence: true

  has_many :properties, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :hostings, through: :properties, source: :reservations
  has_many :favorites, dependent: :destroy
  has_many :favorited, through: :properties, source: :favorites

  def full_name
  	first_name + " " + last_name
  end
end
