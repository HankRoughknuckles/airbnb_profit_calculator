require "addressable/uri"

class CalculationNewPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  PAGE_URL = '/'.freeze
  TITLE = 'AirBnB Profit Calculator'.freeze
  LONG_TERM_RENT_DISPLAY = '.long-term-rent-display'.freeze
  AIRBNB_RENT_DISPLAY = '.airbnb-rent-display'.freeze
  CALCULATED_DISPLAY = '.total'.freeze
  RENTAL_INCOME_INPUT = '#long_term_rent'.freeze
  ADDRESS_INPUT = '#address'.freeze
  SUBMIT_BUTTON = 'input[type=submit]'.freeze

  def initialize
  end

  def visit_page
    visit PAGE_URL
  end

  def visit_page_with_params(params)
    uri = Addressable::URI.new
    uri.query_values = params
    visit "#{PAGE_URL}?#{uri.query}"
  end

  def has_proper_title?
    has_title? TITLE
  end

  def airbnb_rent_param
    CGI::parse(
      URI.parse(current_url).query
    )['airbnb_rent'][0]
  end


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% errors
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  def has_airbnb_flash_error?
    has_css?('.alert', text: CalculationController::AIRBNB_ERROR)
  end

  def has_long_term_rent_flash_error?
    has_css?('.alert', text: CalculationController::LONG_TERM_RENT_ERROR)
  end

  def has_address_flash_error?
    has_css?('.alert', text: CalculationController::ADDRESS_ERROR)
  end

  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% form inputs
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  def set_long_term_rent_to(amount)
    find(RENTAL_INCOME_INPUT).set(amount)
  end

  def set_address_to(address)
    find(ADDRESS_INPUT).set(address)
  end

  def click_submit
    find(SUBMIT_BUTTON).click
  end


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% param display outputs
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  def has_long_term_rent_display?
    has_css?(LONG_TERM_RENT_DISPLAY)
  end

  def has_airbnb_rent_display?
    has_css?(AIRBNB_RENT_DISPLAY)
  end

  def has_calculated_total?
    has_css?(CALCULATED_DISPLAY)
  end

  def has_long_term_rent_display_of?(rent)
    has_css?(LONG_TERM_RENT_DISPLAY, text: "Your long term rent: $#{rent}")
  end

  def has_airbnb_rent_display_of?(rent)
    has_css?(AIRBNB_RENT_DISPLAY, text: "Your AirBnb rent potential: $#{rent}")
  end

  def has_calculated_total_of?(total)
    has_css?(CALCULATED_DISPLAY,
             text: "You could make #{total} profit by using AirBnb!")
  end
end
