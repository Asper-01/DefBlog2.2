import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  connect() {
    console.log("ToggleReplyController connected");
  }

  toggleForm(event) {
    const commentId = event.target.dataset.commentId;
    const form = document.querySelector(`#reply-form-${commentId}`);

    if (form) {
      // On inverse la classe `d-none` pour afficher/masquer le formulaire
      form.classList.toggle("d-none");
    }
  }
}
