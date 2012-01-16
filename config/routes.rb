Stots::Application.routes.draw do

  root :to => "projects#index"

  resources :projects do

    resources :iframes, :except => [ :index ]
    get "/chart/:id" => "charts#show", :as => :chart

    resources :errors

  end

  namespace :airbrake do
    resources :errors
    resources :projects
  end

end
