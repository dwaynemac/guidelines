class FollowupsController < ApplicationController

  before_filter :set_scope

  # GET /followups
  # GET /followups.xml
  def index
    @followups = @scope.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @followups }
    end
  end

  # GET /followups/1
  # GET /followups/1.xml
  def show
    @followup = @scope.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @followup }
    end
  end

  # GET /followups/new
  # GET /followups/new.xml
  def new
    @followup = @scope.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @followup }
    end
  end

  # GET /followups/1/edit
  def edit
    @followup = @scope.find(params[:id])
  end

  # POST /followups
  # POST /followups.xml
  def create
    @followup = @scope.build(params[:followup])

    respond_to do |format|
      if @followup.save
        format.html { redirect_to(@goal, :notice => t('followups.create.success')) }
        format.xml  { render :xml => @followup, :status => :created, :location => @followup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @followup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /followups/1
  # PUT /followups/1.xml
  def update
    @followup = @scope.find(params[:id])

    respond_to do |format|
      if @followup.update_attributes(params[:followup])
        format.html { redirect_to(@goal, :notice => t('followups.update.success')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @followup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /followups/1
  # DELETE /followups/1.xml
  def destroy
    @followup = @scope.find(params[:id])
    @followup.destroy

    respond_to do |format|
      format.html { redirect_to(followups_url) }
      format.xml  { head :ok }
    end
  end

  private
  def set_scope
    @goal = Goal.find(params[:goal_id])
    @scope = @goal.followups
  end
end
