Rails.application.routes.draw do
  # root  'groups#create'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  } 

  # devise_scope :user do
  #   root 'devise/sessions#new'
  # end

  root 'schedules#index'
  resources :schedules, only: [:index, :create, :update]
  resources :groups, only: [:new, :edit, :create, :update]
  resources :group_users, only: [:create, :update]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
