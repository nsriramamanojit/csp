Csp::Application.routes.draw do
  resources :users do
    get :profile,:on=>:member
    get 'edit_profile', :on=>:member
    put 'update_profile', :on=>:member
    get 'change_password', :on=>:member
#    put 'update_password',:on=>:member
  end
  resources :generals

  resources :transactions  do
    post :csv_import, :on=>:collection
    post :export, :on=>:collection
    post :remove,:on=>:collection
  end

  resources :accounts  do
    post 'csv_import',:on=>:collection
    get 'export',:on=>:collection
  end

#  root :to => "accounts#index"

  resources :user_sessions

  match 'login' => "user_sessions#new", :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout

  root :to => "user_sessions#new"

  match ':controller(/:action(/:id(.:format)))'
end
