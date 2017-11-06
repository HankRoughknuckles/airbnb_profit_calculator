require 'rails_helper'
require 'airbnb_scraper'

describe 'The new calculation page' do
  let(:page) { CalculationNewPage.new }
  before { page.visit_page }

  it { expect(page).to have_proper_title }

  describe 'visitng the page with no params' do
    before { page.visit_page }

    context 'should not display any outputs, only form inputs' do
      it { expect(page).not_to have_long_term_rent_display }
      it { expect(page).not_to have_airbnb_rent_display }
      it { expect(page).not_to have_calculated_total }
    end
  end

  describe 'the calculation process' do
    let(:long_term_rent) { 200 }
    let(:address) { 'Austin, TX' }
    let(:airbnb_rent) { 200 }

    before do
      allow_any_instance_of(AirbnbScraper)
        .to receive(:rental_income!)
        .and_return(airbnb_rent)

      page.visit_page
      page.set_long_term_rent_to long_term_rent
      page.set_address_to address
      page.click_submit
    end

    context 'when the airbnb rent is higher than the long term rent' do
      let(:long_term_rent) { 2000 }
      let(:airbnb_rent) { 4000 }

      it { expect(page).to have_long_term_rent_display_of(long_term_rent) }
      it { expect(page).to have_airbnb_rent_display_of(airbnb_rent) }

      it 'should display the result as positive' do
        expect(page).to have_calculated_total_of(airbnb_rent - long_term_rent)
      end
    end

    context 'when the airbnb rent is lower than the long term rent' do
      let(:long_term_rent) { 10_000 }
      let(:airbnb_rent) { 4000 }

      it { expect(page).to have_long_term_rent_display_of(long_term_rent) }
      it { expect(page).to have_airbnb_rent_display_of(airbnb_rent) }

      it 'should display the result as negative' do
        expect(page).to have_calculated_total_of(airbnb_rent - long_term_rent)
      end
    end

    context 'when there is a problem scraping from AirBnB' do
      let(:airbnb_rent) { nil }
      it { expect(page).to have_airbnb_flash_error }
    end

    context 'when the user does not enter a long term rent' do
      let(:long_term_rent) { nil }
      it { expect(page).to have_long_term_rent_flash_error }
      it { expect(page).not_to have_long_term_rent_display }
      it { expect(page).not_to have_airbnb_rent_display_of(long_term_rent) }
      it { expect(page).not_to have_calculated_total }
    end

    context 'when the user does not enter an address' do
      let(:address) { nil }

      it { expect(page).to have_address_flash_error }
      it { expect(page).not_to have_long_term_rent_display }
      it { expect(page).not_to have_airbnb_rent_display_of(long_term_rent) }
      it { expect(page).not_to have_calculated_total }
    end

    context 'when long term and airbnb rent params present' do
      let(:long_term_rent) { 300 }
      let(:airbnb_rent) { 275 }
      it { expect(page).to have_long_term_rent_display_of(long_term_rent) }
      it { expect(page).to have_airbnb_rent_display_of(airbnb_rent) }

      it 'should show the right total' do
        expect(page).to have_calculated_total_of(airbnb_rent - long_term_rent)
      end
    end
  end
end
