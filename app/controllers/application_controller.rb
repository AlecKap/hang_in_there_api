class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: ErrorSerializer.serializer("Record not found", "404"), status: 404
  end
end
