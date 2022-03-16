# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user_id) { create(:user).id }
  let(:header_for_admin) { admin_header }
  let(:header_for_owner) { auth_header(user_id) }
  let(:header_for_not_owner) { auth_header(create(:user).id) }
  let(:admin_id) { create(:user, role_id: create(:role, name: 'admin').id).id }

  let(:valid_params) do
    { email: 'update@email.com',
      password: 'updatepassword',
      first_name: 'new_first_name',
      last_name: 'new_last_name' }
  end
  let(:invalid_params) do
    { email: '@email.com',
      password: 'short',
      first_name: ' ',
      last_name: '' }
  end

  describe 'PUT /update' do
    context 'when user is admin whit valid params' do
      before do
        put "/api/v1/users/#{user_id}",
            params: { user: valid_params },
            headers: header_for_admin,
            as: :json
      end

      it 'returns http 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the requested user' do
        expect(attributes_json['email']).to eq('update@email.com')
        expect(attributes_json['first_name']).to eq('new_first_name')
        expect(attributes_json['last_name']).to eq('new_last_name')
      end
    end

    context 'when user is admin whit invalid params' do
      before do
        put "/api/v1/users/#{user_id}",
            params: { user: invalid_params },
            headers: header_for_admin,
            as: :json
      end

      it 'returns http 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is owner whit valid params' do
      before do
        put "/api/v1/users/#{user_id}",
            params: { user: valid_params },
            headers: header_for_owner,
            as: :json
      end

      it 'returns http 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the requested user' do
        expect(attributes_json['email']).to eq('update@email.com')
        expect(attributes_json['first_name']).to eq('new_first_name')
        expect(attributes_json['last_name']).to eq('new_last_name')
      end
    end

    context 'when user is owner whit invalid params' do
      before do
        put "/api/v1/users/#{user_id}",
            params: { user: invalid_params },
            headers: header_for_owner,
            as: :json
      end

      it 'returns http 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not owner' do
      before do
        put "/api/v1/users/#{user_id}",
            params: { user: valid_params },
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
