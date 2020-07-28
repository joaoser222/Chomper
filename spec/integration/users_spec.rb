require 'swagger_helper'
require 'crud_helper'
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
  radius: { type: :integer, description: 'Raio de atuação em metros' },
  kind: { type: :string, description: 'Tipo de usuário' }
}
required = ['name','email','password','password_confirmation','latitude','longitude','kind']

custom = {
  index: { 
    params: params.except(:password, :password_confirmation).inject({}) { |h, (k, v)| h[k] = v.merge(in: :query); h } 
  },
  upload_photo:{
    verb: 'post', path: "/users/{id}/upload_photo", desc: "Atualiza imagem de Usuários",
    consumes: 'multipart/form-data',
    params: {
      id:{ in: :path,type: :integer },
      image:{ 
        in: :formData,
        schema: {
          type: :object,
          properties: {
            avatar: { type: :file }
          }
        }
      }
    }
  }
}
generate_docs('users', '/users', 'Usuários', params, required, custom)