require 'swagger_helper'

RSpec.describe 'api/members', type: :request do
    path '/api/v1/members' do
        get 'Indexes members' do
            tags 'Members'
            produces 'application/json'
            response '200', 'Members found' do
                let!(:member) { create_list(:member, 5) }
                  schema type: :object, properties: {
                    member: {
                      type: :object,
                      items: { '$ref' => '#/definitions/Member' }
                    }
                  }

                  include_context 'with integration test'
                run_test!
            end
        end
    end


end
