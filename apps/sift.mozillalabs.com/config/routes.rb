MozillaSift::Application.routes.draw do

  match 'dashboard' => 'dashboard#index'
  match 'about' => 'site#about'
  
  resources :session
  resources :bacn
  	
  root :to => "site#index"

  # See how all your routes lay out with "rake routes"

end
