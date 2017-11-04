require 'rails_helper'

describe 'The new calculation page' do
  let(:page) { CalculationNewPage.new }
  before { page.visit_page }

  it { expect(page).to have_proper_title }

  describe 'the calculation process' do
    it 'should work'
  end
end
