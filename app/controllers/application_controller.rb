class ApplicationController < ActionController::Base
  include ErrorRenderable

  def authenticate_admin
    authenticate_or_request_with_http_basic do |name, password|
      name == "admin" && password == "admin"
    end
  end

  rescue_from StandardError do |exception|
    render_error(exception.message, :internal_server_error)
  end
end
