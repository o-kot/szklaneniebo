// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

$(document).ready(function() {
  $('[data-fancybox]').fancybox({
    loop: true, // Allows navigation in a loop
    buttons: [
      "zoom",
      "slideShow",
      "fullScreen",
      "thumbs",
      "close"
    ],
    protect: true,
    animationEffect: "zoom",
    transitionEffect: "fade",
    transitionDuration: 500,
    smallBtn: "auto",
    toolbar: "auto",
    image: {
      preload: true
    },
    afterLoad: function(instance, current) {
      // Blur the background
      $('body').addClass('blurred');
    },
    afterClose: function(instance, current) {
      // Remove blur from background
      $('body').removeClass('blurred');
    }
  });
});
