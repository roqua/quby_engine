Quby::Engine.routes.draw do
  resources :questionnaires do
    resources :answers  do
        put "print", :on => :member
    end
  end
end
