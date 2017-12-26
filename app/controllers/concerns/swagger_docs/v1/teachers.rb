module SwaggerDocs
  module V1
    module Teachers
      extend ActiveSupport::Concern

      included do
        swagger_controller :teachers, 'Teachers'

        swagger_api :index do
          summary 'Returns all teachers'
          notes 'It lists all existing teachers'
          param :form, :include, :string, :optional, 'include teachers associations (students, teachers)'
          response :ok
        end

        swagger_api :show do
          summary 'Returns an teacher'
          notes 'It shows an existing teacher and its relationships'
          param :path, :id, :string, :required, "Teacher's id"
          param :form, :include, :string, :optional, 'include teachers associations (students, teachers)'
          response :ok
        end

        swagger_api :create do
          summary 'Creates a teacher'
          notes 'It receives data teacher object and return its Location'
          param :form, 'data[type]', :string, :optional, 'Object type (teachers)'
          param :form, 'data[attributes[name]]', :string, :required, "Teacher's name"
          response :created
          response :unprocessable_entity
        end

        swagger_api :update do
          summary 'Updates a teacher'
          notes 'It receives data teacher object, updates it and return its Location'
          param :path, :id, :string, :required, "Teacher's id"
          param :form, 'data[type]', :string, :optional, 'Object type (teachers)'
          param :form, 'data[attributes[name]]', :string, :required, "Teacher's name"
          response :not_found
          response :unprocessable_entity
          response :ok
        end

        swagger_api :destroy do
          summary 'Destroys a teacher'
          notes 'It receives teacher id and destroys the related student'
          param :path, :id, :string, :required, "Teacher's id"
          response :not_found
          response :no_content
        end
      end
    end
  end
end
