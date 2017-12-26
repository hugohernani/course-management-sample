module Api
  module V1
    class CoursesController < BaseController
      include SwaggerDocs::V1::Courses

      def index
        @courses = Course.ransack(params[:q]).result

        paginate json: @courses, include: params[:include]
      end

      def show
        render json: course, include: params[:include]
      end

      def create
        @course = Course.new(course_attributes)

        if @course.save
          render json: @course, status: :created, location: [:api, :v1, @course]
        else
          respond_with_errors(@course)
        end
      end

      def update
        if course.update(course_attributes)
          render json: course, status: :ok, location: [:api, :v1, course]
        else
          respond_with_errors(course)
        end
      end

      def destroy
        course.destroy
        head :no_content
      end

      private
      def course
        @course ||= Course.find(params[:id])
      end

      def course_params
        params.require(:data).permit(:type, {
          attributes: [:title, :description]
        })
      end

      def course_attributes
        course_params[:attributes] || {}
      end
    end
  end
end
