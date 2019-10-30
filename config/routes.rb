Rails.application.routes.draw do
  namespace :quby do
    resources :questionnaires, only: [] do
      resources :answers do
        put "pdf", :on => :member
      end
    end
  end
end
