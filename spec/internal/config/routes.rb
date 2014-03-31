Rails.application.routes.draw do
  mount Quby::Engine => "/quby"
  get 'after_answer_complete' => 'testsuite#after_answer_complete'
end
