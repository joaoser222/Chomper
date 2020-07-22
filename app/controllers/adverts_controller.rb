class AdvertsController < ApplicationController
  include ActionsHelper
  before_action :set_item, only: [:show, :update, :destroy]
  def initialize
    @model = Advert
  end

  private

  def set_item
    @item = @model.find(params[:id])
  end

  def item_params
    params.require(:advert).permit(:description, :status, :price, :image, :user_id)
  end

end
