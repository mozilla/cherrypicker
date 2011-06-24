BacnlabCom::Application.routes.draw do

  get "bacn/index"

  get "site/index"
  get "site/about"
  
  resources :session
  	
  root :to => "site#index"

  # See how all your routes lay out with "rake routes"

end
