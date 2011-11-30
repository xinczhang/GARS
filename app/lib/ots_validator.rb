class OTSValidator < Validator
	def initialize
		super
		@gre_score = [:Off_GRE_V,:Off_GRE_Q,:Off_GRE_A]
		@toefl_score = [:"Off_TOEFL_Lis", :"Off_TOEFL_Rd", :"Off_TOEFL_Spk", :"Off_TOEFL_Wri", :"Off_TOEFL_Total"]
		@key = "key"
	end
end
