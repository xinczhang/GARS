class ReviewsController < ApplicationController

  def filter
	if(params[:by] == "research-area")
		areas = ResearchArea.where("name=?",params[:value])[0]
		user_list = areas.users
		logger.debug user_list
		respond_to do |format|
			format.html {render :text => "rrr"}
			format.json {render :json => user_list, :include => :research_areas}
		end
	elsif(params[:by] == "country")
	
	end
  end

  def post_review
    r = Review.find(params[:id])
    submit_val = params[:submit]
    if (submit_val == 'Submit')
      r.submitted = 1
    end
    r.review = params[:review]
    r.rating = params[:rating]
    r.save
    redirect_to home_reviews_path
  end


  def update_review
    @review = Review.find(params[:id])
    n = params[:name]
    v = params[:value]
    @review.send(:"#{n}=", v)
    @review.save
  end

  # edit reviews associated with an application
  def edit_reviews
    @app = Application.find(params[:id])
    @ay = @app.apply_yourself
    @app_name = @ay.first_name + ' ' + @ay.last_name
    @reviews = @app.reviews  
  end



  # GET /applications
  # GET /applications.xml
  def index
    @applications = Review.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.xml
  def show
    @application = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.xml
  def new
    @application = Review.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Review.find(params[:id])
  end

  # POST /applications
  # POST /applications.xml
  def create
    @application = Review.new(params[:application])

    respond_to do |format|
      if @application.save
        format.html { redirect_to(@application, :notice => 'Application was successfully created.') }
        format.xml  { render :xml => @application, :status => :created, :location => @application }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /applications/1
  # DELETE /applications/1.xml
  def destroy
    @application = Review.find(params[:id])
    @application.destroy

    respond_to do |format|
      format.html { redirect_to(applications_url) }
      format.xml  { head :ok }
    end
  end
end
