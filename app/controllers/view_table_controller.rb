class ViewTableController < ApplicationController
skip_before_filter :authorize, :only => [:index, :login]
 #front page, view all applications or assigned to user
  #front page, view all applications or assigned to user
  def view
	#dummy the paginate here
        @page = (params[:page] || 1)
        @prev_page = 1
        @next_page = 3
	
    if @is_admin
          # for unknown reason, Application.all doesn't work
          # the view.html.erb iterates over applications and
          # for each application, it tries to access ay object by using application.apply_yourself
          # this line code doesn't work.
      @applications = select_application
        else
      @applications = Application.joins(:users).where("users.id=?",@user.id)
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
	redirect_to "/home/view"
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
	conditions = ""
	#construct conditions sql segment by what in the filter form
	if (!session[:filterQuery].nil?) 
		for i in 0..session[:filterQuery][:types].length - 1
			column = MAPPER.get_attr(session[:filterQuery][:types][i], session[:filterQuery][:name][i])
			# we didn't deal with those column being ignored
			if (column[:name] != "ignore")
				table = "ay" == session[:filterQuery][:types][i] ? "apply_yourselves" : "official_test_scores"
				add = (conditions == "") ? "" : " AND " 
				conditions << add + table + "." + column[:name]
				#treat string and numerical column differently, add wild card to string propery
				if (column[:type].to_s == "string")
					conditions += " LIKE '%#{session[:filterQuery][:value][i] }%'";
				else
					if (session[:filterQuery][:op][i] == "-1")
						conditions += " < #{session[:filterQuery][:value][i] }";	
					elsif(session[:filterQuery][:op][i] == "1")
						conditions += " > #{session[:filterQuery][:value][i] }";
					else
						conditions += " = #{session[:filterQuery][:value][i] }";
					end
				end
			end
		end
	end	
	#construct the order segment by what in the filter form
	orders = ""
	if (!session[:order].nil?) 
                for i in 0..session[:order][:types].length - 1
                        name = MAPPER.get_attr(session[:order][:types][i], session[:order][:name][i])[:name];
                       	if (name != "ignore")
				# the logic is simpler here, just concat field name and ascending/descending info
				table = "ay" == session[:order][:types][i] ? "apply_yourselves" : "official_test_scores"
                        	add = (orders == "") ? "" : ", "
				orders += add + table + "." + name
                                if (session[:order][:op][i] == "-1")
                                        orders += " DESC";   
                                else
                                        orders += " ASC";
                                end
                        end
                end
        end
	#construct the query and fetch applications depending on if we really have orders or conditions
	if (conditions == "") && (orders == "")
		return Application.find(:all, :joins => [:apply_yourself, :official_test_score])
	elsif (conditions != "") && (orders == "")
		return Application.find(:all, :joins => [:apply_yourself, :official_test_score], :conditions => conditions)
	elsif (orders != "") && (conditions == "")
		return Application.find(:all, :joins => [:apply_yourself, :official_test_score], :order => orders)
	else
		return Application.find(:all, :joins => [:apply_yourself, :official_test_score], :conditions => conditions, :order => orders)
	end     

  end

  def filter
	if (session[:filterQuery] == nil)
		session[:filterQuery] = {:types => nil, :name=> nil, :op => nil, :value=>nil}
	end
	session[:filterQuery][:types] = params[:"select-type"].split ","
	session[:filterQuery][:name] = params[:"select-name"].split ","
	session[:filterQuery][:value] = params[:"select-value"].split ","
	session[:filterQuery][:op] = params[:"select-op"].split ","
	redirect_to view_table_view_path
  end

  def sort
	if (session[:order] == nil)
		session[:order] = {:types => nil, :name=> nil, :op => nil}
	end
	session[:order][:types] = params[:"sort-type"].split ","
	session[:order][:name] = params[:"sort-name"].split ","
	session[:order][:op] = params[:"sort-order"].split ","
	redirect_to view_table_view_path
  end
end
