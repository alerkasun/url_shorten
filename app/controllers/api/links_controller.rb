class Api::LinksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    links = Link.all
    render json: links, each_serializer: LinkSerializer
  end

  def create
    link = Link.new(link_params)
    if link.save
      render json: { short_url: link.short_url, password: link.password }, status: :created

    else
      render json: link.errors, status: :unprocessable_entity
    end
  end

  def destroy
    link = Link.find_by(short_url: params[:id])

    if link && params[:password] && params[:password] == link.password
      link.destroy
      render json: { message: 'Link successfully deleted' }, status: :ok
    else
      render json: { error: 'Invalid link or password' }, status: :forbidden
    end
  end

  private

  def link_params
    params.permit(:original_url)
  end
end
