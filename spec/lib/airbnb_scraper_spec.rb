require "airbnb_scraper"

describe AirbnbScraper do
  let(:airbnb_rent) { 1000 }

  describe '#rental_income!' do
    context 'when there is a problem scraping from AirBnB' do
      before do
        allow_any_instance_of(AirbnbScraper)
          .to receive(:fetch_rental_income)
          .and_raise(Watir::Wait::TimeoutError)
      end

      it 'should return nil' do
        expect(AirbnbScraper.new('Nowhere Ville').rental_income!).to eq nil
      end
    end
  end
end
