Csp::Application.routes.draw do
  resources :transactions  do
    post :csv_import, :on=>:collection
    post :export, :on=>:collection
    post :export_form, :on=>:collection
  end

  resources :accounts  do
    post 'csv_import',:on=>:collection
  end

  root :to => "accounts#index"

  # match ':controller(/:action(/:id(.:format)))'
end
