require "addressable/uri"

class CalculationNewPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  PAGE_URL = '/'.freeze
  TITLE = 'AirBnB Profit Calculator'.freeze
  LONG_TERM_RENT_DISPLAY = '.long-term-rent-display'.freeze
  AIRBNB_RENT_DISPLAY = '.airbnb-rent-display'.freeze
  CALCULATED_DISPLAY = '.total'.freeze

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

  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% form inputs
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  def has_edit_user_link?
    has_css? @edit_user_link
  end

  def click_edit_user_link
    find(@edit_user_link).click
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
