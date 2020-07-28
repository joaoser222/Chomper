class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :authenticate_user!, only: [:profile,:upload_photo]

  def profile
    user = User.find(current_user.id)
    user.update(item_params.except(:kind))
    if user.valid?
      render json: { success: 'Usuário alterado com sucesso!' }
    else
      render json: user.errors.messages, status: 422
    end
  end

  def upload_photo
    uploaded_file = params[:avatar]
    filename = "uploads/#{uploaded_file.original_filename}"
    File.open("public/#{filename}", 'wb') do |file|
      file.write(uploaded_file.read)
    end
    if User.where(id: current_user.id).update(avatar: filename)
      head :ok
    end
  end

    if resource.errors.empty?
      render json: resource
    else
      render json: resource.errors
    end
  end

  def password_reset
    if User.find_by(email: params[:email]).send_reset_password_instructions
      head :ok
    end
  end

  def password_edit
    errors = User.reset_password_by_token(params.slice(:reset_password_token, :password, :password_confirmation)).errors.messages
    if errors
      render json: errors, status: 422
    else
      render status: 200
    end
  end

end
