ActionController::Routing::Routes.draw do |map|
  map.resources :questionnaires, :member => {:take => :get,
                                             :answer => :post } do |questionnaire|
    questionnaire.resource :report
  end

  map.root :controller => 'questionnaires'
end
