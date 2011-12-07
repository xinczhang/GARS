class OfficialTestScoresController < ApplicationController
  
  def index
    @official_test_scores = OfficialTestScore.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apply_official_test_scores }
    end
  end

  def update_field
    @official_test_score = OfficialTestScore.find(params[:id])
    n = params[:name]
    v = params[:value]
    @official_test_score.send(:"#{n}=", v)
    @official_test_score.save
  end

  # GET /apply_yourselves/1
  # GET /apply_yourselves/1.xml
  def show
    @official_test_score = OfficialTestScore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @official_test_score }
    end
  end

  # GET /apply_yourselves/new
  # GET /apply_yourselves/new.xml
  def new
    @official_test_score = OfficialTestScore.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @official_test_score }
    end
  end

  # GET /apply_yourselves/1/edit
  def edit
    @official_test_score = OfficialTestScore.find(params[:id])
  end

  # POST /apply_yourselves
  # POST /apply_yourselves.xml
  def create
    @official_test_score = OfficialTestScore.new(params[:official_test_score])

    respond_to do |format|
      if @official_test_score.save
        format.html { redirect_to(@official_test_score, :notice => 'Apply yourself was successfully created.') }
        format.xml  { render :xml => @official_test_score, :status => :created, :location => @official_test_score }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @official_test_score.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apply_yourselves/1
  # PUT /apply_yourselves/1.xml
  def update
    @official_test_score = OfficialTestScore.find(params[:id])

    respond_to do |format|
      if @official_test_score.update_attributes(params[:apply_yourself])
        format.html { redirect_to(@official_test_score, :notice => 'Apply yourself was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @official_test_score.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apply_yourselves/1
  # DELETE /apply_yourselves/1.xml
  def destroy
    @official_test_score = OfficialTestScore.find(params[:id])
    @official_test_score.destroy

    respond_to do |format|
      format.html { redirect_to(official_test_scores_url) }
      format.xml  { head :ok }
    end
  end
end
