require "rails_helper"

RSpec.describe "Announcements", :type => :request do
   
  
  let(:announcement) { create :announcement, :with_image}
  describe 'POST /create' do
    it "creates a Announcement and redirects to the Announcement's page" do
    attrs = attributes_for(:announcement)
        post "/api/v1/announcements", :params => { :announcement => attrs }, as: :json
        expect(response).to redirect_to(:announcement)
        follow_redirect!
    expect(response).to render_template(:serialize_announcement)
    expect(response.body).to include("Announcement was successfully created.")
  end
end
def auth_header(user_id)
  { 'Authorization' => JsonWebToken.encode({ user_id: user_id }) }
end
end