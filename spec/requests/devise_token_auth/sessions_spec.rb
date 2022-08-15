require 'swagger_helper'

RSpec.describe 'devise_token_auth/sessions', type: :request do

  path '/api/v1/auth/sign_in' do

    post('create session') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :my_params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        }
      } 
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
