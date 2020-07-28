# Este Helper é um módulo para facilitar a criação de specs para o swagger.
def generate_docs(controller_name,main_path,tag,params = {},required = [],custom = {})
  methods = {
    index: { 
      verb: 'get', path: "#{main_path}", desc: "Lista #{tag}",
      consumes: 'application/json',
      params: params.inject({}) { |h, (k, v)| h[k] = v.merge(in: :query); h }
    },
    show: { 
      verb: 'get', path: "#{main_path}/{id}", desc: "Retorna #{tag} de acordo com id passado",
      consumes: 'application/json',
      params: {
        id: {in: :path, type: :integer},
      }
    },
    create: {
      verb:'post', path: "#{main_path}", desc: "Cria #{tag}",
      consumes: 'application/json',
      params: {
        data: {
          in: :body,
          schema: {
            type: :object,
            properties: {
              "#{controller_name.delete_suffix('s')}": {
                type: :object,
                properties: params,
                required: required
              }
            }
          }
        }
      }
    },
    update: {
      verb:'put', path: "#{main_path}/{id}", desc: "Atualiza dados de #{tag} de acordo com id passado",
      consumes: 'application/json',
      params: {
        id: { in: :path,type: :integer },
        data: {
          in: :body,
          schema: {
            type: :object,
            properties: {
              "#{controller_name.delete_suffix('s')}": {
                type: :object,
                properties: params
              }
            }
          }
        }
      }
    },
    delete: {
      verb:'delete', path: "#{main_path}/{id}", desc: "Deleta #{tag} de acordo com id passado",
      consumes: 'application/json',
      params: {
        id: {in: :path, type: :integer}
      }
    }
  }
  methods.deep_merge!(custom)
  properties = methods.inject({}) { |h, (k, v)| h[k] = v.merge(custom[k] ? custom[k] : {}); h }

  RSpec.describe "#{controller_name}", type: :request do
    properties.each do |key,value|
      path "#{value[:path]}" do
        send(value[:verb],value[:desc]) do
          description value[:description]
          tags tag
          consumes value[:consumes]
          security [JWT: {}]
          if value[:params].any?
            value[:params].each do |p_key,p_value|
              parameter name: p_key,
                        in: p_value[:in],
                        type: p_value[:type],
                        required: p_value[:required],
                        description: p_value[:description],
                        schema: p_value[:schema]
            end
          end
          response '200', 'OK' do
            run_test!
          end
    
          response '401', 'Usuário não está logado' do
            run_test!
          end

          response '422', 'Parâmetros incorretos' do
            run_test!
          end
        end
      end
    end
  end
end

