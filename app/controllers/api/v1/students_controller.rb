module Api
  module V1
    class StudentsController < ApplicationController
      def index
        @students = Student.ransack(params[:q]).result

        paginate json: @students, include: params[:include]
      end

      def show
        render json: student, include: params[:include]
      end

      def create
        @student = Student.new(student_attributes)

        if @student.save
          render json: @student, status: :created, location: [:api, :v1, @student]
        else
          respond_with_errors(@student)
        end
      end

      def update
        if student.update(student_attributes)
          render json: student, status: :ok, location: [:api, :v1, student]
        else
          respond_with_errors(student)
        end
      end

      def destroy
        student.destroy
        head :no_content
      end

      private
      def student
        @student ||= Student.find(params[:id])
      end

      def student_params
        params.require(:data).permit(:type, {
          attributes: [:name, :email]
        })
      end

      def student_attributes
        student_params[:attributes] || {}
      end
    end
  end
end
