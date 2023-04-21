// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import MicroModal from "micromodal";

document.addEventListener("DOMContentLoaded", (event) => {
  MicroModal.init();
});
