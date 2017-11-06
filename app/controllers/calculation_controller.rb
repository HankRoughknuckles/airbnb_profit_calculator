require 'airbnb_scraper'

class CalculationController < ApplicationController
  before_action :validate_inputs, only: :create
  before_action :scrape_airbnb, only: :create

  AIRBNB_ERROR = 'Error contacting AirBnB. Please try again'.freeze
  LONG_TERM_RENT_ERROR = 'Please enter a long term rent amount'.freeze
  ADDRESS_ERROR = 'Please enter an address'.freeze

  def new
  end

  def create
    output_params = {
      airbnb_rent: @airbnb_rent,
      long_term_rent: params[:long_term_rent],
    }
    redirect_to({ action: :new }.merge(output_params))
  end

  private

  def scrape_airbnb
    @airbnb_rent = AirbnbScraper.new(params[:address]).rental_income!
    if @airbnb_rent.nil?
      flash[:alert] = AIRBNB_ERROR
      return redirect_to action: :new
    end
  end

  def validate_inputs
    if params[:long_term_rent].blank?
      flash[:alert] = LONG_TERM_RENT_ERROR
    elsif params[:address].blank?
      flash[:alert] = ADDRESS_ERROR
    end

    return redirect_to(action: :new) if flash[:alert].present?
  end
end
