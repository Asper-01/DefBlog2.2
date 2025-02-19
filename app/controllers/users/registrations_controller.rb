module Users
  class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    # PUT /resource
    def update
      # Gérer l'avatar s'il est présent ou s'il doit être supprimé
      if params[:user][:remove_avatar] == "1"
        resource.avatar.detach
      end

      if update_resource(resource, account_update_params)
        set_flash_message(:notice, :updated) if is_flashing_format?
        bypass_sign_in(resource, scope: resource_name) # Maintenir la session après mise à jour
        redirect_to after_update_path_for(resource), notice: "Votre profil a été mis à jour avec succès."
      else
        clean_up_passwords(resource)
        set_minimum_password_length
        render :edit
      end
    end

    protected

    # Permettre des paramètres supplémentaires pour l'inscription et la mise à jour de l'utilisateur
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [
        :avatar, :remove_avatar, :name, :email, :cookies_accepted,
        :password, :password_confirmation, :current_password
      ])
    end

    # Autoriser des paramètres pour la mise à jour
    def account_update_params
      params.require(:user).permit(
        :name, :email, :avatar, :remove_avatar, :cookies_accepted,
        :password, :password_confirmation, :current_password
      )
    end

    # Permet de mettre à jour les informations de l'utilisateur sans exiger le mot de passe
    def update_resource(resource, params)
      # Supprimer le champ `current_password` si présent
      params.delete(:current_password)
      resource.update_without_password(params)
    end

  end
end
