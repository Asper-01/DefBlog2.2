Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Routes pour gérer les cookies
  get 'cookies/preferences', to: 'cookies#preferences', as: 'cookies_preferences'
  get 'accept_cookies', to: 'cookies#accept', as: 'accept_cookies'
  get 'decline_cookies', to: 'cookies#decline', as: 'decline_cookies'
  post 'cookies/update_consent', to: 'cookies#update_consent', as: 'update_cookies_accepted'


  get 'accept_cookies', to: 'cookies#accept'
  get 'decline_cookies', to: 'cookies#decline'
  post 'cookies/update_consent', to: 'cookies#update_consent', as: 'update_consent_cookies'
  # Pages statiques pour le footer
  get 'legal', to: 'pages#legal', as: :legal
  get 'sitemap', to: 'pages#sitemap', as: :sitemap
  get 'contact', to: 'pages#contact', as: :contact
  # SearchBar
  get 'search', to: 'articles#search', as: :search_articles

  # Pages publiques
  root 'articles#index'
  resources :articles, only: [:index, :show], param: :slug do
    resources :comments, only: [:create, :destroy]
  end
  resources :tags, only: [:index, :show, :create], param: :slug



  # Vérification de santé
  get "up" => "rails/health#show", as: :rails_health_check

  # Vérifications d'inscriptions:
  namespace :users do
    get 'check_uniqueness', to: 'checks#uniqueness'
  end

  # Administration
  namespace :admin do
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :articles, only: [:index, :new, :edit, :create, :update, :destroy], param: :slug do
      resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
    end
    resources :tags, only: [:index, :new, :edit, :create, :update, :destroy], param: :slug
    resources :categories, only: [] do
      member do
        get :tags
      end
    end
    get 'dashboard', to: 'dashboard#index'
  end
end
