Rails.application.routes.draw do

  mount Quby::Engine => "/quby"

  get 'foo' => 'application#foo'

  if Rails.env.test? || Rails.env.development?
    mount Jasminerice::Engine => "/jasmine"
    get "/jasmine/:suite" => "jasminerice/spec#index"
  end
end
