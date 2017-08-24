playground-elm
==============
[![MIT](https://img.shields.io/badge/licence-MIT-lightgrey.svg?style=flat)](https://tldrlegal.com/license/mit-license) [![build-status](https://travis-ci.org/ccamel/playground-elm.svg?branch=master)](https://travis-ci.org/ccamel/playground-elm) [![ELM](https://img.shields.io/badge/elm-0.18.0-blue.svg?style=flat)](http://elm-lang.org/) [![Boostrap](https://img.shields.io/badge/bootstrap-4.0.0--beta-orange.svg?style=flat)](https://getbootstrap.com/)

> My playground I use for playing with fancy and exciting technologies. This one's for [elm].

## Purpose

The purpose of this playground is to explore, study and assess the [elm] language.

## Demo site

Visit the :small_blue_diamond: [demo site](https://ccamel.github.io/playground-elm/index.html) and play in your browser. The demo is a pure [SPA]  (100% clientside application) written in [elm].

## Building and Running

As the project is generated from [elm-app](https://github.com/tom76kimo/generator-elm-app#readme) generator, more help can be found in the github of that project; even if a lot of changes have been made.

At first, all the node packages this project depends on must be installed locally. This can be done with the following command:

```bash
npm install
```

The build can be launched with:

```bash
npm run build
```

Then, open `./dist/index.html` file in your browser.

If you prefer, the site can be published by a local HTTP server. In this mode, if any change is detected, the build of the project will be started again, and the site automatically updated in the browser; which is nice during the development phases.

The publication is launched with the following command:

```bash
npm run dev
```

The site is accessible through the `http://localhost:3000/` endpoint.

## Technologies

[![elm-logo][elm-logo]][elm] ELM language

## License

[MIT] © [Chris Camel]

[elm]: http://elm-lang.org/

[elm-logo]: doc/assets/logo-elm.png

[SPA]: https://en.wikipedia.org/wiki/Single-page_application

[Chris Camel]: https://github.com/ccamel
[MIT]: https://tldrlegal.com/license/mit-license
