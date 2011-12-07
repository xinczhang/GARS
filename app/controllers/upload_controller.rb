require 'zip/zipfilesystem'
require 'zip/zip'
class UploadController < ApplicationController
  @@directory = "public/data"

  #upload file POST
  def file
	file = params[:datafile]
        type = params[:filetype] #ay or ots
	prog = params[:program]	
	
	begin
		#process the file according to type
	case type
        	when "ay-mapping","ots-mapping"
			upload_mapping(file, type)		
		when "ay","ots"
			upload_data(file, type, prog)
		when "pdf"
			upload_pdf(file, prog)
		when "zip"
			upload_zip(file, prog)
        	else
       	end

	rescue Exception => e
		render :text => "Error: " + e.message
		return
	end
  end


  def upload_data(file, type, prog)
		validator = type=="ay"? AYValidator.new : OTSValidator.new
                validator.map=MAPPER.get_map("#{type}")	
                       
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
						token = token.chomp
						token = token[1..token.length-2]
                                                header[token] = i
						i+=1
                                        }
                                        is_header = !is_header
                                else
					token_arr.each_with_index {|token, idx|
						if token[0].eql?("\"") && token.last.eql?("\"")
							token = token[1..token.length-2]
							token_arr[idx] = token
						end
					}
                                        token_arrs << token_arr
                                end
				end
                        end
			#using the header to check against with th parsed mapping file object
                        validator.validate_data(header, token_arrs)
	
		
		#type specific database opertaion
                key = type == "ay" ? "Email Address" : "key"
		first_name = type == "ay" ? "Applicant First Name" : "Applicant_First_Name"
                last_name  = type == "ay" ? "Applicant Last Name" : "Applicant_Last_Name"
                join  = type == "ay" ? "apply_yourself" : "official_test_score"
                table = type == "ay" ? "apply_yourselves" : "official_test_scores"
                token_arrs.each {|app_tokens|
                        a = Application.find(:first, :readonly=>false,  :joins=>:"#{join}", :conditions=>{:"program"=>prog, :"#{table}"=>{:email_address=>app_tokens[header[key]]}})
                        #construct a new application is now application ever existed for that email address
			if(a.nil?)
                                a = Application.new
				a.program = prog
                                a.apply_yourself = ApplyYourself.new
                                a.official_test_score = OfficialTestScore.new
				a.apply_yourself.email_address=app_tokens[header[key]]
				a.official_test_score.email_address=app_tokens[header[key]]
			else
				app_first_name = a.apply_yourself.first_name.to_s.eql?("") ? a.official_test_score.first_name.to_s : a.apply_yourself.first_name.to_s	
				app_last_name  = a.apply_yourself.last_name.to_s.eql?("")  ? a.official_test_score.last_name.to_s : a.apply_yourself.last_name.to_s
				if(app_first_name != app_tokens[header[first_name]].to_s || app_last_name != app_tokens[header[last_name]].to_s)
					raise "email found, but first name or last name inconsistent"
				end
                        end
               		
		        target = type == "ay" ? a.apply_yourself : a.official_test_score
			if(type == "ay") #standardize the institution names for AY
				target.institution_info.each { |inst_key|
					inst = app_tokens[header[inst_key]]
					inst = MAPPER.get_institution_map[inst]? MAPPER.get_institution_map[inst] : inst
					app_tokens[header[inst_key]] = inst
				}
			end
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
			a.save
			target.save #rails seems dont have cascade save
                }
                render :text=> "Success: application uploaded"
  end

	
  def upload_mapping(file, type)
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
		# construct a validator for the tokenized array for verification
		Validator.validate_mapping(hsh)
		path = File.join(@@directory+"/config", "#{type[0..idx-1]}-map.txt")
                File.open(path, "w+"){|f| f.write(file_data)}
                MAPPER.update(:"#{type[0..idx-1]}"=>path)
		render :text => "Success: mapping file is updated"
  end


  def upload_pdf(pdf, prog)
	logger.debug "in uploading pdf file"
	fname = pdf.original_filename
	fname_wo_ext = fname.chomp(File.extname(fname))
	a = Application.find(:first, :readonly=>false, :joins=>[:apply_yourself], :conditions=>"email_address=\'#{fname_wo_ext}\'")
	if ! a.nil?
		path = File.join(@@directory, "pdf/#{prog}", fname)
		File.open(path, "wb+"){|f| f.write(pdf.read)}
		a.pdf_submitted = 1
		a.save
		render :text => "Success: pdf uploaded"
	else
		raise "cannot find corresponding application regarding with uploaded pdf"
	end
  end

  def upload_zip(zip, prog)
	logger.debug "in uploading zip file"
	success = true
	zip_file = Zip::ZipFile.open(zip.path)
	Zip::ZipFile.foreach(zip.path){ |fname|
		fname_wo_ext = fname.to_s.chomp(File.extname(fname.to_s))
		a = Application.find(:first, :readonly=>false, :joins=>[:apply_yourself], :conditions=>"email_address=\'#{fname_wo_ext}\'")
		if ! a.nil?
			path = File.join(@@directory, "pdf/#{prog}", fname.to_s)
			zip_file.extract(fname.to_s, path){true}
			a.pdf_submitted = 1
			a.save
		else
			success = false
		end
	}	
	if success
		render :text => "Success: zip uploaded"	
	else
		raise "cannot find corresponding application for some pdfs in zip, others are uploaded"
	end
  end
end
