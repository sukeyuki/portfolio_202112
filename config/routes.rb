Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  } 


  root 'schedules#index'
  resources :schedules, only: [:index, :create, :update, :destroy]
  resources :groups, only: [:new, :edit, :create, :update]
  resources :group_users, only: [:create, :update, :destroy]

  post :"invite_users",to: "invite_users#invite", as: "invite_users"
  post :"invite_user/:id",to: "invite_users#reply", as: "invite_user"

  post 'groups/:id/edit', to: 'groups#edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
