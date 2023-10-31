"use strict";

import "bulma/css/bulma.min.css";
import "./fonts/font.css";
import "tether/dist/css/tether.css";
import "elm-canvas/elm-canvas.js";
import "font-awesome/css/font-awesome.css";
import "animate.css/animate.css";
import "./playground.css";
import "./calc.css";
import "./lissajous.css";
import "./digital-clock.css";
import "./maze.css";
import "./term.css";
import "./asteroids.css";

const { Elm } = require("./Main.elm");
const basePath = new URL(document.baseURI).pathname;
const version = (document.querySelector('meta[name="version"]') || {}).content ?? "?";

const app = Elm.Main.init({
  node: document.querySelector("main"),
  flags: { basePath, version },
});

// -- for Elm ports

const { registerPorts } = require("./port/term.js");
registerPorts(app);
