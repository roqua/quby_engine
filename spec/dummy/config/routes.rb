Rails.application.routes.draw do

  mount Quby::Engine => "/quby"

  get 'after_answer_complete' => 'application#after_answer_complete'
end
