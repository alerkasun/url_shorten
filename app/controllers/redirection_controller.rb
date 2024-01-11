class RedirectionController < ApplicationController
  include ErrorRenderable

  def redirect
    link = Link.find_by(short_url: params[:short_url])
    if link
      link.increment_visit_count
      redirect_to link.original_url, allow_other_host: true
    else
      render plain: "404 Not Found", status: :not_found
    end
  end

end
  