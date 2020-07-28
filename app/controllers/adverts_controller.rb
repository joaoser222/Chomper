class AdvertsController < ApplicationController
  include ActionsHelper
  before_action :authenticate_user!
  before_action -> { set_permission([ 'company', 'admin' ]) },except: [:index,:show]
  before_action :set_item, except: [:index, :create]
  before_action :item_change, except: [:index, :create,:show]


  def initialize
    @model = Advert
    @fields = [:name, :description, :status, :price, :user_id]
  end

  def index
    if current_user.kind == 'customer'
    # Formula de haversine aplicada para verificar distancia e se o consumidor
    # está dentro do raio de abrangencia da empresa.

      render json: self.pagination(@model.filter(filters)
      .joins("INNER JOIN users ON users.id = adverts.user_id and users.kind = 'company'")
      .where("( 6371 *
              acos(
                cos(radians(#{current_user.latitude})) * cos(radians(latitude))*
                cos(radians(longitude) - radians(#{current_user.longitude})) +
                sin(radians(#{current_user.latitude})) * sin(radians(latitude)) 
                )
              ) <= (radius/1000)
              and adverts.status = 'a'
            "
            )
          )
    else
      super
    end
  end

  def upload_photo
    uploaded_file = params[:image]
    filename = "uploads/#{uploaded_file.original_filename}"
    File.open("public/#{filename}", 'wb') do |file|
      file.write(uploaded_file.read)
    end
    @item.update(image: filename)
    head :ok  
  end

  private

  def item_change
    unless @item
      render json: { error: 'Anúncio não encontrado' }, status: 401
    end
  end

  def modifiers
    if current_user.kind == 'company'
      { user_id: current_user.id }
    else
      {}
    end
  end

end
