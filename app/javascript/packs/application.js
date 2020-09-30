// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require('jquery')
require("channels")
require("packs/map")
require("packs/vote")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Import css from js for webpack to process it correctly
// import '../css/application.css'

import "@fortawesome/fontawesome-free/js/all";
import "choices.js/public/assets/styles/choices.css";

// Add Choices Dropdown
const Choices = require('choices.js')

document.addEventListener("turbolinks:load", () => {
    if (document.getElementById('dropdown-choice-select') !== null) {
        const dropDownSelects = new Choices('#dropdown-choice-select', {
            removeItemButton: true,
            duplicateItemsAllowed: false,
            delimiter: ',',
            noChoicesText: 'No choices to choose from',
            addItemText: (value) => {
                return `Press Enter to add <b>"${value}"</b>`;
            }
        })
    }
})