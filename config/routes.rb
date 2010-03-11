ActionController::Routing::Routes.draw do |map|

  map.resources :questionnaires do |q|
    q.resource :codebook
    q.resources :answers
  end
  
  map.root :controller => 'questionnaires'
end
