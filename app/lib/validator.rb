class Validator
	attr_accessor :map
	def initialize
		@map = nil
	end

	#mapping : hash of mapping rules
	def Validator.validate_mapping(mapping)
		hsh = Hash.new
		mapping.each_value { |v|
			if(hsh.has_key?(v))
				raise "mapping fail, multiple second column string"
			else
				hsh[v] = 0
			end
		}
	end

	#validate data file
	def validate_data(header, token_arrs)
		if(@map.nil?)
			raise "validator doesn't have internal mapping"
		end

		check_correspondence(header.keys)	
		applications = Hash.new
		token_arrs.each { |token_arr|
				check_gre_score(header, token_arr)
				check_toefl_score(header, token_arr)
				email = token_arr[header[@key]]
				if(applications.key? email)
					raise "multiple line contains multiple lines for the same application"
				else
					applications[email] = token_arr
				end
		}
	end


	def check_gre_score(header, application)
		@gre_score.each { |type|
			score = application[header[type.to_s]]
			if(!score.nil? && !score.empty?)
				if(score.to_i<0 || score.to_i>800)
					raise "GRE score invalid"
				end
			end
		}
	end
	
	def check_toefl_score(header, application)
		tot_score = 0
		@toefl_score[0..3].each { |type|
			score = application[header[type.to_s]]
			if(!score.nil? && !score.empty?)
				tot_score += score.to_i
			else
				return
			end
		}
		
		toefl_tot_score = application[header[@toefl_score[4].to_s]]
		if(toefl_tot_score.nil? || toefl_tot_score.empty?)
			return
		elsif(tot_score != toefl_tot_score.to_i)
			raise "TOEFL score invalid"
		end
	end


	#check correspondence btwn header and mapping
	def check_correspondence(header)
		err = ""
		if(header.length > @map.length)
			err = "inconsistent between header and mapping1"
		end
		
		idx = 0
		@map.each_key do |key|
			if(idx == header.length-1) 
				break
			elsif(header[idx].eql?(key))
				idx+=1
			end
		end
		if(idx < header.length - 1)
			err = "inconsistent between header and mapping2"
		end
		
		puts header
		puts @map
		puts "IDX="+idx.to_s	
		if(!err.empty?)
			raise err.to_s
		end	
	end
	
	public :validate_data 
	private :check_gre_score, :check_toefl_score, :check_correspondence
end
