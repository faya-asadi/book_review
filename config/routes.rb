Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'welcome/', to: 'welcome#home'
  get 'about', to: 'welcome#about'

  resources :books do
     resources :reviews
  end

  get 'signup', to: 'users#new'
  #post 'users', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'



  resources :users, except: [:new]

  # Serve websocket cable requests in-process
   mount ActionCable.server => '/cable'

end
