document.addEventListener("DOMContentLoaded", function () {
  // Initialisation de la modale Bootstrap en ciblant l'élément avec l'ID 'cookies-modal'
  const cookiesModal = new bootstrap.Modal(document.getElementById('cookies-modal'));

  // Vérification si le consentement aux cookies a déjà été donné
  // On recherche un cookie nommé "cookies_accepted" avec la valeur "true"
  if (!document.cookie.includes("cookies_accepted=true")) {
    // Si le consentement n'existe pas ou n'est pas donné, afficher la modale
    cookiesModal.show();
  }

  // Ajout d'un gestionnaire d'événement pour le bouton "Accepter"
  document.getElementById("accept-cookies-btn").addEventListener("click", function () {
    // Définir un cookie "cookies_accepted" avec la valeur "true", valide pendant 30 jours
    document.cookie = "cookies_accepted=true; path=/; max-age=" + 60 * 60 * 24 * 30;

    // Fermer la modale après avoir accepté les cookies
    cookiesModal.hide();
  });

  // Ajout d'un gestionnaire d'événement pour le bouton "Refuser"
  document.getElementById("reject-cookies-btn").addEventListener("click", function () {
    // Définir un cookie "cookies_accepted" avec la valeur "false", valide pendant 30 jours
    // Cela indique que l'utilisateur refuse les cookies non essentiels
    document.cookie = "cookies_accepted=false; path=/; max-age=" + 60 * 60 * 24 * 30;

    // Fermer la modale après avoir refusé les cookies
    cookiesModal.hide();
  });
});
