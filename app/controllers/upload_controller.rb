class UploadController < ApplicationController
  #upload file POST
  def file
	file = params[:datafile]
        type = params[:filetype] #ay or ots
        directory = "public/data"
	#process the file according to type
	case type
        when "ay-mapping","ots-mapping"
		idx = type.index '-'
		file_data = file.read
		hsh = {}
		file_data.each_line { |ln|
			if(!ln.nil? && !ln.index("->").nil?)
				lft,rgh = ln.split("->")[0], ln.split("->")[1].chomp
				#special treat to other info
				if(!rgh.eql?("otherInfo") && !rgh.eql?("ignore"))
					hsh[lft] = rgh
				end
			end
		}
		begin
			# construct a validator for the tokenized array for verification
			Validator.validate_mapping(hsh)
			path = File.join(directory+"/config", "#{type[0..idx-1]}-map.txt")
                	File.open(path, "w+"){|f| f.write(file_data)}
                	MAPPER.update(:"#{type[0..idx-1]}"=>path)
                rescue Exception => e
			logger.error "mapping file is wrong"
			flash[:upload_status] = false
                        render :text => e.message
			return
                end
		render :text => "mapping file is updated"
	when "ay","ots"
		validator = type=="ay"? AYValidator.new : OTSValidator.new
                validator.map=MAPPER.get_map("#{type}")		
                begin
                        #parse uploaded data ----------------
                        data = file.read
                        header = Hash.new
                        token_arrs = []
                        is_header = true
			
			data.each_line do |line|
				if(!line.nil? && !line.empty? && line!='')
                                token_arr = line.split("\t")
				#tokenize the header line of a data file
                                if(is_header)
                                        i = 0
                                        token_arr.each {|token|
                                                header[token.chomp] = i
						i+=1
                                        }
                                        is_header = !is_header
                                else
                                        token_arrs << token_arr
                                end
				end
                        end
			#using the header to check against with th parsed mapping file object
			logger.debug "validator validate_data begin"
                        validator.validate_data(header, token_arrs)
			logger.debug "validator validate end"
                rescue Exception => e
			logger.debug "error #{e}"
			flash[:upload_status] = false
                        render :text => e.message
			return
                end
		
		#type specific database opertaion
                key = type == "ay" ? "Email Address" : "key"
		first_name = type == "ay" ? "Applicant First Name" : "Applicant_First_Name"
                last_name  = type == "ay" ? "Applicant Last Name" : "Applicant_Last_Name"
                join  = type == "ay" ? "apply_yourself" : "official_test_score"
                table = type == "ay" ? "apply_yourselves" : "official_test_scores"
		begin
                token_arrs.each {|app_tokens|
                        a = Application.find(:first, :joins=>:"#{join}", :conditions=>{:"#{table}"=>{:email_address=>app_tokens[header[key]]}})
                        #construct a new application is now application ever existed for that email address
			if(a.nil?)
                                a = Application.new
                                a.apply_yourself = ApplyYourself.new
                                a.official_test_score = OfficialTestScore.new
				a.apply_yourself.email_address=app_tokens[header[key]]
				a.official_test_score.email_address=app_tokens[header[key]]
			else
				if(a.first_name != app_tokens[header[first_name]] || a.last_name != app_tokens[header[last_name]])
					raise "email found, but first name or last name inconsistent"
                                end				
                        end
                        target = type == "ay" ? a.apply_yourself : a.official_test_score
			#reflective here, invoke the method by method name, and send the value to appropriate setter
                        MAPPER.get_map(type).each_pair {|k,v|
				if(!v.eql?("ignore") && !v.eql?("otherInfo") && !app_tokens[header[k]].nil?)
                                	target.send(:"#{v}=", app_tokens[header[k]])
				end
                        }
			#now handle otherInfo
			other_info = []
			MAPPER.get_otherinfo(type).each {|v|
				other_info <<  v + "=" +app_tokens[header[v]]
			}
			target.otherInfo=other_info.join(";")
                        #insert or update?
			if(!a.readonly?)
                                a.save
                        else
                                target.save
                        end
                }
                rescue Exception => e
			#parsing error will temperorily be put here
			flash[:upload_status] = false
                       render :text => e.message
		       return
                end
                render :text=> "application uploaded"
	#save the pdf, currently not check against the key, will do soon FIX
	when "pdf"
                logger.debug "enter save pdf here"
		path = File.join(directory, "pdf", file.original_filename)
                logger.debug "pdf will be saved in" + path
		puts path
		File.open(path, "wb+"){|f| f.write(file.read)}
                render :text => "pdf saved"
        else
        end

  end
end
