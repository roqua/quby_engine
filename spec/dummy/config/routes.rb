Rails.application.routes.draw do

  mount Quby::Engine => "/quby"

  if Rails.env.test? || Rails.env.development?
    mount Jasminerice::Engine => "/jasmine"
    get "/jasmine/:suite" => "jasminerice/spec#index"
  end
end
