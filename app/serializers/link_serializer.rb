class LinkSerializer < ActiveModel::Serializer
  attributes :id, :original_url, :short_url, :visit_count, :full_link_with_short_url

  def full_link_with_short_url
    host = ActionController::Base.default_url_options[:host] || 'localhost'
    port = ActionController::Base.default_url_options[:port] || 3000
    Rails.application.routes.url_helpers.root_url(host: host, port: port) + object.short_url
  end
end