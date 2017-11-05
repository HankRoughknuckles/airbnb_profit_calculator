class CalculationController < ApplicationController
  def new
  end

  def create
    output_params = {
      # TODO: consider renaming these to keep them consistent with what comes in
      # on the form
      airbnb_rent: AirbnbScraper.new(params[:address]).rental_income,
      long_term_rent: params[:monthly_income]
    }
  end
end
