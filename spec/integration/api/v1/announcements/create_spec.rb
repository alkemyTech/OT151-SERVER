# frozen_string_literal: true

require 'swagger_helper'

describe 'Announcements API V1 Docs', type: :request, swagger_doc: 'v1/swagger.yaml' do
  let(:id) { create(:announcement).id }
  let(:Authorization) { admin_header }

  path '/api/v1/announcements' do
    post 'Create a announcement' do
      tags :Announcements
      consumes 'application/json'
      security [JWT: {}]
      parameter name: :Authorization, in: :header, type: :apiKey
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          announcement: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :text },
              announcement_type: { type: :string },
              image: { type: :string },
              category_id: { type: :integer }

            },
            required: %w[name description category_id]
          }
        },
        required: ['announcement']
      }
      produces 'application/json'

      response '201', 'Announcement created' do
        let(:category) { create(:category) }
        let(:params) do
          { announcement: {
            name: Faker::TvShows::BreakingBad.character,
            content: Faker::Books::Lovecraft.sentence,
            announcement_type: Faker::Lorem.word,
            image: image_path,
            category_id: category.id
          } }
        end
        include_context 'with integration test'
      end

      response '422', 'Announcement creation failed for parameter missing' do
        let(:params) { { name: '', description: '' } }
        include_context 'with integration test'
      end
    end
  end
end
