# frozen_string_literal: true

require 'swagger_helper'
describe 'Testimonial API V1 Docs', type: :request, swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/testimonials' do
    get 'Fetch testimonials' do
      tags :Testimonial
      produces 'application/json'
      response '200', 'Testimonial found' do
        before { create_list(:testimonial, 10) }

        schema type: :object, properties: {
          Testimonial: {
            type: :object,
            items: { '$ref' => '#/definitions/Testimonial' }
          }
        }
        include_context 'with integration test'
      end
    end
  end
  
  path "/api/v1/testimonials?page={page}" do
    get 'Fetch testimonials' do
      tags :Testimonial
      produces 'application/json'
      response '200', 'Testimonial found' do
        before { create_list(:testimonial, 33) }

        parameter name: :page, in: :path, type: :string
        schema type: :object, properties: {
          Testimonial: {
            type: :object,
            items: { '$ref' => '#/definitions/Testimonial' }
          }
        }
        let(:page) { 4 }
        include_context 'with integration test'
      end
    end
  end
end
