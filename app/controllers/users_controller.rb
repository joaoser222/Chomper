class UsersController < ApplicationController
  include ActionsHelper
  before_action :authenticate_user! 
  before_action -> {set_permission('admin')}
  before_action :set_item 

  def initialize
    @model = User
    @fields = [:name, :phone, :document, :state, :city, :district, :street, :email, :latitude, :longitude, :radius, :password, :kind]
  end

  def upload_photo
    uploaded_file = params[:avatar]
    filename = "uploads/#{uploaded_file.original_filename}"
    File.open("public/#{filename}", 'wb') do |file|
      file.write(uploaded_file.read)
    end
    if User.where(id: params[:id]).update(avatar: filename)
      head :ok
    end
  end
end
