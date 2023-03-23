import "@hotwired/turbo-rails"
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@hotwired/turbo-rails"
import "../stylesheets/application.scss"
import "bootstrap-icons/font/bootstrap-icons.scss"
import $ from "jquery"

window.jQuery = $;
window.$ = $;

import "../src/bootstrap.js"

const images = require.context("../images", true);

/*$(document).on('turbo:load', () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
})*/


Rails.start()
ActiveStorage.start()