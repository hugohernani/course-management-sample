module SwaggerDocs
  module V1
    module Courses
      extend ActiveSupport::Concern

      included do
        swagger_controller :courses, 'Courses'

        swagger_api :index do
          summary 'Returns all courses'
          notes 'It lists all existing courses'
          param :form, :include, :string, :optional, 'include course associations (students, teachers)'
          response :ok
        end

        swagger_api :show do
          summary 'Returns a courses'
          notes 'It shows an existing course and its relationships'
          param :path, :id, :string, :required, "Course's id"
          param :form, :include, :string, :optional, 'include course associations (students, teachers)'
          response :ok
        end

        swagger_api :create do
          summary 'Creates a course'
          notes 'It receives data course object and return its Location'
          param :form, 'data[type]', :string, :optional, 'Object type (courses)'
          param :form, 'data[attributes[title]]', :string, :required, "Course's title"
          param :form, 'data[attributes[description]]', :string, :required, "Course's description"
          response :created
          response :unprocessable_entity
        end

        swagger_api :update do
          summary 'Updates a course'
          notes 'It receives data course object, updates it and return its Location'
          param :path, :id, :string, :required, "Course's id"
          param :form, 'data[type]', :string, :optional, 'Object type (courses)'
          param :form, 'data[attributes[title]]', :string, :required, "Course's title"
          param :form, 'data[attributes[description]]', :string, :required, "Course's description"
          response :not_found
          response :unprocessable_entity
          response :ok
        end

        swagger_api :destroy do
          summary 'Destroys a course'
          notes 'It receives course id and destroys the related course'
          param :path, :id, :string, :required, "Course's id"
          response :not_found
          response :no_content
        end
      end
    end
  end
end
