require 'test_helper'

class CountryLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @country = countries(:egypt)
    @user = users(:pupkin)
  end
  
  # Should display New Spot for logged users
  test "show new spot for logged users" do
    post login_path, session: { email: @user.email, password: 'password' }
    get country_path ( @country )
    assert_select "a[href=?]", new_country_spot_path(@country), count: 1
  end
  
  # Should NOT display New Spot for logged users
  test "don't show new spot for not logged users" do
    get country_path ( @country )
    assert_select "a[href=?]", new_country_spot_path(@country), count: 0
  end
  
  # Title should contain country name
  test "title should contain country name" do
    get country_path ( @country )
    assert_select 'title', /#{@country.name}/
  end
  
  # Country page should contain country name
  test "country page should contain country name" do
    get country_path ( @country )
    assert_select "body", /#{@country.name}/, count: 1
  end
  
  # Country page should contain list of spots with links
  test "country page should contain list of spots" do
    spot1 = spots(:somabay)
    spot2 = spots(:elgouna)
    spot3 = spots(:marsa)
    get country_path ( @country )
    assert_select "a[href=?]", country_spot_path(@country, spot1)
    assert_select "a[href=?]", country_spot_path(@country, spot2)
    assert_select "a[href=?]", country_spot_path(@country, spot3)
  end
  
  # Country page should show proper navigation
  test "should show proper navigation" do
    get country_path ( @country )
    assert_select "div#button-up", title: "Up"
    assert_select "div#button-home", title: "Home"
    assert_select "div#button-center-map", title: "Center"
    assert_select "div#button-toggle-info", title: "Close Info"
    assert_select "div#button-toggle-nav", title: "Close Navigation"
  end
  
  # Country page should have map and infobar divs
  test "should have photos and map divs" do
    get country_path ( @country )
    assert_select "div#country-map-canvas"
    assert_select "div#info-bar"
  end
  

end
