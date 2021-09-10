Rails.application.routes.draw do

  root to: "homes#top"

  devise_for :clients, controllers: {
    sessions:      'clients/sessions',
    passwords:     'clients/passwords',
    registrations: 'clients/registrations'
  }

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admins do
    get 'admins/index'
    get 'admins/new'
    get 'admins/create'
    get 'admins/edit'
    get 'admins/show'
    get 'admins/update'
    get 'admins/destroy'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
