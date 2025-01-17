// Utilisé dans app/views/articles/edit.html.erb
document.addEventListener("DOMContentLoaded", () => {
  const categorySelect = document.getElementById("category_select");
  const tagContainers = document.querySelectorAll(".tags-container");

  const updateTagsVisibility = (categoryId) => {
    tagContainers.forEach(container => {
      if (container.id === `tags_for_category_${categoryId}`) {
        container.style.display = "block";
      } else {
        container.style.display = "none";
      }
    });
  };

  // Afficher les tags de la première catégorie sélectionnée si applicable
  if (categorySelect.value) {
    updateTagsVisibility(categorySelect.value);
  }

  categorySelect.addEventListener("change", (event) => {
    updateTagsVisibility(event.target.value);
  });
});
