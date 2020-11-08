'use strict';

require('./fonts/font.css');
require('tether/dist/css/tether.css');
require('bootstrap/dist/css/bootstrap.css');
require('font-awesome/css/font-awesome.css');
require('animate.css/animate.css')
require('./playground.css');
require('./calc.css');
require('./lissajous.css');
require('./digital-clock.css');
require('./maze.css');

const { Elm } = require('./Main.elm');

Elm.Main.init({
    node: document.querySelector('main')
});