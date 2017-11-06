require 'watir'

class AirbnbScraper
  AIRBNB_URL = 'https://www.airbnb.com/host/homes'.freeze
  AIRBNB_INCOME_CLASS = '_1hv8a61m'.freeze # Note: This is extremely brittle,
  # but didn't have time to implement it fully.  Would likely instead search by
  # regex for something that vaguely matches a currency in the text and extract
  # that

  def initialize(address)
    @rental_income = nil
    @address = address
  end

  def rental_income!
    @browser = Watir::Browser.new
    @browser.goto(AIRBNB_URL)

    set_airbnb_capacity_to(2)
    set_airbnb_location
    airbnb_rent_potential!
    airbnb_rent_period_in_months!
    @rental_income = @rental_income / @rent_period_in_months

  rescue
    @rental_income = nil
  ensure
    @browser.close
    return @rental_income
  end

  def set_airbnb_capacity_to(capacity)
    @browser.select(:name, 'capacity').select(capacity.to_s)
  end

  def set_airbnb_location
    location_input = @browser.text_field(:name, 'location')
    sleep(1) # wait for the autocomplete in the input to clear
    location_input.set(@address)

    # select the first entry from the autocomplete
    @browser.wait_until(timeout: 5) do
      @browser.ul(css: 'ul[role=listbox]').present?
    end
    location_input.send_keys(:down)
    location_input.send_keys(:enter)
  end

  def airbnb_rent_potential!
    @rental_income = fetch_rental_income.gsub(/\D/, '').to_f # remove non-digits
  end

  def airbnb_rent_period_in_months!
    from_airbnb = @browser.span(text: /(weekly|monthly|yearly)/).text
    period_string = from_airbnb.match(/(weekly|monthly|yearly)/)[0]
    case period_string
    when 'weekly'
      @rent_period_in_months = 0.25
    when 'monthly'
      @rent_period_in_months = 1.00
    when 'yearly'
      @rent_period_in_months = 12.00
    end
  end

  def fetch_rental_income
    @browser.wait_until(timeout: 5) do
      @browser.div(:class, AIRBNB_INCOME_CLASS).present?
    end
    sleep 2 # wait for extraneous ajax to complete, since it seems the page is
    # using React, would probably be better to use browser.wait_until { } and
    # check that all ajax connections are closed instead of hardcoding a value

    @browser.div(:class, AIRBNB_INCOME_CLASS).text
  end
end
