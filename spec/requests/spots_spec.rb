require 'rails_helper'

RSpec.describe "Spots", :type => :request do
  describe "GET /spots" do
    it "works! (now write some real specs)" do
      get spots_path
      expect(response.status).to be(200)
    end
  end
end
