class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { error: "No record found for given ID" }.to_json, status: :not_found
  end
end
