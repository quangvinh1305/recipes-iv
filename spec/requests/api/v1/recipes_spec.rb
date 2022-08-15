require 'swagger_helper'
RSpec.describe 'api/v1/recipes.json', type: :request do

  path '/api/v1/recipes.json' do

    get('list recipes') do
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

  path '/api/v1/recipes.json' do

    post 'Creates a recipe' do
      consumes 'application/json'
      parameter name: :recipe, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          notes: { type: :string },
          steps_attributes: {
            "type": "array",
            "items": {
              "type": "object",
              properties: {
                description: { type: :string },
                order: {type: :integer},
                ingredients_attributes: {
                  "type": "array",
                  "items": {
                    "type": "object",
                    properties: {
                      name: { type: :string },
                      amount: {type: :string},
                      unit: {type: :string},
                    }
                  }
                }
              }
            }
          }
        }
      }, description: 'choose unit need convert pound, ounce, gram, cup, tablespoon, teaspoon'
      # security [Bearer: {}]
      security [client: {}, uid: {}, access_token:  {}]
      # new_auth_header = create_auth_header_from_scratch
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      # parameter name: 'Authorization', in: :header, type: :string
      
      response(200, 'recipe created') do

        # puts new_auth_header
        # let(:authorization) { "Bearer #{new_auth_header}" }
        # let(:recipe) { { :name => "sdkjsjkdds", :note => "sdkdskjdsj", author_id: "1", :steps_attributes => [{ :description => "sdkskdjkdjs", :order => 1, :ingredients_attributes => [{ :name => "sdjksdkjd", :amount => "0.5", :unit => "ksdjdskjdkj"}]}]} }

        # after do |example|
        #   example.metadata[:response][:content] = {
        #     'application/json' => {
        #       example: JSON.parse(response.body, symbolize_names: true)
        #     }
        #   }
        # end
        # let(:client) { new_auth_header['client'] }
        # let('access-token') { new_auth_header['access-token'] }
        # let(:uid) { new_auth_header['uid'] }
        # let(:Authorization) { 'jhghgghhghgghghhgghgh' }
        schema type: :object,
          properties: {
           'Authorization': { type: :string }
          }
        run_test!
      end
    end
  end

  # path '/api/v1/recipes/new' do

  #   get('new recipe') do
  #     response(200, 'successful') do

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  # path '/api/v1/recipes/{id}/edit' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   get('edit recipe') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end

  path '/api/v1/recipes/{id}.json?cooking_mode={cooking_mode}&conver_to_unit={conver_to_unit}&order={order}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: 'cooking_mode', in: :path, type: :string, description: 'choose cooking mode'
    parameter name: 'order', in: :path, type: :string, description: 'enter order 0, 1, 2, 3'
    parameter name: 'conver_to_unit', in: :path, type: :string, description: 'choose unit need convert pound, ounce, gram, cup, tablespoon, teaspoon'

    get('show recipe') do
      response(200, 'successful') do
        let(:id) { '123' }
        let(:cooking_mode) {'1'}
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

    # patch('update recipe') do
    #   response(200, 'successful') do
    #     let(:id) { '123' }

    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end

    # put('update recipe') do
    #   response(200, 'successful') do
    #     let(:id) { '123' }

    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end

    # delete('delete recipe') do
    #   response(200, 'successful') do
    #     let(:id) { '123' }

    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
  end
end
