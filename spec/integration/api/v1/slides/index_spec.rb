# frozen_string_literal: true

require 'swagger_helper'
describe 'Slides API V1 Docs', type: :request, swagger_doc: 'v1/swagger.yaml' do
  let(:Authorization) { admin_header }

  path '/api/v1/slides' do
    get 'Fetch slides' do
      tags :Slides
      produces 'application/json'
      security [JWT: {}]
      parameter name: :Authorization, in: :header, type: :apiKey

      response '200', 'Slides found' do
        before { create_list(:slide, 5) }

        schema type: :object, properties: {
          slide: {
            type: :object,
            items: { '$ref' => '#/definitions/Slide' }
          }
        }
        include_context 'with integration test'
      end
    end
  end
end
