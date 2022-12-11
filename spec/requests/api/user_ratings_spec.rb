require 'swagger_helper'

RSpec.describe 'api/user_ratings', type: :request do
  before do
    create(:user_rating)
  end

  # jitera-hook-for-rswag-example

  path '/api/user_ratings' do
    post 'Create user ratings' do
      tags 'create'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user_rating: {
            type: :object,
            properties: {
              recipe_id: {
                type: :integer,
                example: 1
              },

              star: {
                type: :integer,
                example: 1
              }

            }
          }
        }
      }
      response '200', 'create' do
        examples 'application/json' => {
          'recipes' => {
            'id' => 'integer',

            'created_at' => 'datetime',

            'updated_at' => 'datetime',

            'user_id' => 'foreign_key',

            'recipe_id' => 'foreign_key',

            'star' => 'integer'
          },

          'error_object' => {}
        }
        let(:resource_owner) { create(:user) }
        let(:token) { create(:access_token, resource_owner: resource_owner).token }

        let(:params) {}
        let(:id) { create(:user_rating).id }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
