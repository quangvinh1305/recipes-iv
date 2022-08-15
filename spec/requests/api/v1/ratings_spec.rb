require 'swagger_helper'

RSpec.describe 'api/v1/ratings', type: :request do

  path '/api/v1/ratings.json?recipe_id={recipe_id}' do
    parameter name: 'recipe_id', in: :path, type: :string, description: 'Enter recipe_id'
    get('list ratings') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

  end

  path '/api/v1/ratings.json' do

    post('create rating') do
      consumes 'application/json'
      parameter name: :rating, in: :body, schema: {
        type: :object,
        properties: {
          recipe_id: { type: :string },
          comment: { type: :string },
          rate_value: { type: :string },
        }
      }

      security [client: {}, uid: {}, access_token:  {}]

      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
