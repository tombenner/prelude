class ApplicationController < ActionController::Base
  protect_from_forgery

  if !Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  protected
  
  def render_404(exception=nil)
    if !exception.blank?
      message = exception.message
      trace = exception.backtrace.join("\n ")
      logger.error message + "\n " + trace
    end
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception=nil)
    if !exception.blank?
      message = exception.message
      trace = exception.backtrace.join("\n ")
      logger.error message + "\n " + trace
    end
    respond_to do |format|
      format.html { render template: 'errors/500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
end
