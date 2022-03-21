# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Organizations', type: :request do
  let(:header_for_admin) { admin_header }
  let(:header_for_user) { auth_header(create(:user).id) }
  let(:invalid_params) do
    { organization: { email: '@email',
                      name: 'nameveryloooooooooooooooooooooooooooooooooooong',
                      welcome_text: ' ',
                      address: 1,
                      phone: '1234567890',
                      about_us_text: '' } }
  end

  describe 'POST /create' do
    context 'with valid parameters and admin user' do
      before do
        post '/api/v1/organization/public',
             headers: header_for_admin,
             params: { organization: attributes_for(:organization) },
             as: :json
      end

      it 'creates a new Organization' do
        expect do
          post '/api/v1/organization/public',
               headers: header_for_admin,
               params: { organization: attributes_for(:organization) },
               as: :json
        end.to change(Organization, :count).by(1)
      end

      it 'returns http 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with valid parameters and non-admin user' do
      before do
        post '/api/v1/organization/public',
             headers: header_for_user,
             params: { organization: attributes_for(:organization) },
             as: :json
      end

      it 'returns http 403' do
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/organization/public',
             headers: header_for_admin,
             params: invalid_params,
             as: :json
      end

      it 'returns http 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
