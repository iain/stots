Stots::Application.routes.draw do

  root :to => "projects#index"

  resources :projects do

    get "rspec" => "rspec#show"

  end

end
