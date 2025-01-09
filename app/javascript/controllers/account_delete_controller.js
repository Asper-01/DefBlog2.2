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
