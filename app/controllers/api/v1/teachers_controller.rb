module Api
  module V1
    class TeachersController < BaseController
      include SwaggerDocs::V1::Teachers

      def index
        @teachers = Teacher.ransack(params[:q]).result

        paginate json: @teachers, include: params[:include]
      end

      def show
        render json: teacher, include: params[:include]
      end

      def create
        @teacher = Teacher.new(teacher_attributes)

        if @teacher.save
          render json: @teacher, status: :created, location: [:api, :v1, @teacher]
        else
          respond_with_errors(@teacher)
        end
      end

      def update
        if teacher.update(teacher_attributes)
          render json: teacher, status: :ok, location: [:api, :v1, @teacher]
        else
          respond_with_errors(@teacher)
        end
      end

      def destroy
        teacher.destroy
        head :no_content
      end

      private
      def teacher
        @teacher ||= Teacher.find(params[:id])
      end

      def teacher_params
        params.require(:data).permit(:type, {
          attributes: [:name]
        })
      end

      def teacher_attributes
        teacher_params[:attributes] || {}
      end
    end
  end
end
