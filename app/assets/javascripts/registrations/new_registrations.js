document.addEventListener('DOMContentLoaded', () => {
  const emailField = document.getElementById('email-field');
  const emailErrorIcon = document.getElementById('email-error-icon');
  const emailErrorMessage = document.getElementById('email-error-message');
  const passwordField = document.getElementById('password-field');
  const passwordErrorMessage = document.getElementById('password-error-message');

  // Vérification email
  if (emailField) {
    emailField.addEventListener('blur', () => {
      const email = emailField.value;

      if (email) {
        fetch(`/users/check_uniqueness?field=email&value=${email}`)
          .then(response => response.json())
          .then(data => {
            if (data.exists) {
              emailErrorMessage.textContent = "Email est déjà utilisé";
              emailField.classList.add('error');
              emailErrorIcon.style.display = 'inline';
            } else {
              emailErrorMessage.textContent = '';
              emailField.classList.remove('error');
              emailErrorIcon.style.display = 'none';
            }
          })
          .catch(err => {
            console.error('Erreur lors de la vérification de l\'email:', err);
          });
      }
    });

    emailField.addEventListener('input', () => {
      const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
      const emailValue = emailField.value;

      if (!emailRegex.test(emailValue)) {
        emailErrorMessage.textContent = "Email invalide, veuillez réessayer.";
        emailField.classList.add('error');
        emailErrorIcon.style.display = 'inline';
      } else {
        emailErrorMessage.textContent = '';
        emailField.classList.remove('error');
        emailErrorIcon.style.display = 'none';
      }
    });
  }

  // Validation mot de passe
  if (passwordField) {
    passwordField.addEventListener('input', () => {
      const password = passwordField.value;
      const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/; // Minimum 8 caractères, 1 lettre, 1 chiffre, 1 caractère spécial

      if (!passwordRegex.test(password)) {
        passwordErrorMessage.textContent = "Le mot de passe doit comporter au moins 8 caractères, une lettre, un chiffre et un caractère spécial.";
        passwordField.classList.add('error');
      } else {
        passwordErrorMessage.textContent = '';
        passwordField.classList.remove('error');
      }
    });
  }
});
