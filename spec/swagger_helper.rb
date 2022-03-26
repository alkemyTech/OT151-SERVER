# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ],
      definitions: {
        Slide: {
          type: 'object',
          properties: {
            id: { type: :integer, example: '1' },
            order: { type: :integer, example: '1' },
            image: { type: :string, example: '/img/file.jpg' }
          }
        },
        Announcement: {
          type: 'object',
          properties: {
            id: { type: :integer, example: '1' },
            name: { type: :string, example: 'name' },
            content: { type: :string, example: 'content' },
            announcement_type: { type: :string, example: 'announcement_type' },
            category_id: { type: :integer, example: '1' }
          }
        },
        Testimonial: {
          type: 'object',
          properties: {
            id: { type: :integer, example: '1' },
            name: { type: :string, example: 'name' },
            description: { type: :string, example: 'description' },
            announcement_type: { type: :string, example: 'announcement_type' },
            category_id: { type: :integer, example: '1' }
          }
        },
        Member: {
          type: 'object',
          properties: {
            id: { type: :integer, example: '100' },
            name: { type: :string, example: 'test' },
            description: { type: :string, example: 'test' },
            image: { type: :string, example: '/img/file.jpg' },
            content: { type: :string, example: 'description' }
          }
        },
        securityDefinitions: {
          JWT: {
            description: 'Json Web Token',
            name: 'Authorization',
            in: :header,
            type: :apiKey
          },
          properties: {
            token: { type: :string, example: JsonWebToken.encode({ user_id: 0 }).to_s }
          }
        }
      }
    }
  }
  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
