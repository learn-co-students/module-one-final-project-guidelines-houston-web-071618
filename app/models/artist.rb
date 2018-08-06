class Artist < ActiveRecord::Base

    belongs_to :countries
    has_many :tracks

end 