class Artist < ActiveRecord::Base

    belongs_to :countries
    has_many :tracks

    def get_most_pop_country
        
    end

end 