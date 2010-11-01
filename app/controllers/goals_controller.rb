class GoalsController < ApplicationController
  before_filter :set_scope

  before_filter :get_goal, :except => [:index, :year_plan, :new, :create]
  before_filter :build_goal, :only => [:new, :create]

  authorize_resource :except => :year_plan

  # GET /goals
  # GET /goals.xml
  def index
    @goals = Goal.roots

    # TODO for larger databases id_number, should be cached on DB for faster sorting?
    @goals.sort!{|a,b| a.id_number <=> b.id_number}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @goals }
    end
  end

  # GET /goals/1
  # GET /goals/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @goal }
    end
  end

  # GET /goals/new
  # GET /goals/new.xml
  def new

    # federation user can only create his own goals
    @goal.institution_id=current_user.institution_id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @goal }
    end
  end

  # GET /goals/1/edit
  def edit
    @goals = Goal.all - @goal.descendants - [@goal]
    @goals.sort!{|a,b| a.id_number <=> b.id_number}
  end

  # POST /goals
  # POST /goals.xml
  def create
    respond_to do |format|
      if @goal.save
        format.html { redirect_to(@goal.goal_id.nil?? goals_url : goal_url(:id => @goal.goal_id), :notice => t('goals.create.success')) }
        format.xml  { render :xml => @goal, :status => :created, :location => @goal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /goals/1
  # PUT /goals/1.xml
  def update
    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.json { render :json => jeditable_result(@goal,true) }
        format.html { redirect_to(@goal, :notice => 'Goal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.json { render :json => jeditable_result(@goal, false)}
        format.html { render :action => "edit" }
        format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.xml
  def destroy
    @goal.destroy

    respond_to do |format|
      format.html { redirect_to(goals_url) }
      format.xml  { head :ok }
    end
  end

  def year_plan
    authorize! :see, :year_plan
    @roots = Goal.roots
    @subgoals = Goal.all(:conditions => "goal_id is not null")
    @subgoals.sort!{|a,b| a.id_number <=> b.id_number }
    respond_to do |format|
      format.html
    end
  end

  private
  def set_scope
    if params[:goal_id]
      @scope = Goal.find(params[:goal_id]).goals
    else
      @scope = Goal
    end
  end

  def get_goal
    @goal = @scope.find(params[:id])
  end

  def build_goal
    # for setting date from text_field'
    unless params[:goal].try(:fetch,:due_on,nil).nil?
      params[:goal][:due_on] = Date.parse(params[:goal][:due_on])
    end
    @goal = (@scope.is_a?(Class))? @scope.new(params[:goal]) : @scope.build(params[:goal])
  end

end
