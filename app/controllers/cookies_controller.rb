class CookiesController < ApplicationController
  def accept
    if user_signed_in?
      # Stocker le consentement dans la base de données
      current_user.update(cookies_consent: true)
    else
      # Utiliser un cookie pour les utilisateurs non connectés
      cookies[:cookies_consent] = { value: 'true', expires: 1.year.from_now, httponly: true }
    end
    redirect_back fallback_location: root_path, notice: 'Merci, vous avez accepté les cookies.'
  end

  def decline
    if user_signed_in?
      # Supprimer ou désactiver le consentement dans la base de données
      current_user.update(cookies_consent: false)
    else
      # Supprimer le cookie pour les utilisateurs non connectés
      cookies.delete(:cookies_consent)
    end
    redirect_back fallback_location: root_path, alert: 'Vous avez refusé les cookies.'
  end

  def preferences
    @cookies_consent = user_signed_in? ? current_user.cookies_consent : cookies[:cookies_consent] == 'true'
  end

  def update_consent
    consent = params[:cookies_consent] == '1'
    if user_signed_in?
      current_user.update(cookies_consent: consent)
    else
      cookies[:cookies_consent] = { value: consent.to_s, expires: 1.year.from_now }
    end
    redirect_to cookies_preferences_path, notice: 'Vos préférences ont été mises à jour.'
  end
end
