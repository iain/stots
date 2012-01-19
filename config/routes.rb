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
    get  "/projects/:project_id/chart"  => "charts#show",  :as => :project_chart
    get  "/projects/:project_id/errors" => "errors#index", :as => :project_errors
  end

  namespace :pivotal_tracker do
    post "/projects" => "projects#create"
  end

end
