ActiveAdmin.register Link do
  controller do
    include ErrorRenderable
  end

  config.per_page = 10

  filter :original_url
  filter :short_url
  filter :created_at

  action_item :delete_old_links, only: :index do
    link_to 'Delete Old Links', delete_old_links_admin_links_path, method: :delete
  end

  collection_action :delete_old_links, method: :delete do
    links = Link.where('created_at < ?', 2.months.ago).destroy_all
    redirect_to collection_path, notice: "Old links were deleted! Count of deleted links - #{links.size}"
  end

  index do
    selectable_column
    id_column
    column :original_url do |link|
      div style: "max-width: 200px;" do
        link.original_url
      end
    end
    column :short_url
    column :visit_count
    actions
  end
  
  actions :index, :show, :destroy
  
  filter :original_url
  filter :short_url
end
  