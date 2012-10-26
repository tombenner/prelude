Prelude::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  match 'user_root' => redirect("/edit")
  
  get '/about' => 'pages#show', :defaults => {:key => 'about'}
  get '/about/:key' => 'pages#show'
  get '/profile/:id' => 'profiles#show', :as => :profile
  
  root :to => 'static#index'
end
