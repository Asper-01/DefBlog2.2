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
    # Si l'utilisateur est connecté, on charge ses préférences de cookies
    if user_signed_in?
      @cookies_consent = current_user.cookies_consent
    else
      # Pour les utilisateurs non connectés, charger les cookies depuis le cookie de session
      @cookies_consent = cookies[:cookies_consent] == 'true'
    end
  end

  def update_consent
    if user_signed_in?
      consent_value = params[:cookies_consent] # Récupérer la valeur actuelle du consentement
      if current_user.update(cookies_consent: consent_value)
        redirect_back fallback_location: root_path, notice: "Vos préférences de cookies ont été mises à jour."
      else
        redirect_back fallback_location: root_path, alert: "Une erreur est survenue lors de la mise à jour de vos préférences."
      end
    else
      cookies[:cookies_consent] = { value: params[:cookies_consent], expires: 1.year.from_now, httponly: true }
      redirect_back fallback_location: root_path, notice: "Vos préférences de cookies ont été mises à jour."
    end
  end
end
