class PeopleController < ApplicationController
  load_and_authorize_resource

  # GET /people
  # GET /people.xml
  def index
    # @people = Person.accesible_by() -- loaded in load_and_authorize_resource, its a scope.

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.xml
  def create
    respond_to { |format|
      if @person.save
        format.html { redirect_to(people_url, :notice => t('people.create.success')) }
        format.xml { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
      end }
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
end
