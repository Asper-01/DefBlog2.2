document.addEventListener("DOMContentLoaded", () => {
  const showPasswordFieldsBtn = document.getElementById("show-password-fields");
  const passwordFields = document.getElementById("password-fields");

  if (showPasswordFieldsBtn && passwordFields) {
    // Lorsque le bouton est cliqué, on affiche les champs de mot de passe
    showPasswordFieldsBtn.addEventListener("click", () => {
      passwordFields.classList.toggle("d-none"); // On alterne la visibilité des champs de mot de passe
      showPasswordFieldsBtn.textContent = passwordFields.classList.contains("d-none")
        ? "Modifier mon mot de passe"
        : "Annuler la modification";
    });
  }
});


document.addEventListener("DOMContentLoaded", () => {
  const cancelDeleteBtn = document.getElementById("cancel-delete-btn");
  const showDeleteBtn = document.getElementById("show-delete-btn");
  const confirmDeleteSection = document.getElementById("confirm-delete-section");

  if (cancelDeleteBtn && showDeleteBtn && confirmDeleteSection) {
    // Affiche les boutons de confirmation et d'annulation
    showDeleteBtn.addEventListener("click", () => {
      showDeleteBtn.classList.add("d-none");
      confirmDeleteSection.classList.remove("d-none");
    });

    // Masque les boutons de confirmation et d'annulation
    cancelDeleteBtn.addEventListener("click", () => {
      confirmDeleteSection.classList.add("d-none");
      showDeleteBtn.classList.remove("d-none");
    });
  }
});
