# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user_id) { create(:user).id }
  let(:header_for_admin) { admin_header }
  let(:header_for_owner) { auth_header(user_id) }
  let(:header_for_not_owner) { auth_header(create(:user).id) }

  describe 'DELETE /destroy' do
    context 'when user is admin' do
      before do
        delete "/api/v1/users/#{user_id}",
               headers: header_for_admin,
               as: :json
      end

      it 'returns http 402' do
        expect(response).to have_http_status(:no_content)
      end

      it 'destroys the requested user' do
        expect(User.find(user_id).discarded?).to be(true)
      end
    end

    context 'when the user is the owner' do
      before do
        delete "/api/v1/users/#{user_id}",
               headers: header_for_owner,
               as: :json
      end

      it 'returns http 402' do
        expect(response).to have_http_status(:no_content)
      end

      it 'destroys the requested user' do
        expect(User.find(user_id).discarded?).to be(true)
      end
    end

    context 'when the user is not the owner' do
      before do
        delete "/api/v1/users/#{user_id}",
               headers: header_for_not_owner,
               as: :json
      end

      it 'returns http 403' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns error message' do
        expect(body_json['errors']).to eq('Unauthorized access')
      end
    end
  end
end
