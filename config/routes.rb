ActionController::Routing::Routes.draw do |map|
  map.resources :answers do |answer|
    answer.resource :report
  end

  map.root :controller => 'questionnaires'
end
