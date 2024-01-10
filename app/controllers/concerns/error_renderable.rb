module ErrorRenderable
  extend ActiveSupport::Concern
  
  private
  
  def render_error(message, status)
    render json: { error: message }, status: status
  end
end