require './lib/seo_page_content/seo_page_content.rb'
require './app/models/seo_slug.rb'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SeoPageContent::ControllerExtensions
  
  ActionView::Base.send :include, SeoPageContent::Helpers

  def index
  end

  def set_user_guid
    cookies.permanent[:__vst] = SecureRandom.uuid unless cookies[:__vst]
    unless cookies[:__ssn]
      cookies[:__ssn] = SecureRandom.uuid
      cookies[:__ssnstarttime] = Time.current.to_i
    end
  end

  # TODO: This is a bad way of doing things .. this needs redo
  def seo_meta_data(pagename, seo_data = nil)
    params = {pagename: pagename, seo_data: seo_data}
    if pagename == 'home'
      params.merge!(current_url: request.fullpath)
    end
    @seo = SeoSlug.new(params)
    check_for_registered_user
  end

  def seo_geo_headers
    if cookies[:far_geo].present?
      current_geo = JSON.parse(cookies[:far_geo])
      GeoHeader.new Hashie::Mash.new(current_geo)
    end
  end

  def dot_realtor_profile?
    request.host.end_with?('.realtor')
  end

  def syndicated_profile?
    params['syndicated'] == 'true'
  end

  def white_label_profile?
    request.params['realtor'] == '1' || syndicated_profile?
  end

  def request_url_without_query_params
    request.original_url.split('?')[0]
  end

  def request_url_without_query_params_and_pagination
    request_url_without_query_params.split('/pg-')[0]
  end


  # Bad way - need to re-do
  def show_header_footer?
    if dot_realtor_profile?
      false
    elsif white_label_profile?
      false
    elsif syndicated_profile?
      false
    else
      true
    end
  end

  def omniture_dtm_tags(data)
    @data = data
  end

  # Bad way - need to re-do
  def bind_breadcrumb
    if dot_realtor_profile?
      false
    elsif white_label_profile?
      false
    elsif syndicated_profile?
      false
    else
      true
    end
  end

  # We are going to maintain this log till Public launch.
  def authorized?
    if ENV.fetch('SKIP_LOGIN').eql?('true')
      true
    else
      !session[:user].nil?
    end
  end

  def authorize
    unless authorized?
      redirect_to log_in_path
      false
    end
  end


  # Anytime there is a debug=1 in the url, log external calls.
  # Note: Instead of polluting the application with adding the call urls to the Hash/Array, created a separate diagnotics.log File
  # And this way if required, can expose the entire debug trace too.
  def log_diagnostics
    if params[:debug]
      File.truncate(Rails.root.join("log/diagnostic.log"), 0)
      file_logger       = Logger.new(Rails.root.join("log/diagnostic.log"))
      file_logger.level = Logger::DEBUG
      Rails.logger.extend(ActiveSupport::Logger.broadcast(file_logger))
    end
  end


  private

  def domain
    host[/([^\.]+)\.realtor$/, 1]
  end

  def host
    request.host
  end

  def check_for_registered_user
    @is_user_registered = cookies['REMEMBER_ME']
  end

  def body_class class_name
    @body_class = class_name
  end

  def raise_error_not_found
    raise ActionController::RoutingError.new(params)
  end

  def raise_error_internal_error
    raise StandardError.new(params)
  end

  def rescue_not_found(exception)
    # NewRelic::Agent.notice_error(exception, options = { })
    render "error/route_not_found", status: 404, layout: 'error_layout', formats: [:html]
  end

  def rescue_internal_server_error_exception(exception)
    # NewRelic::Agent.notice_error(exception, options = { })
    render "error/internal_server_error", status: 500, layout: 'error_layout'
  end
end
