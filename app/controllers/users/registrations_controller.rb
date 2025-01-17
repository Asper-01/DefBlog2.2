class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permettre des paramètres supplémentaires pour l'inscription et la mise à jour de l'utilisateur
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # Pour la mise à jour, permet aussi les paramètres relatifs au mot de passe
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name, :email, :remove_avatar, :cookies_consent, :password, :password_confirmation, :current_password])
  end

  private

  # Permettre des paramètres supplémentaires pour la création d'utilisateur
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Permettre des paramètres supplémentaires pour la mise à jour de l'utilisateur
  def account_update_params
    params.require(:user).permit(:name, :email, :avatar, :remove_avatar, :cookies_consent, :password, :password_confirmation, :current_password)
  end

  # Si vous souhaitez personnaliser la mise à jour, vous pouvez ajuster ici.
  # Si vous ne voulez pas une logique personnalisée, vous pouvez simplement laisser Devise gérer cette partie.

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
