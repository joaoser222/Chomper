require 'swagger_helper'

describe 'sessions' do
  path '/login' do
    post 'Faz login de um usuário na sessão' do
      tags 'Sessões'
      consumes 'application/json'
      parameter name: :data, in: :body,
      schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
            }
          }
        }
      }
      response '200', 'Login efetuado com sucesso' do
        run_test!
      end

      response '401', 'Login inválido' do
        run_test!
      end
    end
  end

  path '/logout' do
    delete 'Faz logout de um usuário na sessão' do
      tags 'Sessões'
      consumes 'application/json'
      security [JWT: {}]
      response '200', 'Logout efetuado com sucesso' do
        run_test!
      end

      response '401', 'Token inválido' do
        run_test!
      end
    end
  end
end