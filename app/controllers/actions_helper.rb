# Este Helper e responsavel por implementar as acoes de Crud nos controllers.
# Ao inclui-lo no controller e nescessario declarar a variavel @model e @fields
# na inicializacao da classe e as funcoes items_params e set_item
#
module ActionsHelper
  # INDEX
  def index
    render json: self.pagination(@model.filter(filters.merge(modifiers)))
  end

  # GET
  def show
    render json: @item
  end

  # POST
  def create
    @item = @model.create(item_params.merge(modifiers))
    if @item.valid?
      render json: @item.to_json
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    @item.update(item_params)
    if @item.valid?
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @item.destroy
  end

  # Associa o item que será visualizado, modificado ou excluido
  def set_item
    @item = @model.find_by({id: params[:id]}.merge(modifiers))
  end

  # Define os campos permitidos no objeto que será salvo
  def item_params
    params.require(:"#{@model}".downcase).permit(@fields)
  end

  # Define os campos de filtros permitidos
  def filters
    params.permit(@fields)
  end

  # Facilita a paginacao dos itens
  def pagination(data)
    pages = data.paginate(page: params[:page], per_page: params[:itens])
    {
      current_page: pages.current_page,
      total_pages: pages.total_pages,
      per_page: pages.per_page,
      total_items: pages.total_entries,
      items: pages
    }
  end

  # Sobrescreve itens com valor padrao, impedindo payloads com valores
  # Nao permitidos

  def modifiers
    {}
  end
end
