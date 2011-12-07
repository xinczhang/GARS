class ApplyYourself < ActiveRecord::Base
	has_one :application

	#get colum titles for institution information
	def institution_info
		["Institution1", "Institution2"]
	end
end
