/* global location */

/* global $ */

import baked_sweets from "../images/main-visual/baked_sweets.jpg";
import fruit_tart from "../images/main-visual/fruit_tart.jpg";
import patissier from "../images/main-visual/patissier.jpg";
import shortcake from "../images/main-visual/shortcake.jpg";
import showcase from "../images/main-visual/showcase.jpg";
import welcome_door from "../images/main-visual/welcome_door.jpg";

const images = [
  baked_sweets,
  fruit_tart,
  patissier,
  shortcake,
  showcase,
  welcome_door,
];

const vegasOptions = {
  slides: images.map(image => ({ src: image })),
  transition: "fade",
  animation: "random",
  timer: false,
  delay: 1e4,
};

function randomArrayItem(array) {
  const length = array.length;
  const index = Math.trunc(Math.random() * length);
  return array[index];
}

$(document).on("turbolinks:load", () => {
  switch (location.pathname) {
    case "/": {
      $("#mv-picture").vegas(vegasOptions);
      break;
    }

    case "/about": {
      const randomImage = randomArrayItem(images);
      $("#about-image").attr("src", randomImage);
      break;
    }
  }
});
