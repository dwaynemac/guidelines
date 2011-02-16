class AktionsController < ApplicationController

  before_filter :set_scope
  before_filter :set_aktion, :except => :index

  # resource needs to be loaded before this filter
  authorize_resource

  # GET /aktions
  # GET /aktions.xml
  def index
    @aktions = @scope.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @aktions }
    end
  end

  # GET /aktions/1
  # GET /aktions/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aktion }
    end
  end

  # GET /aktions/new
  # GET /aktions/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @aktion }
    end
  end

  # GET /aktions/1/edit
  def edit
    institution = @aktion.goal.institution
    @people = institution.nil?? Person.all : institution.people.all
  end

  # POST /aktions
  # POST /aktions.xml
  def create
    respond_to do |format|
      if @aktion.save
        format.html { redirect_to(goal_url(:id => params[:goal_id]), :notice => t('aktions.create.succes')) }
        format.xml  { render :xml => @aktion, :status => :created, :location => @aktion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @aktion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /aktions/1
  # PUT /aktions/1.xml
  def update
    respond_to do |format|
      if @aktion.update_attributes(params[:aktion])
        format.json { render :json => jeditable_result(@aktion,true) }
        format.html { redirect_to(goal_url(:id => @aktion.goal_id), :notice => t('aktions.update.success')) }
        format.xml  { head :ok }
      else
        format.json { render :json => jeditable_result(@aktion,false) }
        format.html { render :aktion => "edit" }
        format.xml  { render :xml => @aktion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /aktions/1
  # DELETE /aktions/1.xml
  def destroy
    @aktion.destroy

    respond_to do |format|
      format.html { redirect_to(@goal.nil? ? aktions_url : @goal) }
      format.xml  { head :ok }
    end
  end

  private
  def set_scope
    if params[:goal_id]
      @goal = Goal.find(params[:goal_id])
      @scope = @goal.aktions
    else
      @scope = Aktion
    end
  end

  def set_aktion
    if params[:action] == 'new' || params[:action] == 'create'

      # for setting date from text_field'
      unless params[:aktion].try(:fetch,:starts_on,nil).nil?
        params[:aktion][:starts_on] = Date.parse(params[:aktion][:starts_on])
      end
      unless params[:aktion].try(:fetch,:ends_on,nil).nil?
        params[:aktion][:ends_on] = Date.parse(params[:aktion][:ends_on])
      end

      @aktion = @scope.build(params[:aktion])
    else
      @aktion = @scope.find(params[:id])
    end
  end
end
