# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:header_for_user) { auth_header(users.first.id) }
  let(:header_for_admin) { admin_header }

  describe 'GET /index' do
    context 'when user is admin' do
      before do
        get '/api/v1/users', headers: header_for_admin, as: :json
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all users' do
        # admin_header create a user with 'admin' role
        expect(body_json.size).to eq(User.all.count)
      end
    end

    context 'when user is not admin' do
      before do
        get '/api/v1/users', headers: header_for_user, as: :json
      end

      it 'returns status code 403' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns error message' do
        expect(body_json['errors']).to eq('Unauthorized access')
      end
    end

    context 'when not authenticated' do
      before do
        get '/api/v1/users', as: :json
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns error message' do
        expect(body_json['errors']).to eq('Nil JSON web token')
      end
    end
  end
end
