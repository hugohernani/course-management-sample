require 'api_version_constraint'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, contraints: { subdomain: 'api' }, path: '/' do
    namespace :v1, path: '', constraints: ApiVersionConstraint.new(version: 1) do
      resources :teachers
      resources :students
    end
  end
end
