# frozen_string_literal: true

Quby::Engine.routes.draw do
  resources :questionnaires, only: [] do
    resources :answers  do
        put "pdf", :on => :member
    end
  end
end
