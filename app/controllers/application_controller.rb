class ApplicationController < ActionController::API
  def respond_with_errors(object)
    render json: {errors: ErrorSerializer.serialize(object)}, status: :unprocessable_entity
  end
end
