module SwaggerDocs
  module V1
    module Students
      extend ActiveSupport::Concern

      included do
        swagger_controller :students, 'Students'

        swagger_api :index do
          summary 'Returns all students'
          notes 'It lists all existing students'
          param :form, :include, :string, :optional, 'include student associations (courses, teachers)'
          response :ok
        end

        swagger_api :show do
          summary 'Returns an student'
          notes 'It shows an existing student and its relationships'
          param :path, :id, :string, :required, "Student's id"
          param :form, :include, :string, :optional, 'include student associations (courses, teachers)'
          response :ok
        end

        swagger_api :create do
          summary 'Creates a student'
          notes 'It receives data student object and return its Location'
          param :form, 'data[type]', :string, :optional, 'Object type (students)'
          param :form, 'data[attributes[name]]', :string, :required, "Student's name"
          response :created
          response :unprocessable_entity
        end

        swagger_api :update do
          summary 'Updates a student'
          notes 'It receives data student object, updates it and return its Location'
          param :path, :id, :string, :required, "Student's id"
          param :form, 'data[type]', :string, :optional, 'Object type (students)'
          param :form, 'data[attributes[name]]', :string, :required, "Student's name"
          response :not_found
          response :unprocessable_entity
          response :ok
        end

        swagger_api :destroy do
          summary 'Destroys a student'
          notes 'It receives student id and destroys the related student'
          param :path, :id, :string, :required, "Student's id"
          response :not_found
          response :no_content
        end
      end
    end
  end
end
