class GoalsController < ApplicationController
  before_filter :set_scope

  before_filter :get_goal, :except => [:index, :year_plan, :new, :create, :overdue, :show_by_id_number, :tree]
  before_filter :build_goal, :only => [:new, :create]

  authorize_resource :except => [:year_plan, :overdue,:tree]

  # GET /goals
  # GET /goals.xml
  def index
    @goals = Goal.roots
    @goals.sort!{|a,b| a.id_number <=> b.id_number}

    respond_to do |format|
      format.html do
        @goals = Goal.roots
        @goals.sort!{|a,b| a.id_number <=> b.id_number}
      end
      format.csv do
        @goals = Goal.all
        @goals.sort!{|a,b| a.id_number <=> b.id_number}
        render :layout => false
      end
    end
  end

  def tree
    authorize! :see_tree, Goal

    redirect_to root_url, :flash => {:notice => "need institution"} if current_user.institution.nil?

    @roots = Goal.roots

  end

  def overdue
    authorize! :read, Goal


    @goals = Goal.visible_for(current_user).close_to_due_date.all
    @goals.sort!{|a,b| a.id_number <=> b.id_number}

    respond_to do |format|
      format.html
    end
  end

  # GET /goals/1
  # GET /goals/1.xml
  def show

    @page_title = "#{@goal.id_number} #{@goal.objective}"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @goal }
    end
  end
  def show_by_id_number
    if params[:id_number].nil?
      flash[:error] = t('goals.show_by_id_number.id_number_missing')
      redirect_to goals_url
    end
    @goal = Goal.get_by_id_number(params[:id_number])
    respond_to do |format|
      format.html { render :action => :show }
    end
  end

  # GET /goals/new
  # GET /goals/new.xml
  def new
    
    # federation user can only create his own goals
    @goal.institution_id=current_user.institution_id

    if @goal.institution_id.nil?
      @goal.institution_id = @parent_goal.try(:institution_id)
    end

    institution = @goal.institution
    @people = institution.nil?? Person.all : institution.people.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @goal }
    end
  end

  # GET /goals/1/edit
  def edit
    @goals = Goal.all - @goal.descendants - [@goal]

    institution = @goal.institution
    @people = institution.nil?? Person.all : institution.people.all

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
    unless params[:goal].try(:fetch,:due_on,nil).nil?
      params[:goal][:due_on] = Date.parse(params[:goal][:due_on])
    end
    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.json { render :json => jeditable_result(@goal,true) }
        format.html { redirect_to(@goal, :notice => t('goals.update.success')) }
        format.xml  { head :ok }
      else
        edit # run edit method for variables needed in form.
        format.json { render :json => jeditable_result(@goal, false)}
        format.html { render :action => "edit" }
        format.xml  { render :xml => @goal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.xml
  def destroy
    return_to = @goal.goal.nil?? goals_url : goal_url(@goal.goal)

    @goal.destroy

    respond_to do |format|
      format.html { redirect_to(return_to) }
      format.xml  { head :ok }
    end
  end

  def year_plan
    authorize! :see, :year_plan
    @roots = Goal.roots
    @subgoals = Goal.all(:conditions => {:goal_id => Goal.roots.map{|g|g.id}}, :include => :institution)
    @subgoals.sort!{|a,b| a.id_number <=> b.id_number }
    respond_to do |format|
      format.html
    end
  end

  private
  def set_scope
    if params[:goal_id]
      @parent_goal = Goal.find(params[:goal_id])
      @scope = @parent_goal.goals
    else
      @scope = Goal
    end
  end

  def get_goal
    @goal = @scope.find(params[:id])
  end

  def build_goal

    # for setting date from text_field'
    begin
      unless params[:goal].try(:fetch,:due_on,nil).nil?
        params[:goal][:due_on] = Date.parse(params[:goal][:due_on])
      end
    rescue ArgumentError => e
      params[:goal][:due_on]= nil
      flash[:error] = e
    end

    @goal = (@scope.is_a?(Class))? @scope.new(params[:goal]) : @scope.build(params[:goal])
  end

end
