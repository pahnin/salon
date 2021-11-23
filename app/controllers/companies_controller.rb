class CompaniesController < ApplicationController
  def slots
    render json: FindAFreeChair.new(company: company).list
  end

  private

  def company
    Company.find params[:id]
  end
end
