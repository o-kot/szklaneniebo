document.addEventListener('DOMContentLoaded', function() {
  const eyeIcon = document.querySelector('.eye-icon');
  const passwordField = document.getElementById('password');

  if (eyeIcon && passwordField) {
    eyeIcon.addEventListener('click', function() {
      const type = passwordField.type === 'password' ? 'text' : 'password';
      passwordField.type = type;
      this.classList.toggle('fa-eye-slash');
      this.classList.toggle('fa-eye');
    });
  }
});

document.addEventListener('DOMContentLoaded', function() {
  const alert = document.querySelector('.alert');
  const form = document.querySelector('form');

  if (form) {
    form.addEventListener('submit', function() {
      if (alert) {
        alert.style.display = 'none';
      }
    });
  }
});