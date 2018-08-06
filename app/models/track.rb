class Track < ActiveRecord::Base

    belongs_to :artists
    has_many :countries, through: :artists
end 