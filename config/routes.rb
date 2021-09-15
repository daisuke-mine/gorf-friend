Rails.application.routes.draw do

  root to: "homes#top"
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
   resources :blogs
   resources :clients
  end
  
  scope module: "clients" do
    root to: "clients#index"
    resources :clients, only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
    resources :blogs do
     resource :favorites, only:[:create, :destroy]
     resources :blog_comment, only: [:create, :destroy]
    end
  end

end
