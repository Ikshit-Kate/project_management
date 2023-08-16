Rails.application.routes.draw do
  
  resources :users, param: :_username 
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'
  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'
  resources :tasks
  resources :task_assignments
end
