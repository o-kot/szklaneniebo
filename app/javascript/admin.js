document.addEventListener('DOMContentLoaded', function() {
  // Toggle password visibility
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

  // Hide flash message on form submission only if there's no redirect
  const form = document.querySelector('form');

  if (form) {
    form.addEventListener('submit', function(event) {
      const alert = document.querySelector('.alert');
      if (alert && !event.defaultPrevented) {
        alert.style.display = 'none';
      }
    });
  }

  // Auto-adjust textarea height
  const textarea = document.getElementById('about-textarea');

  if (textarea) {
    const adjustHeight = () => {
      textarea.style.height = 'auto';
      textarea.style.height = `${textarea.scrollHeight}px`;
    };

    adjustHeight();
    textarea.addEventListener('input', adjustHeight);
  }
});
