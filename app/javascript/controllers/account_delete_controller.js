document.addEventListener("DOMContentLoaded", () => {
  const confirmDeleteBtn = document.getElementById("confirm-delete-btn");
  const cancelDeleteBtn = document.getElementById("cancel-delete-btn");
  const showDeleteBtn = document.getElementById("show-delete-btn");
  const confirmDeleteSection = document.getElementById("confirm-delete-section");

  if (confirmDeleteBtn && cancelDeleteBtn && showDeleteBtn) {
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
