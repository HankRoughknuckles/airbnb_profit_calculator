require 'rails_helper'

describe 'The new calculation page' do
  let(:page) { CalculationNewPage.new }
  before { page.visit_page }

  it { expect(page).to have_proper_title }

  describe 'the calculation process' do
    it 'should work'
  end

  describe 'displaying the results of the calculation' do
    let(:params) do
      {
        long_term_rent: long_term_rent,
        airbnb_rent: airbnb_rent
      }
    end
    let(:long_term_rent) { 200 }
    let(:airbnb_rent) { 200 }

    before { page.visit_page_with_params(params) }

    context 'when there are no params' do
      let(:params) { nil }
      it { expect(page).not_to have_long_term_rent_display }
      it { expect(page).not_to have_airbnb_rent_display }
      it { expect(page).not_to have_calculated_total }
    end

    context 'when only long term rent param is present' do
      let(:airbnb_rent) { nil }
      it { expect(page).to have_long_term_rent_display_of(long_term_rent) }
      it { expect(page).not_to have_airbnb_rent_display }
      it { expect(page).not_to have_calculated_total }
    end

    context 'when only airbnb rent param is present' do
      let(:long_term_rent) { nil }
      it { expect(page).not_to have_long_term_rent_display }
      it { expect(page).to have_airbnb_rent_display_of(long_term_rent) }
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
