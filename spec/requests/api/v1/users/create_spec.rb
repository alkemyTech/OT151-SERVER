# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:invalid_params) do
    { user: { email: '@email.com',
              password: 'short',
              first_name: ' ',
              last_name: '' } }
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post '/api/v1/auth/register', params: { user: attributes_for(:user) }, as: :json
      end

      it 'creates a new User' do
        expect do
          post '/api/v1/auth/register',
               params: { user: attributes_for(:user) },
               as: :json
        end.to change(User, :count).by(1)
      end

      it 'returns http 201' do
        expect(response).to have_http_status(:created)
      end

      it 'created with default role' do
        expect(attributes_json['role_id']).to eql(Role.find_by(name: 'user').id)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/auth/register', params: invalid_params, as: :json
      end

      it 'returns http 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
