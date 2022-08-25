Rails.application.routes.draw do
  resources :questions do
    resources :answers
  end
  root 'home_page#index'
end
