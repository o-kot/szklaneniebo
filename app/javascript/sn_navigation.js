document.addEventListener("DOMContentLoaded", function() {
  const links = document.querySelectorAll("nav a");
  const sections = document.querySelectorAll("section");

  links.forEach(link => {
    link.addEventListener("click", function(e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute("href"));

      sections.forEach(section => {
        section.classList.remove("active");
      });

      target.classList.add("active");
    });
  });

  // Show the about section by default
  document.querySelector("#about").classList.add("active");
});
