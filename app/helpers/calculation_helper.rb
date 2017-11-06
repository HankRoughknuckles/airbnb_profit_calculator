module CalculationHelper
  def calculated_text(params)
    'You could make a monthly profit of ' \
    "#{params[:airbnb_rent].to_i - params[:long_term_rent].to_i} by " \
    'using AirBnb!'
  end
end
