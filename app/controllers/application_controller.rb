class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveModel::StrictValidationFailed, with: :create_error

  def record_not_found
    render json: { error: "No record found for given ID" }.to_json, status: :not_found
  end

  def create_error(exception)
    render json: { error: exception.message }.to_json, status: 404
  end
end
