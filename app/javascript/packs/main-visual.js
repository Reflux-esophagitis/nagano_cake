/* global MutationObserver */

/* global $ */

import baked_sweets from "../images/main-visual/baked_sweets.jpg";
import fruit_tart from "../images/main-visual/fruit_tart.jpg";
import patissier from "../images/main-visual/patissier.jpg";
import shortcake from "../images/main-visual/shortcake.jpg";
import showcase from "../images/main-visual/showcase.jpg";
import welcome_door from "../images/main-visual/welcome_door.jpg";

const vegasOptions = {
  slides: [
    { src: showcase },
    { src: baked_sweets },
    { src: fruit_tart },
    { src: patissier },
    { src: shortcake },
    { src: showcase },
    { src: welcome_door },
  ],
  transition: "fade",
  animation: "random",
  timer: false,
  delay: 1e4,
};

$(document).on("turbolinks:load", () => {
  $("#mv-picture").vegas(vegasOptions);
});
