"use strict";

import "bulma/css/bulma.min.css";
import "github-fork-ribbon-css/gh-fork-ribbon.css";
import "./fonts/font.css";
import "tether/dist/css/tether.css";
import "elm-canvas/elm-canvas.js";
import "font-awesome/css/font-awesome.css";
import "animate.css/animate.css";
import "./playground.css";
import "./page/about.css";
import "./page/asteroids.css";
import "./page/calc.css";
import "./page/digital-clock.css";
import "./page/lissajous.css";
import "./page/maze.css";
import "./page/physics.css";
import "./page/term.css";

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
