// SCRIPT POUR MASQUER LES ALERTES APRÈS 8 SECONDES
document.addEventListener("DOMContentLoaded", function() {
  // Sélectionner toutes les alertes
  const alertMessages = document.querySelectorAll('.alert');
  alertMessages.forEach(function(alert) {
    // Attendre 8 secondes avant de masquer l'alerte
    setTimeout(function() {
      alert.classList.remove("show");
      alert.classList.add("fade");
    }, 5000); // 8000 ms = 5 secondes
  });
});
