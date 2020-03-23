module LoginHelper
  def is_logged_in?
    !session[:employee_id].nil?
  end
end

RSpec.configure do |config|
  config.include LoginHelper
end
