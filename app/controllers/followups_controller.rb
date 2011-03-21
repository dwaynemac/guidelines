class FollowupsController < ApplicationController

  before_filter :set_scope
  before_filter :set_followup, :except => :index
  authorize_resource

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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @followup }
    end
  end

  # GET /followups/new
  # GET /followups/new.xml
  def new
    @followup.valid_on= Time.zone.today
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @followup }
    end
  end

  # GET /followups/1/edit
  def edit
  end

  # POST /followups
  # POST /followups.xml
  def create

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

    respond_to do |format|
      if @followup.update_attributes(params[:followup])
        format.json { render :json => jeditable_result(@followup, true)}
        format.html { redirect_to(@goal, :notice => t('followups.update.success')) }
        format.xml  { head :ok }
      else
        format.json { render :json => jeditable_result(@followup, false)}
        format.html { render :action => "edit" }
        format.xml  { render :xml => @followup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /followups/1
  # DELETE /followups/1.xml
  def destroy
    @followup.destroy

    if @goal
      back_to= @goal
    else
      back_to= root_url
    end

    respond_to do |format|
      format.html { redirect_to(back_to) }
      format.xml  { head :ok }
    end
  end

  private
  def set_scope
    if params[:goal_id]
      @goal = Goal.find(params[:goal_id])
      @scope = @goal.followups
    else
      @scope = Followup
    end
  end

  def set_followup
    if params[:action] == 'create' || params[:action] == 'new'
      @followup = @scope.build(params[:followup])
    else
      @followup = @scope.find(params[:id])
    end
  end

end
