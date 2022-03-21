require 'swagger_helper'

RSpec.describe 'api/members', type: :request, swagger_doc: 'v1/swagger.yaml' do
  let!(:member) { create(:member) }
  let(:Authorization) { admin_header }

  path '/api/v1/members' do
    post 'Creates members' do
      tags 'Members'
      consumes 'application/json'
      security [JWT: {}]
      parameter name: :Authorization, in: :header, type: :apiKey
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          member: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :text },
              facebook_url: { type: :string },
              linkedin_url: { type: :string },
              instagram_url: { type: :string },
              image: { type: :string }
            },
            required: %w[name description]
          }
        },
        required: ['member']

      }
      produces 'application/json'

      response '201', 'Member created' do
        let(:params) do
          { member: {
            name: Faker::Name.name,
            description: Faker::Quote.famous_last_words,
            facebook_url: Faker::Internet.url(host: 'facebook.com'),
            instagram_url: Faker::Internet.url(host: 'instagram.com'),
            linkedin_url: Faker::Internet.url(host: 'linkedin.com', path: '/in'),
            image: image_path
          } }
        end
        include_context 'with integration test'
      end
      response '422', 'Member creation failed for parameter missing' do
        let(:params) { { name: '', description: '' } }
        include_context 'with integration test'
      end
    end
  end
end
