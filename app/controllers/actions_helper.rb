# Este Helper e responsavel por implementar as acoes de Crud nos controllers.
# Ao inclui-lo no controller e nescessario declarar a variavel @model
# na inicializacao da classe e as funcoes privadas items_params e set_item
#
module ActionsHelper

  def index
    data = @model.all.paginate(page: params[:page], per_page: params[:itens])
    render json: {
      current_page: data.current_page,
      total_pages: data.total_pages,
      per_page: data.per_page,
      total_items: data.total_entries,
      items: data
    }
  end

  # GET
  def show
    render json: @model.find_by(id: params[:id])
  end

  # POST
  def create
    @item = @model.new(item_params)
    if @item.save
      render json: @item.to_json
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @item.destroy
  end
end
