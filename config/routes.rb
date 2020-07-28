Rails.application.routes.draw do
  mount Rswag::Ui::Engine, at: '/api-docs'
  mount Rswag::Api::Engine, at: '/api-docs'
  resources :adverts
  post 'adverts/:id/upload_photo', to: 'adverts#upload_photo'
  post 'users/:id/upload_photo', to: 'users#upload_photo'
  devise_for :users,skip: [:sessions, :registrations, :passwords]
  devise_scope :user do
    post 'login', to: 'sessions#create', as: :user_session
    delete 'logout', to: 'sessions#logout', as: :destroy_user_session
    post 'password/reset', to: 'registrations#password_reset'
    post 'password/edit', to: 'registrations#password_edit'
    post 'register/customer', to: 'registrations#register'
    post 'register/company', to: 'registrations#register'
    put 'profile', to: 'registrations#profile'
    post 'profile/upload_photo', to: 'registrations#upload_photo'
  end
end
