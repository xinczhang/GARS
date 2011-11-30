class OfficialTestScore < ActiveRecord::Base
	has_one :application
	
	def gre_info
		["Off_GRE_V", "Off_GRE_VP", "Off_GRE_Q", "Off_GRE_QP", "Off_GRE_A", "Off_GRE_AP", "Off_GRE_Subj", "Off_GRE_SubjP", "Off_GRE_SubjName"]
	end

	def toefl_info
		["Off_TOEFL_Total", "Off_TOEFL_Lis", "Off_TOEFL_Rd", "Off_TOEFL_Spk", "Off_TOEFL_Wri"]
	end
end
