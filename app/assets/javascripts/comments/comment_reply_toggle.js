document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll('[data-action="click->toggle-reply#toggleForm"]').forEach(function(button) {
    button.addEventListener('click', function() {
      const commentId = this.getAttribute('data-comment-id');
      const replyForm = document.getElementById('reply-form-' + commentId);
      replyForm.classList.toggle('d-none');
    });
  });
});
