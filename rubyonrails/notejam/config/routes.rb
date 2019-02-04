Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Pad urls
  post 'pads/:id/edit' => 'pads#edit'

  get 'pads/:id/delete' => 'pads#delete', as: :delete_pad
  post 'pads/:id/delete' => 'pads#delete'

  get 'pads/create' => 'pads#create', as: :create_pad
  post 'pads/create' => 'pads#create'

  resources :pads, only: [:edit, :show]

  # Note urls
  get 'notes/create' => 'notes#create', as: :create_note
  post 'notes/create' => 'notes#create'

  post 'notes/:id/edit' => 'notes#edit'

  get 'notes/:id/delete' => 'notes#delete', as: :delete_note
  post 'notes/:id/delete' => 'notes#delete'

  resources :notes, only: [:edit, :show, :index]

  # User urls
  get 'signup/' => 'users#signup', as: :signup
  post 'signup/' => 'users#signup'

  get 'signin/' => 'users#signin', as: :signin
  post 'signin/' => 'users#signin'

  get 'settings/' => 'users#settings', as: :settings
  post 'settings/' => 'users#settings'

  get 'signout/' => 'users#signout', as: :signout

  get 'forgot-password/' => 'users#forgot_password', as: :forgot_password
  post 'forgot-password/' => 'users#forgot_password'

  root "notes#index"
end
