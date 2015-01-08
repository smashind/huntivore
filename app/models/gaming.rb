class Gaming < ActiveRecord::Base
  belongs_to :game
  belongs_to :property
end
