module Users
  class ChecksController < ApplicationController
    skip_before_action :authenticate_user!, only: [:uniqueness]
    def uniqueness
      field = params[:field]
      value = params[:value]

      # Vérifiez que le champ est autorisé
      if %w[email name].include?(field)
        exists = User.exists?(field => value)
        render json: { exists: exists }, status: :ok
      else
        render json: { error: 'Champ non valide' }, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Une erreur est survenue : #{e.message}" }, status: :internal_server_error
    end
  end
end
