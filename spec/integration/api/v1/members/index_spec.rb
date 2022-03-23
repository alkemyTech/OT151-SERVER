require 'swagger_helper'

# RSpec.describe 'api/members', type: :request do
describe 'Members API V1 Docs', type: :request, swagger_doc: 'v1/swagger.yaml' do
  
  path '/api/v1/members' do
    get 'Indexes members' do
      tags 'Members'
      produces 'application/json'
      response '200', 'Members found' do
        # before { create_list(:member, 5) }

        schema type: :object, properties: {
          member: {
            type: :array,
            items: { '$ref' => '#/definitions/Member' }
          }
        }

        let!(:members) { create_list(:member, 5) }

        include_context 'with integration test'
        # run_test!
      end
    end
  end
end
