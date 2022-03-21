# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  let(:id) { create(:announcement).id }
  let(:header_valid) { auth_header(create(:user).id) }
  let(:header_invalid) { auth_header(-1) }
  let(:invalid_params) do
    { comment: { body: '@' } }
  end

  describe 'POST /create' do
    context 'with valid parameters and authenticate' do
      before do
        post "/api/v1/announcements/#{id}/comments",
             params: { comment: attributes_for(:comment) },
             headers: header_valid,
             as: :json
      end

      it 'creates a new Comment' do
        expect do
          post "/api/v1/announcements/#{id}/comments",
               params: { comment: attributes_for(:comment) },
               headers: header_valid,
               as: :json
        end.to change(Comment, :count).by(1)
      end

      it 'returns http 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with valid parameters and non-authenticate' do
      before do
        post "/api/v1/announcements/#{id}/comments",
             params: { comment: attributes_for(:comment) },
             headers: header_invalid,
             as: :json
      end

      it 'not creates a new Comment' do
        expect do
          post "/api/v1/announcements/#{id}/comments",
               params: { comment: attributes_for(:comment) },
               headers: header_invalid,
               as: :json
        end.to change(Comment, :count).by(0)
      end

      it 'returns http 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid parameters' do
      before do
        post "/api/v1/announcements/#{id}/comments",
             params: invalid_params,
             headers: header_valid,
             as: :json
      end

      it 'returns http 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
