Rails.application.routes.draw do

  root to: "homes#top"
  namespace :clients do
    get 'rakuten/search'
  end
  namespace :clients do
    get 'inquiry/index'
    get 'inquiry/confirm'
    get 'inquiry/thanks'
  end

  get "home/index" => "homes#index"

  devise_for :clients, controllers: {
    sessions:      'clients/sessions',
    passwords:     'clients/passwords',
    registrations: 'clients/registrations',
    omniauth_callbacks: 'clients/omniauth_callbacks'
  }

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admins do
   resources :blogs, only: [:show,:index,:edit,:update,:destroy] do
     resources :blog_comments, only: [:create, :destroy]
    end
   resources :clients, only: [:show,:index,:edit,:update,:destroy]
  end

  scope module: "clients" do
    resources :clients, only: [:new,:show,:index,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :blogs do
     resource :favorites, only:[:create, :destroy]
     resources :blog_comments, only: [:create, :destroy]
    end
    get 'inquiry/index'
    post 'inquiry/confirm'
    post 'inquiry/thanks'
  end

end
