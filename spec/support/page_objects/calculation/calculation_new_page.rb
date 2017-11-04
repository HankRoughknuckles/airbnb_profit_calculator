class CalculationNewPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  PAGE_URL = '/'.freeze
  TITLE = 'AirBnB Profit Calculator'.freeze

  def initialize
  end

  def visit_page
    visit PAGE_URL
  end

  def has_proper_title?
    has_title? TITLE
  end
end
