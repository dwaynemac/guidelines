class ApplicationController < ActionController::Base
  helper :all

  include AuthSystem
  include DRCClient::HelperMethods

  before_filter DRCClient.filter
  before_filter :create_local_user_if_required
  before_filter :login_required

  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    redirect_to root_url
  end

  # == Arguments
  # object: object to evaluate
  # status: true if updates successfully false if failed
  def jeditable_result(object, status,options = {})
    param = options[:param] || params[:wants]
    tokens = param.split('.')
    result = object
    if status
      tokens.each do |t|
        result = result.send(t)
      end
    else
      result = t('jeditable.error_saving')
    end
    {:result => result}
  end

  private
  def set_locale
    new_locale = params[:locale]
    new_locale ||= current_user.locale if logged_in?
    new_locale ||= request.preferred_language_from(I18n.available_locales)
    I18n.locale = new_locale
  end

  def create_local_user_if_required
    return unless logged_in_drc?
    User.find_or_create_by_drc_user(current_drc_user)
  end
end
