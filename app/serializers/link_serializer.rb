class LinkSerializer < ActiveModel::Serializer
  attributes :id, :original_url, :short_url, :visit_count, :full_link_with_short_url

  def full_link_with_short_url
    Rails.application.routes.url_helpers.root_url(host: 'localhost', port: 3000) + object.short_url
  end
end