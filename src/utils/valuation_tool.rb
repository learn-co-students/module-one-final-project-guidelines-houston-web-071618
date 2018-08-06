class Valuator
  def self.add_cost_data(artist_hash)
    artist_hash[:cost] = 0.105 * artist_hash[:listeners].to_f + 1414
  end
end
