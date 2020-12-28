playground-elm
==============
[![release](https://img.shields.io/github/release/ccamel/playground-elm.svg?style=flat)](https://github.com/ccamel/playground-elm/releases)
[![MIT](https://img.shields.io/badge/licence-MIT-lightgrey.svg?style=flat)](https://tldrlegal.com/license/mit-license)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm?ref=badge_shield)
[![build-status](https://travis-ci.org/ccamel/playground-elm.svg?branch=master)](https://travis-ci.org/ccamel/playground-elm)
[![ELM](https://img.shields.io/badge/elm-0.19.1-blue.svg?style=flat)](http://elm-lang.org/)
[![Boostrap](https://img.shields.io/badge/bootstrap-4.0.1-orange.svg?style=flat)](https://getbootstrap.com/)
[![StackShare](https://img.shields.io/badge/tech-stack-0690fa.svg?style=flat)](https://stackshare.io/ccamel/playground-elm)
[![Demo](https://img.shields.io/badge/play-demo!-b30059.svg?style=flat)](https://ccamel.github.io/playground-elm/)

> My playground I use for playing with fancy and exciting technologies. This one's for [elm].

## Purpose

The purpose of this playground is to explore, study and assess the [elm] language — a delightful language for reliable webapps.

The showcases are intended to be:

  - **simple**: Fairly simple and understandable. Every showcase is implemented in a single elm file.
  - **exploratory**: 
    - *Highlight* some aspects of the [elm] language, like immutability, reactiveness, performance and
    interoperability with other JS libraries and CSS frameworks.
    - *Explore* some architectural/design patterns around reactive static/serverless [SPA].
  - **playable**: As much as possible, provides a useful and functional content.  

## Showcases

Visit the :small_blue_diamond: [demo site](https://ccamel.github.io/playground-elm/) and play in your browser. 
The demo is a pure [SPA] (100% clientside application) written in [elm].

### Calc

Calc is a very simple and basic calculator.

<p align="center">
  <b>Links:</b><br>
  <a href="https://ccamel.github.io/playground-elm/#calc">Play</a>  | 
  <a href="https://github.com/ccamel/playground-elm/blob/master/src/Page/Calc.elm">Code</a>
  <br><br>
  <kbd><img src="doc/assets/showcase-calc.png"></kbd>
</p>

### Digital clock

Simple digital clock using [Scalable Vector Graphics](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) (SVG).

<p align="center">
  <b>Links:</b><br>
  <a href="https://ccamel.github.io/playground-elm/#digital-clock">Play</a> |
  <a href="https://github.com/ccamel/playground-elm/blob/master/src/Page/DigitalClock.elm">Code</a>
  <br><br>
  <kbd><img src="doc/assets/showcase-digitalclock.png"></kbd>
</p>

### Lissajous

Animated [Lissajous figures](https://en.wikipedia.org/wiki/Lissajouss_curve) using 
[Scalable Vector Graphics](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) (SVG).

<p align="center">
  <b>Links:</b><br>
  <a href="https://ccamel.github.io/playground-elm/#lissajous">Play</a> |
  <a href="https://github.com/ccamel/playground-elm/blob/master/src/Page/Lissajous.elm">Code</a>
  <br><br>
  <kbd><img src="doc/assets/showcase-lissajous.png"></kbd>
</p>

### Maze generator

Maze generator using a [recursive backtracking](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker)
algorithm with control of the generation process.

<p align="center">
  <b>Links:</b><br>
  <a href="https://ccamel.github.io/playground-elm/#maze">Play</a> |
  <a href="https://github.com/ccamel/playground-elm/blob/master/src/Page/Maze.elm">Code</a>
  <br><br>
  <kbd><img src="doc/assets/showcase-maze.png"></kbd>
</p>

### Physics Verlet engine

Very simple physics engine using [Verlet Integration](https://en.wikipedia.org/wiki/Verlet_integration) algorithm and rendered through an HTML5 canvas.

Demonstrates how [elm] can deal with some basic mathematical and physical calculations, as well as basic rendering of objects in an HTML canvas,
using elementary functions from the fantastic [joakin/elm-canvas](https://package.elm-lang.org/packages/joakin/elm-canvas/latest/) package.

<p align="center">
  <b>Links:</b><br>
  <a href="https://ccamel.github.io/playground-elm/#physics-engine">Play</a> |
  <a href="https://github.com/ccamel/playground-elm/blob/master/src/Page/Physics.elm">Code</a>
  <br><br>
  <kbd><img src="doc/assets/showcase-physics-cloath.png"></kbd>
</p>

<p align="center">
  <img src="doc/assets/showcase-physics-necklace.png">
</p>

## Building and Running

### Elm 0.19

Elm 0.19 broke me as many other coders, due to a lot of changes on topics I used in this project with previous version:
- `elm.json` file
- JSON decoding
- String / Int / Float conversions
- Browser application, routing
- Url management
- date time (`Posix`, `Zone`)
- lots of incompatible packages  
- ...

I finally managed to migrate to this new version but instabilities can be noticed though.

### Build

The project now relies on [parceljs], a web application bundler which handles [elm] builds at free.

At first, all the node packages this project depends on must be installed locally. This can be done with the 
following command:

```bash
yarn
```

The build can be launched with:

```bash
yarn build
```

Then, open `./dist/index.html` file in your browser.

If you prefer, the site can be published by a local HTTP server. In this mode, if any change is detected, the build of 
the project will be started again, and the site automatically updated in the browser; which is nice during the development phases.

The publication is launched with the following command:

```bash
yarn serve
```

The site is accessible through the `http://localhost:1234/` endpoint.

## Technologies

[![elm-logo][elm-logo]][elm] ELM language

## License

[MIT] © [Chris Camel]

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm?ref=badge_large)

[elm]: http://elm-lang.org/

[elm-logo]: doc/assets/logo-elm.png

[parceljs]: https://parceljs.org/

[SPA]: https://en.wikipedia.org/wiki/Single-page_application

[Chris Camel]: https://github.com/ccamel
[MIT]: https://tldrlegal.com/license/mit-license
