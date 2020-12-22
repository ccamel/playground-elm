'use strict';

require('./fonts/font.css');
require('tether/dist/css/tether.css');
require('bootstrap/dist/css/bootstrap.css');
require('bootstrap/dist/js/bootstrap.bundle.js');
require('font-awesome/css/font-awesome.css');
require('animate.css/animate.css')
require('./playground.css');
require('./calc.css');
require('./lissajous.css');
require('./digital-clock.css');
require('./maze.css');

const { Elm } = require('./Main.elm');
const basePath = new URL(document.baseURI).pathname;

console.log(basePath)

Elm.Main.init({
    node: document.querySelector('main'),
    flags: { basePath }
});