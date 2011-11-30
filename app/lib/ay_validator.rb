class AYValidator < Validator
	#initialize 
	def initialize
		super
		@gre_score = [:Verbal,:Quantitative,:Analytical]
		@toefl_score = [:"TOEFL IBT Reading", :"TOEFL IBT Speaking", :"TOEFL IBT Writing", :"TOEFL IBT Listening", :"TOEFL IBT Total Score"]
		@key = "Email Address"
	end

end
