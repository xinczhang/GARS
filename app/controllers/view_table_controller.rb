class ViewTableController < ApplicationController
skip_before_filter :authorize, :only => [:index, :login]

 #front page, view all applications or assigned to user
  #front page, view all applications or assigned to user
  def view
	#dummy the paginate here
        auto_assign = params[:auto_assign] || 1  
        if auto_assign.to_i() == 1
                @applications = select_application
                @reviewers = User.paginate :page => params[:review_page], :per_page => 5
                @manual_assign_btn_visible = false
                @auto_assign_btn_visible = true
		@paging_params = {:auto_assign => 1}
        else
                @applications = select_application
                @reviewers = User.paginate :page => params[:review_page], :per_page => 5
                @manual_assign_btn_visible = true
                @auto_assign_btn_visible = false
		@paging_params = {:auto_assign => 0}
        end
  end

  def add_remove_fields
	#store things in the session and regenerate the view according to session variables
	@ay = params[:add_remove_ay]
	@ots = params[:add_remove_ots]
	#@gars = params[:add_remove_ots]
	session[:ay_display] =  @ay.split ","
	session[:ots_display] = @ots.split ","
	logger.debug @ots + @ay
	redirect_to "/view_table/view"
  end

  #proof of concept search, get the name and try to find a match in database
  def search
	logger.debug session[:current_user]
	 if session[:current_user] == nil
		logger.debug "User not login"
                redirect_to :action => "index"
        else
		logger.debug "Enter Proof of concept search"
        	@user = session[:current_user]
		@name = params[:searchQuery];
		#A selector of application by name using query interface
        	@applications = Application.joins(:apply_yourself).where('apply_yourselves.first_name LIKE ? OR apply_yourselves.last_name LIKE ? OR apply_yourselves.middle_name LIKE ?', "%#{@name}%", "%#{@name}%", "%#{@name}%")
  		render :action => "view"
	end
  end

 # select application in database according current conditions saved in session
  def select_application
	crta = {:filterQuery => nil, :orderQuery => nil}	
	if !params[:"select-type"].nil?
		crta[:filterQuery] = {:types => nil, :name=> nil, :op => nil, :value=>nil}	
		crta[:filterQuery][:types] = params[:"select-type"].split ","
		crta[:filterQuery][:name] = params[:"select-name"].split ","
		crta[:filterQuery][:value] = params[:"select-value"].split ","
		crta[:filterQuery][:op] = params[:"select-op"].split ","
	end
	if !params[:"sort-type"].nil?
		crta[:order] = {:types => nil, :name=> nil, :op => nil}		
		crta[:order][:types] = params[:"sort-type"].split ","
		crta[:order][:name] = params[:"sort-name"].split ","
		crta[:order][:op] = params[:"sort-order"].split ","
	end	
	joins = @is_admin ? [:apply_yourself, :official_test_score] : [:apply_yourself, :official_test_score, :users]
	conditions = @is_admin ? "" : "users.id = #{session[:current_user]}"
	#construct conditions sql segment by what in the filter form
	if (!crta[:filterQuery].nil?) 
		for i in 0..crta[:filterQuery][:types].length - 1
			column = MAPPER.get_attr(crta[:filterQuery][:types][i], crta[:filterQuery][:name][i])
			# we didn't deal with those column being ignored
			if (column[:name] != "ignore")
				table = "ay" == crta[:filterQuery][:types][i] ? "apply_yourselves" : "official_test_scores"
				add = (conditions == "") ? "" : " AND " 
				conditions << add + table + "." + column[:name]
				#treat string and numerical column differently, add wild card to string propery
				if (column[:type].to_s == "string")
					conditions += " LIKE '%#{crta[:filterQuery][:value][i] }%'";
				else
					if (crta[:filterQuery][:op][i] == "-1")
						conditions += " < #{crta[:filterQuery][:value][i] }";	
					elsif(crta[:filterQuery][:op][i] == "1")
						conditions += " > #{crta[:filterQuery][:value][i] }";
					else
						conditions += " = #{crta[:filterQuery][:value][i] }";
					end
				end
			end
		end
	end	
	#construct the order segment by what in the filter form
	orders = ""
	if (!crta[:order].nil?) 
                for i in 0..crta[:order][:types].length - 1
                        name = MAPPER.get_attr(crta[:order][:types][i], crta[:order][:name][i])[:name];
                       	if (name != "ignore")
				# the logic is simpler here, just concat field name and ascending/descending info
				table = "ay" == crta[:order][:types][i] ? "apply_yourselves" : "official_test_scores"
                        	add = (orders == "") ? "" : ", "
				orders += add + table + "." + name
                                if (crta[:order][:op][i] == "-1")
                                        orders += " DESC";   
                                else
                                        orders += " ASC";
                                end
                        end
                end
        end
	#construct the query and fetch applications depending on if we really have orders or conditions
	if (conditions == "") && (orders == "")
		return Application.paginate :joins => joins, :page => params[:page], :per_page => 30
	elsif (conditions != "") && (orders == "")
		return Application.paginate :joins => joins, :conditions => conditions, :page => params[:page], :per_page => 30
	elsif (orders != "") && (conditions == "")
		return Application.paginate :joins => joins, :order => orders, :page => params[:page], :per_page => 30
	else
		return Application.paginate :joins => joins, :conditions => conditions, :order => orders, :page => params[:page], :per_page => 30
	end     



  end
end
