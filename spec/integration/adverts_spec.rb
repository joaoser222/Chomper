require 'swagger_helper'
require 'crud_helper'
params = {
  name: { type: :string, description: 'Nome' },
  description: { type: :string, description: 'Descrição' },
  status: { type: :string, description: 'Status' },
  price: { type: :string, description: 'Preço' },
  image: { type: :string, description: 'imagem' }
}
required = params.keys
custom = {
  index: { 
    description:  "Esta rota se comporta de forma diferente de acordo com o usuário logado.
                  Se o usuário logado for um administrador ela irá exibir todos os registros.
                  Se for um consumidor irá filtrar anúncios de acordo com a Localização. Se for
                  uma empresa irá exibir anúncios somente da mesma.
                  "
  },
  upload_photo:{
    verb: 'post', path: "/adverts/{id}/upload_photo", desc: "Atualiza imagem de Anúncios",
    consumes: 'multipart/form-data',
    params: {
      id:{ in: :path,type: :integer },
      image:{ 
        in: :formData,
        schema: {
          type: :object,
          properties: {
            image: { type: :file }
          }
        }
      }
    }
  }
}
generate_docs('adverts', '/adverts', 'Anúncios', params, required, custom)