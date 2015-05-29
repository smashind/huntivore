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
  has_many :sent_messages
  has_many :messages, class_name: "SentMessage", foreign_key: "recipient_id"

  has_many :message_replies
  has_many :replied_messages, class_name: "MessageReply", foreign_key: "recipient_id"

  has_many :outfitters

  after_create :send_welcome_email

  def full_name
  	first_name + " " + last_name
  end

  def to_param
    [id, full_name.parameterize].join("-")
  end

  def send_welcome_email
    if self.owner
      UserMailer.welcome_email_owner(self).deliver
      UserMailer.new_owner(self).deliver
    else
      UserMailer.welcome_email(self).deliver
    end
  end
end
