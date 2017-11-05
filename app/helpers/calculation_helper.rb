module CalculationHelper
  def calculated_text(params)
    'You could make ' \
    "#{params[:airbnb_rent].to_i - params[:long_term_rent].to_i} profit by " \
    'using AirBnb!'
  end
end
