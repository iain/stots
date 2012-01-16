Stots::Application.routes.draw do

  root :to => "projects#index"

  resources :projects do

    resources :iframes

  end

end
