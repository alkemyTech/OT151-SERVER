# frozen_string_literal: true

require 'swagger_helper'

describe 'Testimonials API V1 Docs', type: :request, swagger_doc: 'v1/swagger.yaml' do
  let(:authorization) { admin_header }

  path '/api/v1/testimonials' do
    post 'Create a testimonial' do
      tags :Testimonials
      consumes 'application/json'
      security [JWT: {}]
      parameter name: :authorization, in: :header, type: :apiKey
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          testimonial: {
            type: :object,
            properties: {
              name: { type: :string },
              content: { type: :text }
            },
            required: %w[name description]
          }
        },
        required: ['testimonial']
      }
      produces 'application/json'

      response '201', 'Testimonial created' do
        let(:params) { { testimonial: attributes_for(:testimonial) } }
        include_context 'with integration test'
      end

      response '422', 'Testimonial creation failed for parameter missing' do
        let(:params) { { name: '', content: '' } }
        include_context 'with integration test'
      end
    end
  end
end
