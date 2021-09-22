Rails.application.routes.draw do

  namespace :clients do
    get 'rakuten/search'
  end
  namespace :clients do
    get 'inquiry/index'
    get 'inquiry/confirm'
    get 'inquiry/thanks'
  end
  root to: "homes#top"
  get "home/index" => "homes#index"

  devise_for :clients, controllers: {
    sessions:      'clients/sessions',
    passwords:     'clients/passwords',
    omniauth_callbacks: 'clients/omniauth_callbacks',
    registrations: 'clients/registrations'
  }

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admins do
   resources :blogs, only: [:show,:index,:edit,:update]
   resources :clients, only: [:show,:index,:edit,:update]
  end

  scope module: "clients" do
    resources :clients, only: [:show,:index,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :blogs do
     resource :favorites, only:[:create, :destroy]
     resources :blog_comment, only: [:create, :destroy]
    end
    get 'inquiry/index'
    post 'inquiry/confirm'
    post 'inquiry/thanks'
  end

end
