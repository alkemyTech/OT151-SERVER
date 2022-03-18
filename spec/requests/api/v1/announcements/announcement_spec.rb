# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Announcements', type: :request do
  let!(:announcement) { create :announcement }
  let(:announcement_id) { announcement.id }
  let!(:update_announcement) do
    {
      name: 'update name',
      content: 'update content'
    }
  end

  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:admin_id) { create(:user, role_id: create(:role, name: 'admin').id).id }

  describe 'POST /create' do
    context 'with valid params and valid auth' do
      it 'returns created status' do
        attrs = attributes_for(:announcement).merge(image: Rails.root.join('spec/factories_files/test.png'))
        post '/api/v1/announcements', params: { announcement: attrs },
                                      headers: auth_header(admin_id), as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        post '/api/v1/announcements', params: { announcement:
        { name: 'valid name', content: '', category_id: '' } },
                                      headers: auth_header(admin_id), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid auth' do
      it 'returns unauthorized status' do
        attrs = attributes_for(:announcement).merge(image: Rails.root.join('spec/factories_files/test.png'))
        post '/api/v1/announcements', params: { announcement: attrs }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid auth but invalid role' do
      it 'returns forbidden status' do
        attrs = attributes_for(:announcement).merge(image: Rails.root.join('spec/factories_files/test.png'))
        post '/api/v1/announcements', params: { announcement: attrs },
                                      headers: auth_header(user_id), as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET /show' do
    context 'with valid id' do
      it 'returns an OK status' do
        get "/api/v1/announcements/#{announcement_id}",
            as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid params and auth' do
      it 'returns an OK status' do
        put "/api/v1/announcements/#{announcement_id}",
            params: { announcement: update_announcement },
            headers: auth_header(admin_id), as: :json
      end
    end

    context 'with unvalid params' do
      it 'returns unprocessable entity status' do
        put "/api/v1/announcements/#{announcement_id}",
            params: { announcement: { name: '' } },
            headers: auth_header(user_id), as: :json
      end
    end

    context 'with unvalid auth' do
      it 'returns unauthorized status' do
        put "/api/v1/announcements/#{announcement_id}",
            params: { announcement: update_announcement }
      end
    end
  end
end
