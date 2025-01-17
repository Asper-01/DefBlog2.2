document.addEventListener('DOMContentLoaded', () => {
  const toggle = document.getElementById('cookies-toggle');
  const form = document.getElementById('cookies-form');

  toggle.addEventListener('change', () => {
    form.submit();
  });
});
