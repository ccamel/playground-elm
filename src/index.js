import 'bulma/css/bulma.min.css';
import 'github-fork-ribbon-css/gh-fork-ribbon.css';
import './fonts/font.css';
import 'elm-canvas/elm-canvas.js';
import 'font-awesome/css/font-awesome.css';
import './playground.css';
import './Page/about.css';
import './Page/asteroids.css';
import './Page/calc.css';
import './Page/digital-clock.css';
import './Page/lissajous.css';
import './Page/maze.css';
import './Page/physics.css';
import './Page/term.css';

import { Elm } from './Main.elm';
const basePath = new URL(document.baseURI).pathname;
const version = document.querySelector('meta[name="version"]')?.content ?? '?';

const app = Elm.Main.init({
  node: document.querySelector('main'),
  flags: { basePath, version }
});

// -- for Elm ports

import { registerPorts } from './port/term.js';
registerPorts(app);
