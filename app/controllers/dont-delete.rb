=begin
	#construct the query and fetch applications depending on if we really have orders or conditions
	if (conditions == "") && (orders == "")
		return Application.find(:all, :joins => joins).paginate(:page => params[:page], :per_page => 30)
	elsif (conditions != "") && (orders == "")
		return Application.find(:all, :joins => joins, :conditions => conditions).paginate(:page => params[:page], :per_page => 30)
	elsif (orders != "") && (conditions == "")
		return Application.find(:all, :joins => joins, :order => orders).paginate(:page => params[:page], :per_page => 30)
	else
		return Application.find(:all, :joins => joins, :conditions => conditions, :order => orders).paginate(:page => params[:page], :per_page => 30)
	end     
=end
