Stots::Application.routes.draw do

  root :to => "projects#index"

  resources :projects do

    resources :iframes
    get "/chart/:id" => "charts#show", :as => :chart

  end

end
