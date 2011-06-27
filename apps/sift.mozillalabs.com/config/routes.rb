BacnlabCom::Application.routes.draw do

  get "site/index"
  get "site/about"
  
  resources :session
  resources :bacn
  	
  root :to => "site#index"

  # See how all your routes lay out with "rake routes"

end
