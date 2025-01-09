Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Pages statiques pour le footer
  get 'legal', to: 'pages#legal', as: :legal
  get 'sitemap', to: 'pages#sitemap', as: :sitemap
  get 'contact', to: 'pages#contact', as: :contact

  # Pages publiques
  root 'articles#index'
  resources :articles, only: [:index, :show], param: :slug do
    resources :comments, only: [:create]
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
