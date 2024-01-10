class ApplicationController < ActionController::Base
  include ErrorRenderable

  rescue_from StandardError do |exception|
    render_error(exception.message, :internal_server_error)
  end
end
