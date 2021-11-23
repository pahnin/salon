class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { success: false }, status: 422
  end
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { success: false }, status: 404
  end

end
