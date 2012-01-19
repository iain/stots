Stots::Application.routes.draw do

  root :to => "projects#index"

  get "/settings" => "settings#edit"
  put "/settings" => "settings#update"

  resources :projects do
    resources :iframes, :except => [ :index ]
  end

  namespace :airbrake do
    post "/errors"   => "errors#create"
    post "/projects" => "projects#create"
    get  "/chart"    => "charts#show"
  end

  namespace :pivotal_tracker do
    post "/projects" => "projects#create"
  end

end
