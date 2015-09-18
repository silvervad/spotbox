require 'test_helper'

class MapsTest < ActionDispatch::IntegrationTest
  
  def setup
    @country = countries(:egypt)
    @spot = spots(:somabay)
  end
  
end
