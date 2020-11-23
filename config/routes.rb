Rails.application.routes.draw do
  namespace :admin do
    get '/test', to: "sample#tests"    # url :- <base_url>/admin/test
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
