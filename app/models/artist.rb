class Artist < ActiveRecord::Base
  has_many :songs
  has_many :categories, through: :songs
end
