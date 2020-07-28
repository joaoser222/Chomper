require 'swagger_helper'
params = {
  name: { type: :string, description: 'Nome'},
  email: { type: :string, description: 'Email' },
  phone: { type: :string, description: 'Telefone' },
  document: { type: :string, description: 'CPF/CNPJ' },
  state: { type: :string, description: 'Sigla do Estado'},
  city: { type: :string, description: 'Cidade'},
  district: { type: :string,description: 'Bairro' },
  street: { type: :string,description: 'Rua' },
  password: { type: :string, description: 'Senha' },
  password_confirmation: { type: :string, description: 'Confirmação de senha' },
  latitude: { type: :number, description: 'Latitude em decimais' },
  longitude: { type: :number, description: 'Longitude em decimais' },
  radius: { type: :integer, description: 'Raio de atuação em metros' }
}
required = ['name','email','password','password_confirmation','latitude','longitude']

describe 'registrations' do
  path '/register/customer' do
    post 'Cria um novo consumidor' do
      tags 'Cadastros'
      consumes 'application/json'
      parameter name: :data,in: :body,
      schema:{
        type: :object,
        properties:{
          user:{
            type: :object,
            properties: params.select {|k| k != :radius},
            required: required
          }
        }
      }
      response '200', 'Usuário criado com sucesso' do
        run_test!
      end

      response '422', 'Parâmetros incorretos' do
        run_test!
      end
    end
  end

  path '/register/company' do
    post 'Cria uma nova empresa' do
      tags 'Cadastros'
      consumes 'application/json'
      parameter name: :data, in: :body,
      schema: {
        type: :object,
        properties:{
          user: {
            type: :object,
            properties: params,
            required: required
          }
        }
      }
      response '200', 'Usuário criado com sucesso' do
        run_test!
      end

      response '422', 'Parâmetros incorretos' do
        run_test!
      end
    end
  end
  path '/profile' do
    put 'Atualiza perfil do usuário logado' do
      tags 'Sessões'
      consumes 'application/json'
      security [JWT: {}]
      parameter name: :data, in: :body,
      schema: {
        type: :object,
        properties:{
          user: {
            type: :object,
            properties: params,
          }
        }
      }
      response '200', 'Perfil alterado com sucesso' do
        run_test!
      end

      response '422', 'Parâmetros incorretos' do
        run_test!
      end
    end
  end

  path '/profile/upload_photo' do
    post 'Atualiza foto de perfil do usuário logado' do
      tags 'Sessões'
      consumes 'multipart/form-data'
      security [JWT: {}]
      parameter name: :avatar,in: :formData,
      schema: {
        type: :object,
        properties: {
          avatar: { type: :file }
        }
      }
      
      response '200', 'Logout efetuado com sucesso' do
        run_test!
      end

      response '401', 'Token inválido' do
        run_test!
      end
    end
  end

  path '/password/reset' do
    post 'Efetua a alteração de senha do usuário' do
      tags 'Senhas'
      description "Esta rota envia um token para o email solicitado no request. Através
                  deste token é possível realizar a alteração de senha na rota /password/edit
                  "
      consumes 'application/json'
      parameter name: :email, in: :body,
      schema: {
        type: :object,
        properties: {
          email: { type: :string, required: true }
        }
      }
      response '200', 'Email com token enviado com sucesso' do
        run_test!
      end

      response '422', 'Parâmetros incorretos' do
        run_test!
      end
    end
  end

  path '/password/edit' do
    post 'Efetua a alteração de senha do usuário' do
      tags 'Senhas'
      description "Esta rota realiza a alteração da senha de um usuário, após o token ter
                  sido enviado para o email dele utilizando a rota /passoword/reset
                  "
      consumes 'application/json'
      parameter name: :data, in: :body,
      schema: {
        type: :object,
        properties: {
          reset_password_token: { type: :string, required: true },
          password: { type: :string, required: true},
          password_confirmation: { type: :string, required: true }
        }
      }
      response '200', 'Senha alterada com sucesso' do
        run_test!
      end

      response '422', 'Parâmetros incorretos' do
        run_test!
      end
    end
  end

end