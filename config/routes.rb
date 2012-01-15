Stots::Application.routes.draw do

  root :to => "projects#index"

  resources :projects do

    get "rspec" => "rspec#show"
    get "cucumber" => "cucumber#show"
    get "coverage" => "coverage#show"

  end

end
