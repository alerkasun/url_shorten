Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'links#index'

  resources :links, only: [:create, :show, :destroy], param: :short_url
  get '/:short_url', to: 'redirection#redirect'
end
