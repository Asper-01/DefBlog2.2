document.addEventListener("DOMContentLoaded", function() {
  tinymce.init({
    selector: 'textarea#article_content', // Sélectionner le champ content
    menubar: false,
    plugins: ['advlist autolink link image lists charmap print preview anchor'],
    toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright | bullist numlist outdent indent | removeformat'
  });
});
