'use strict';

require('bootstrap/dist/css/bootstrap.css');
require('font-awesome/css/font-awesome.css');
require('./playground.css');
require('./index.html');

var Elm = require('../elm/Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);
