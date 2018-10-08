# frozen_string_literal: true

Quby::Engine.routes.draw do
  resources :questionnaires, only: [] do
    resources :answers  do
        put "print", :on => :member
    end
  end
end
