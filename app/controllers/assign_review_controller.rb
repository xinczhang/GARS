class AssignReviewController < ApplicationController

skip_before_filter :authorize, :only => [:index, :login]
	
	@@MAX=1000000000

def select_application
	Application.find(:all, :conditions => "assigned = 0 AND status = 0")
end
def assign_reviewers
	@applications = select_application
	@applications.each do |app|	
		params[:name].each do |name|
			u = User.find(:all, :conditions => "name LIKE '#{name}'")[0]
			r = Review.new
			r.timestamp = Time.now 
			r.rating = 0
			r.save
			ar = ApplicationReview.new
			ar.application_id = app.id
			ar.review_id = r.id
			ar.user_id = u.id
			ar.save
		end
	end
	redirect_to '/view_table/view'
  end

  def auto_assign
	unassigned = Application.count(:all, :conditions => "assigned = 0")
	all = Application.count(:all)
	if ((unassigned == 0) || (unassigned == all))
	if (unassigned == 0)
		Application.update_all(["assigned = ?", "0"],[])
		u = User.find(:all, :conditions => "name LIKE '#{name}'")[0]
			r = Review.new
			r.timestamp = Time.now 
			r.rating = 0
			r.save
			ar = ApplicationReview.new
			ar.application_id = app.id
			ar.review_id = r.id
			ar.user_id = u.id
			ar.save
	end
    	criteria = 'research_area' #params[:criteria]
	@applications = Application.find(:all, :joins => [:apply_yourself], :conditions => "assigned = 0 AND status = 0 AND apply_yourselves.email_address IS NOT NULL", :readonly => false)	
	@users = User.all
	sum = User.sum(:workload)
	@application_reviews = ApplicationReview.find(:all)
	v = @applications.length + @users.length + 2

	cost = Array.new(v, 0) {Array.new(v, 0)}
	capacity = Array.new(v, 0) {Array.new(v, 0)}
	#initialize the edges from source to application
	for i in 1..@applications.length
		cost[0][i] = cost[i][0] = 0
		capacity[0][i],capacity[i][0] = 1,0
	end
	#initialzie the edges from professor to target according to the work load
	for i in (@applications.length + 1)..(@applications.length + @users.length)
		cost[i][v-1] = cost[v-1][i] = 0
		capacity[i][v-1],capacity[v-1][i] = (@users[i - @applications.length - 1].workload * @applications.length / sum).to_i + 1,0
	end
	#initialize the matching edges
	for i in 1..@applications.length
		for j in (@applications.length + 1)..(@applications.length + @users.length)
		a = @applications[i - 1]
		u = @users[j - @applications.length - 1]
		assigned_before = false
		@application_reviews.each do |ar|
			if ((ar.user_id = u.id) && (ar.application_id = a.id))
				assigned_before = true
				break
			end
		end
		if !assigned_before
		capacity[i][j], capacity[j][i] = 1,0
		ra_match = 0
		u.research_areas.each do |ra|
			if (ra.name.to_s == a.apply_yourself.research_area.to_s)
				ra_match = 1
			end
		end
		if criteria == 'country'
			if (u.country.to_s == a.apply_yourself.citizenship.to_s)
				cost[i][j] = 1
			elsif (ra_match == 1)
				cost[i][j] = 10
			else
				cost[i][j] = 100
			end
        	else  #ra = research area
    			if (u.country.to_s == a.apply_yourself.citizenship.to_s)
                                cost[i][j] = 10
                        elsif (ra_match == 1)
                                cost[i][j] = 1
                        else
                                cost[i][j] = 100
                        end
        	end
		else
			cost[i][j] = 10000
			capacity[i][j] = capacity[j][i] = 0
		end
		cost[j][i] = cost[i][j]
	end
	end
	#print cost
	#puts
	#print capacity
	min_cost_max_flow(v, cost, capacity)
	
	
	end
    		redirect_to "/view_table/view?auto_assign=0"
  end
   
  def min_cost_max_flow(n, cost, net)
	# the augmented path
	path = Array.new(n,-1)
	# original capacity (fixed: problems regarding with shallow copies)
	cap = Array.new(n, 0) {Array.new(n, 0)}
	for i in 0..n-1
		for j in 0..n-1
			cap[i][j] = net[i][j]
		end
	end
	mincost,maxflow = 0,0

	while(bellman_ford(n, path, cost, net))
		now = n-1
		neck = @@MAX
		while(now != 0)
			pre = path[now]
			neck = [neck, net[pre][now]].min
			now = pre
		end
		maxflow += neck
		now = n-1

        	while(now != 0)
            		pre = path[now]
            		net[pre][now]  -= neck
            		net[now][pre]  += neck
            		cost[now][pre]  = -cost[pre][now]
            		mincost += cost[pre][now] * neck
            		now = pre
        	end
	end

	logger.debug "maxflow = #{maxflow}, #{@applications.length}"
	logger.debug "minimum cost = #{mincost}"
	
	debug_hash = Hash.new
	for i in 1..@applications.length
		for j in (@applications.length+1)..(@applications.length+@users.length)
			logger.debug "#{net[i][j]} vs #{cap[i][j]}"
			if(net[i][j] == 0 && cap[i][j] == 1)
				app = @applications[i - 1]
				u = @users[j - @applications.length - 1]
				r = Review.new
				r.timestamp = Time.now 
				r.rating = 0
				r.save
				ar = ApplicationReview.new
				ar.application_id = app.id
				ar.review_id = r.id
				ar.user_id = u.id
				ar.save
				app.assigned = 1
				app.save
				#k = j-@applications.length-1
				#if(debug_hash.key?(k))
				#	debug_hash[k] << (i-1)
				#else
				#	debug_hash[k] = [i-1]
				#end
			end
		end
	end

	#debug_hash.each_pair{|uidx,arr|
	#	logger.debug "#{uidx}"
	#	u = @users[uidx]
	#	logger.debug "#{u.id} #{u.name} #{u.workload} #{arr.length}"
	#}
  end

  # n - number of vertices
  # path - augmented path
  # cost - cost vector
  # net - residual network
  def bellman_ford(n, path, cost, net)
	# the smallest cost of path from source node to each other nodes
	ecost = Array.new(n, @@MAX)
	ecost[0] = 0
	path.fill(0){-1}
	
	flag = true
	while(flag)
		flag = false
		for i in (0..n-1)
			if(ecost[i] == @@MAX)
				next
			end
			for j in (0..n-1)
				if(!net[i][j].nil? && net[i][j] > 0 && ecost[i] + cost[i][j] < ecost[j])
					flag = true
					ecost[j] = ecost[i]+cost[i][j]
					path[j] = i
				end
			end
		end
	end
	return ecost[n-1] != @@MAX
  end

end
