document.getElementById('toggle-password').addEventListener('click', function() {
  var passwordField = document.getElementById('password-field');
  var button = document.getElementById('toggle-password');
  var icon = button.querySelector('i');

  if (passwordField.type === "password") {
    passwordField.type = "text";
    icon.classList.remove('fa-eye');
    icon.classList.add('fa-eye-slash');  // Change l'icône en œil barré
  } else {
    passwordField.type = "password";
    icon.classList.remove('fa-eye-slash');
    icon.classList.add('fa-eye');  // Revert l'icône à œil normal
  }
});
