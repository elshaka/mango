# encoding: UTF-8

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :store_location, :check_authentication, :check_permissions
  skip_before_filter :verify_authenticity_token
 
  helper :flash
  helper :modal
  include ModalHelper::Modal

  # Pagination config
  PaginationHelper::DEFAULT_OPTIONS[:prev_title] = ''
  PaginationHelper::DEFAULT_OPTIONS[:next_title] = ''
  PaginationHelper::DEFAULT_OPTIONS[:first_title] = ''
  PaginationHelper::DEFAULT_OPTIONS[:last_title] = ''
  PaginationHelper::DEFAULT_OPTIONS[:prev_tooltip] = 'Pág. anterior'
  PaginationHelper::DEFAULT_OPTIONS[:next_tooltip] = 'Pág. siguiente'
  PaginationHelper::DEFAULT_OPTIONS[:first_tooltip] = 'Primera pág.'
  PaginationHelper::DEFAULT_OPTIONS[:last_tooltip] = 'Última pág.'

  def check_authentication
    unless session[:user_id]
      respond_to do |format|
        format.html do
          session[:request] = action_name
          redirect_to sessions_path
        end
        format.json { head :unauthorized }
        format.xml { head :unauthorized }
      end
    end
  end

  def check_permissions
    return true if (controller_name == 'sessions')
    granted = User.find(session[:user_id]).has_global_permission?(controller_name, action_name)
    return true if granted
    flash[:notice] = "No tiene permiso para acceder a ese recurso"
    flash[:type] = 'error'
    request.env["HTTP_REFERER"] ? (redirect_to :back) : (redirect_to :action=>'show', :controller=>'sessions')
    return false
  end

  def store_location
    return unless request.get?

    path = request.fullpath
    if (path != '/sessions' && !request.xhr?)
      session[:previous_url] = path
    end
  end
end
