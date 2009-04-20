ActionController::Routing::Routes.draw do |map|
  map.resources :questionnaires, :member => {:take => :get,
                                             :answer => :post }
end
