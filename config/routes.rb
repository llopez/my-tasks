MyTasks::Application.routes.draw do
  get 'tasks', to: 'tasks#index'
  get 'tasks/:id', to: 'tasks#show'
  post 'tasks', to: 'tasks#create'
  delete 'tasks/:id', to: 'tasks#destroy'
  put 'tasks/:id', to: 'tasks#update'
  
  root to: 'tasks#index'
end
