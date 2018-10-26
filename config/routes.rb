Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: '/api/v1/auth'
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :apidocs, only: [:index]
      devise_scope :user do
        put 'set_password', to: 'passwords#set_new_password'
      end
      resources :users do
        resources :filters
      end
    end
  end
end
