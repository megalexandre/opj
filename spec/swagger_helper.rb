require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.to_s + '/swagger'

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'OPJ API',
        version: 'v1'
      },
      servers: [
        { url: 'http://localhost:3000', description: 'Desenvolvimento' }
      ],
      security: [{ bearerAuth: [] }],
      components: {
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'JWT'
          }
        },
        schemas: {
          Address: {
            type: :object,
            properties: {
              id:           { type: :string, format: :uuid },
              link:         { type: :string, nullable: true },
              place:        { type: :string, nullable: true },
              cep:          { type: :string, nullable: true },
              number:       { type: :string, nullable: true },
              address:      { type: :string, nullable: true },
              complement:   { type: :string, nullable: true },
              neighborhood: { type: :string, nullable: true },
              city:         { type: :string, nullable: true },
              state:        { type: :string, nullable: true },
              created_at:   { type: :string, format: :'date-time' },
              updated_at:   { type: :string, format: :'date-time' }
            },
            required: %w[id]
          },
          Customer: {
            type: :object,
            properties: {
              id:         { type: :string, format: :uuid },
              name:       { type: :string, nullable: true },
              email:      { type: :string, nullable: true },
              tax_id:     { type: :string, nullable: true },
              phone:      { type: :string, nullable: true },
              address:    { '$ref' => '#/components/schemas/Address', nullable: true },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            },
            required: %w[id]
          },
          Concessionaire: {
            type: :object,
            properties: {
              id:         { type: :string, format: :uuid },
              name:       { type: :string, nullable: true },
              acronym:    { type: :string, nullable: true },
              code:       { type: :string, nullable: true },
              region:     { type: :string, nullable: true },
              phone:      { type: :string, nullable: true },
              email:      { type: :string, nullable: true },
              active:     { type: :boolean, nullable: true },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            },
            required: %w[id]
          },
          Coordinates: {
            type: :object,
            nullable: true,
            properties: {
              latitude:  { type: :number, format: :float },
              longitude: { type: :number, format: :float }
            },
            required: %w[latitude longitude]
          },
          Project: {
            type: :object,
            properties: {
              id:               { type: :string, format: :uuid },
              client_id:        { type: :string, format: :uuid },
              address_id:       { type: :string, format: :uuid, nullable: true },
              utility_company:  { type: :string },
              utility_protocol: { type: :string },
              customer_class:   { type: :string },
              integrator:       { type: :string },
              modality:         { type: :string },
              framework:        { type: :string },
              status:           { type: :string, nullable: true },
              amount:           { type: :string, nullable: true },
              dc_protection:    { type: :string, nullable: true },
              system_power:     { type: :number, format: :float, nullable: true },
              unit_control:     { type: :string },
              description:      { type: :string, nullable: true },
              project_type:     { type: :string },
              fast_track:       { type: :boolean },
              coordinates:      { '$ref' => '#/components/schemas/Coordinates' },
              services_names:   { type: :array, items: { type: :string }, nullable: true },
              created_at:       { type: :string, format: :'date-time' },
              updated_at:       { type: :string, format: :'date-time' }
            },
            required: %w[id client_id utility_company utility_protocol customer_class
                         integrator modality framework unit_control project_type fast_track]
          },
          Upload: {
            type: :object,
            properties: {
              id:         { type: :string, format: :uuid },
              item_id:    { type: :string, format: :uuid },
              filename:   { type: :string },
              url_s3:     { type: :string },
              size:       { type: :integer },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            },
            required: %w[id item_id filename url_s3 size]
          },
          Page: {
            type: :object,
            properties: {
              content:          { type: :array, items: { type: :object } },
              totalElements:    { type: :integer },
              totalPages:       { type: :integer },
              size:             { type: :integer },
              number:           { type: :integer },
              numberOfElements: { type: :integer },
              first:            { type: :boolean },
              last:             { type: :boolean },
              empty:            { type: :boolean }
            }
          },
          Error: {
            type: :object,
            properties: {
              message: { type: :string }
            }
          },
          User: {
            type: :object,
            properties: {
              id:         { type: :string, format: :uuid },
              name:       { type: :string },
              email:      { type: :string },
              profile:    { type: :string },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            },
            required: %w[id name email profile]
          },
          AuthToken: {
            type: :object,
            properties: {
              token: { type: :string },
              user:  { '$ref' => '#/components/schemas/User' }
            },
            required: %w[token user]
          }
        }
      }
    }
  }

  config.openapi_format = :yaml
end
