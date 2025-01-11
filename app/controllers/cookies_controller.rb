class CookiesController < ApplicationController
  def accept
    if user_signed_in?
      # Stocker le consentement dans la base de données
      current_user.update(cookies_accepted: true)
    else
      # Utiliser un cookie pour les utilisateurs non connectés
      cookies[:cookies_accepted] = { value: 'true', expires: 1.year.from_now, httponly: true }
    end
    redirect_back fallback_location: root_path, notice: 'Merci, vous avez accepté les cookies.'
  end

  def decline
    if user_signed_in?
      # Supprimer ou désactiver le consentement dans la base de données
      current_user.update(cookies_accepted: false)
    else
      # Supprimer le cookie pour les utilisateurs non connectés
      cookies.delete(:cookies_accepted)
    end
    redirect_back fallback_location: root_path, alert: 'Vous avez refusé les cookies.'
  end
end
