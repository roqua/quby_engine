Rails.application.routes.draw do

  mount Quby::Engine => "/quby"

  get 'after_answer_complete' => 'application#after_answer_complete'

  if Rails.env.test? || Rails.env.development?
    mount Jasminerice::Engine => "/jasmine"
    get "/jasmine/:suite" => "jasminerice/spec#index"
  end
end
