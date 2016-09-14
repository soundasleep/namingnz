require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  let(:user) { nil }
  render_views

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  context "when the user has not logged in" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to match(/Sign in with Google/)
        expect(response.body).to_not match(/Sign out/)
      end
    end
  end

  context "when the user has logged in" do
    let(:user) { User.create! }

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to match(/Sign out/)
        expect(response.body).to_not match(/Sign in with Google/)
      end
    end
  end

end
