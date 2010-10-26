class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    @institutions = Federation.all
  end

  def update
    @user = User.find(params[:id])
    success = @user.update_attributes(params[:user])
    respond_to do |format|
      format.html do
        if success
          flash[:notice] = t('users.update.success')
          redirect_to users_url
        else
          @institutions = Federation.all
          render :action => 'edit'
        end
      end
    end

  end
end
