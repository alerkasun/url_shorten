Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  ActiveAdmin.routes(self)
  root to: redirect('/api-docs')

  resources :links, only: [:create, :show, :destroy], param: :short_url
  get '/:short_url', to: 'redirection#redirect'

  namespace :api do
    resources :links, only: [:index, :create, :destroy]
  end
end
