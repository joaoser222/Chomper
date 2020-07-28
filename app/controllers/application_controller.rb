class ApplicationController < ActionController::API
  def set_permission(permission)
    if (!(permission.include? current_user.kind))
      render json: {error: 'Usuário logado não possui permissão para esta ação'}, status: 401
    end
  end
end
