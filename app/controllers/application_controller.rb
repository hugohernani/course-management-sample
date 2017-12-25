class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error

  def respond_with_errors(object)
    render json: {errors: ErrorSerializer.serialize(object)}, status: :unprocessable_entity
  end

  private
  def record_not_found_error
    render json: {errors: 'Resource not found'}, status: :not_found
  end
end
