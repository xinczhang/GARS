class ApplyYourselvesController < ApplicationController
  # GET /apply_yourselves
  # GET /apply_yourselves.xml
  def index
    @apply_yourselves = ApplyYourself.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apply_yourselves }
    end
  end

  # GET /apply_yourselves/1
  # GET /apply_yourselves/1.xml
  def show
    @apply_yourself = ApplyYourself.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apply_yourself }
    end
  end

  # GET /apply_yourselves/new
  # GET /apply_yourselves/new.xml
  def new
    @apply_yourself = ApplyYourself.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @apply_yourself }
    end
  end

  # GET /apply_yourselves/1/edit
  def edit
    @apply_yourself = ApplyYourself.find(params[:id])
  end

  # POST /apply_yourselves
  # POST /apply_yourselves.xml
  def create
    @apply_yourself = ApplyYourself.new(params[:apply_yourself])

    respond_to do |format|
      if @apply_yourself.save
        format.html { redirect_to(@apply_yourself, :notice => 'Apply yourself was successfully created.') }
        format.xml  { render :xml => @apply_yourself, :status => :created, :location => @apply_yourself }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @apply_yourself.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apply_yourselves/1
  # PUT /apply_yourselves/1.xml
  def update
    @apply_yourself = ApplyYourself.find(params[:id])

    respond_to do |format|
      if @apply_yourself.update_attributes(params[:apply_yourself])
        format.html { redirect_to(@apply_yourself, :notice => 'Apply yourself was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @apply_yourself.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apply_yourselves/1
  # DELETE /apply_yourselves/1.xml
  def destroy
    @apply_yourself = ApplyYourself.find(params[:id])
    @apply_yourself.destroy

    respond_to do |format|
      format.html { redirect_to(apply_yourselves_url) }
      format.xml  { head :ok }
    end
  end
end
