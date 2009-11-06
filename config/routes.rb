ActionController::Routing::Routes.draw do |map|

  map.resources :questionnaires do |q|
    q.resources :answers
  end
  
  map.resources :answers do |answer|
    answer.resource :report
  end

  map.root :controller => 'questionnaires'
end
