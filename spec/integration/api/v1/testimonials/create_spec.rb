# frozen_string_literal: true

require 'swagger_helper'

describe 'Testimonial API V1 Docs', type: :request, swagger_doc: 'v1/swagger.yaml' do
  let(:Authorization) { admin_header }

  path '/api/v1/testimonials' do
    post 'Create a testimonial' do
      tags :Testimonial
      consumes 'application/json'
      security [JWT: {}]
      parameter name: :Authorization, in: :header, type: :apiKey
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          testimonial: {
            type: :object,
            properties: { name: { type: :string }, content: { type: :string } },
            required: %w[name content]
          }
        },
        required: ['testimonial']
      }
      produces 'application/json'

      response '201', 'Testimonial created' do
        let(:params) do
          { testimonial: {
            name: Faker::TvShows::BreakingBad.character,
            content: Faker::Books::Lovecraft.sentence
          } }
        end
        include_context 'with integration test'
      end

      response '422', 'Testimonial creation failed for parameter missing' do
        let(:params) { { name: '', content: '' } }
        include_context 'with integration test'
      end
    end
  end
end
