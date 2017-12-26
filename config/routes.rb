require 'api_version_constraint'

Rails.application.routes.draw do
  mount SwaggerUiEngine::Engine, at: "/documentation"

  namespace :api, defaults: { format: :json }, contraints: { subdomain: 'api' }, path: '/' do
    namespace :v1, path: '', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :teachers
      resources :students
      resources :courses do
        collection do
          post 'assign_entity', to: 'courses/assign_entity#create'
          delete 'unassign_entity', to: 'courses/assign_entity#destroy'
        end
      end
    end
  end
end
