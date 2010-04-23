ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.namespace :admin do |admin|
    admin.resources :questionnaires do |q|
      q.resource :codebook
      q.resources :answers
    end
  end
  
  map.root :controller => 'questionnaires'
end
