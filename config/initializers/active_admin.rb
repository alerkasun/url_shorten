ActiveAdmin.setup do |config|
  config.site_title = "Url Shorten"
  config.current_user_method = false
  config.logout_link_path = :destroy_admin_user_session_path
  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
  config.authentication_method = :authenticate_admin
end
