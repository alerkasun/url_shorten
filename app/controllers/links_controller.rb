class LinksController < ApplicationController
    include ErrorRenderable

    skip_before_action :verify_authenticity_token

    def index
      @links = Link.all
    end

    def create
      link = Link.new(link_params)
      if link.save
        render json: link, status: :created
      else
        render json: { errors: link.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      link = Link.find_by!(short_url: params[:short_url])
      render json: link
      rescue ActiveRecord::RecordNotFound
        render_error("Link not found", :not_found)
      end
    
      def destroy
        link = Link.find_by!(short_url: params[:short_url])
        if link&.valid_password?(params[:password])
          link.destroy
          render json: { message: "Link successfully deleted" }
        else
          render_error("Invalid password or link not found", :unauthorized)
        end
      rescue ActiveRecord::RecordNotFound
        render_error("Link not found", :not_found)
      end
  
    private
  
    def link_params
      params.require(:link).permit(:original_url, :password)
    end
  end
  