# frozen_string_literal: true

require 'swagger_helper'

describe 'Announcements API V1 Docs', type: :request, swagger_doc: 'v1/swagger.yaml' do
  let(:id) { create(:announcement).id }
  let(:Authorization) { admin_header }

  path '/api/v1/announcements/{id}' do
    get 'Retrieves a announcement.' do
      tags :Announcements
      description 'a announcement'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'Announcement found' do
        include_context 'with integration test'
      end

      response '404', 'Announcement not found' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end
  end
end
