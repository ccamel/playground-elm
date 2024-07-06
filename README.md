# `|>` playground-elm

[![release](https://img.shields.io/github/release/ccamel/playground-elm.svg?style=flat)](https://github.com/ccamel/playground-elm/releases)
[![MIT](https://img.shields.io/badge/licence-MIT-lightgrey.svg?style=flat)](https://tldrlegal.com/license/mit-license)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm?ref=badge_shield)
[![build-status](https://github.com/ccamel/playground-elm/actions/workflows/build.yml/badge.svg)](https://github.com/ccamel/playground-elm/actions/workflows/build.yml)
[![quality-grade](https://app.codacy.com/project/badge/Grade/05944c94318b4da3b8f438f8d441d869)](https://app.codacy.com/gh/ccamel/playground-elm/dashboard?branch=main)
[![ELM](https://img.shields.io/badge/elm-0.19.1-blue.svg?style=flat&logo=elm)](http://elm-lang.org/)
<a href="https://bulma.io/"><img height=20px src="https://bulma.io/assets/images/made-with-bulma.png" alt="made with bulma"></a>
[![pnpm](https://img.shields.io/badge/pnpm-%234a4a4a.svg?style=flat&logo=pnpm&logoColor=f69220)](https://pnpm.io)
[![git3moji](https://img.shields.io/badge/gitmoji-%20😜%20😍-FFDD67.svg?style=flat-square)](https://gitmoji.carloscuesta.me)
[![StackShare](https://img.shields.io/badge/tech-stack-0690fa.svg?style=flat&logo=stackshare)](https://stackshare.io/ccamel/playground-elm)
[![Demo](https://img.shields.io/badge/play-demo!-b30059.svg?style=flat)](https://ccamel.github.io/playground-elm/)

> My playground I use for playing with fancy and exciting technologies. This one's for [elm][].

## 🎯 Purpose

The purpose of this playground is to explore, study and assess the [elm][] language — a delightful language for reliable webapps.

<p align="center">
   <a href="https://ccamel.github.io/playground-elm/">
    <img alt="demo-link" src="https://img.shields.io/badge/demo-https%3A%2F%2Fccamel.github.io%2Fplayground--elm%2F-blue?style=for-the-badge&logo=firefox">
   </a>
</p>

The showcases are intended to be:

- **simple**: Fairly simple and understandable. Every showcase is implemented in a single elm file.
- **exploratory**:
  - _Highlight_ some aspects of the [elm][] language, like immutability, reactiveness, performance and
    interoperability with other JS libraries and CSS frameworks.
  - _Explore_ some architectural/design patterns around reactive static/serverless [SPA][]
- **playable**: As much as possible, provides a useful and enjoyable content.

## 🍿 Showcases

Visit the :small_blue_diamond: [demo site](https://ccamel.github.io/playground-elm/) and play in your browser.

The demo is a pure [SPA][] (100% clientside application) written in [elm][].

List of showcases:

- _asteroids_: A simple Asteroids clone in [Elm][] using the [ECS](https://en.wikipedia.org/wiki/Entity_component_system) pattern and [SVG](https://fr.wikipedia.org/wiki/Scalable_Vector_Graphics) for rendering.
- _term_: A terminal which evaluates JavaScript code using elm ports.
- _physics-engine_: Very simple physics engine using [Verlet Integration](https://en.wikipedia.org/wiki/Verlet_integration) algorithm and rendered through an HTML5 canvas.
- _maze_: A maze generator using a [recursive backtracking](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker) algorithm.
- _digital-clock_: A demo rendering a digital clock in [SVG](https://fr.wikipedia.org/wiki/Scalable_Vector_Graphics).
- _lissajous_: Animated [Lissajous](https://en.wikipedia.org/wiki/Lissajous_curve) figures in [SVG](https://fr.wikipedia.org/wiki/Scalable_Vector_Graphics)
- _calc_: A very simple and basic calculator.

## 🛠 Building and Running

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

### Prerequisites

Be sure to have the following properly installed:

- [Node.js](https://nodejs.org/ru/) `v18.17` ([hydrogen](https://nodejs.org/en/blog/release/v18.17.1/))
- [pnpm](https://pnpm.io/) `v8.3`

### Build

The project now relies on [parceljs][], a web application bundler which handles [elm][] builds at free.

At first, all the node packages this project depends on must be installed locally. This can be done with the
following command:

```bash
pnpm install
```

The build can be launched with:

```bash
pnpm build
```

Then, open `./dist/index.html` file in your browser.

If you prefer, the site can be published by a local HTTP server. In this mode, if any change is detected, the build of
the project will be started again, and the site automatically updated in the browser; which is nice during the development phases.

The publication is launched with the following command:

```bash
pnpm serve
```

The site is accessible through the `"/` endpoint.

## 🔋 Technologies

- [`elm`](http://elm-lang.org/): ELM

  With the following (main and non exhaustive) packages:

  - [Chadtech/elm-vector](https://package.elm-lang.org/packages/Chadtech/elm-vector/latest/)
  - [avh4/elm-color](https://package.elm-lang.org/packages/avh4/elm-color/latest/)
  - [cuducos/elm-format-number](https://package.elm-lang.org/packages/cuducos/elm-format-number/latest/)
  - [elm-explorations/markdown](https://package.elm-lang.org/packages/elm-explorations/markdown/latest/)
  - [simonh1000/elm-colorpicker](https://package.elm-lang.org/packages/simonh1000/elm-colorpicker/latest/)
  - [joakin/elm-canvas](https://package.elm-lang.org/packages/joakin/elm-canvas/latest/)
  - [wsowens/term](https://package.elm-lang.org/packages/wsowens/term/latest/)
  - [MacCASOutreach/graphicsvg](https://package.elm-lang.org/packages/MacCASOutreach/graphicsvg/latest/)
  - [harmboschloo/elm-ecs](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/)
  - [BrianHicks/elm-particle](https://github.com/BrianHicks/elm-particle)

- [`parceljs`](https://parceljs.org/): Web application bundler
- [`bulma`](https://bulma.io/): The modern CSS framework

## 📜 License

[MIT][] © [Chris Camel][]

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm?ref=badge_large)

[elm]: http://elm-lang.org/
[parceljs]: https://parceljs.org/
[spa]: https://en.wikipedia.org/wiki/Single-page_application
[chris camel]: https://github.com/ccamel
[mit]: https://tldrlegal.com/license/mit-license
