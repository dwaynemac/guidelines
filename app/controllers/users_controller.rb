class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    if @user.save
      respond_to do |format|
        format.html { redirect_to users_url, :notice => t('users.create.success') }
      end
    else
      respond_to do |format|
        format.html { render :action => :new }
      end
    end
  end

  def edit
    authorize! :admin, @user
    @institutions = Federation.all
  end

  def profile
    authorize! :profile, @user
  end

  def update
    success = @user.update_attributes(params[:user])
    respond_to do |format|
      format.json { render :json => jeditable_result(@user,success) }
      format.html do
        if success
          flash[:notice] = t('users.update.success')
          redirect_to root_url
        else
          @institutions = Federation.all
          render :action => 'edit'
        end
      end
    end

  end
end
