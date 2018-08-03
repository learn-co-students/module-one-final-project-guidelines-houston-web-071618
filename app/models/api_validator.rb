class APIValidator

	def self.check_response(parsed_data)
		parsed_data.key?("error")
	end 
end 