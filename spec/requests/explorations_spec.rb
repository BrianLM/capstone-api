require 'rails_helper'

RSpec.describe "Explorations", type: :request do
  describe "GET /explorations" do
    it "works! (now write some real specs)" do
      get explorations_path
      expect(response).to have_http_status(200)
    end
  end
end
