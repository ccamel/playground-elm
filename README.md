playground-elm
==============
[![release](https://img.shields.io/github/release/ccamel/playground-elm.svg?style=flat)](https://github.com/ccamel/playground-elm/releases) [![MIT](https://img.shields.io/badge/licence-MIT-lightgrey.svg?style=flat)](https://tldrlegal.com/license/mit-license) [![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm?ref=badge_shield) [![build-status](https://travis-ci.org/ccamel/playground-elm.svg?branch=master)](https://travis-ci.org/ccamel/playground-elm) [![ELM](https://img.shields.io/badge/elm-0.18.0-blue.svg?style=flat)](http://elm-lang.org/) [![Boostrap](https://img.shields.io/badge/bootstrap-4.0.0--beta-orange.svg?style=flat)](https://getbootstrap.com/) [![Demo](https://img.shields.io/badge/play-demo!-b30059.svg?style=flat)](https://ccamel.github.io/playground-elm/index.html)

> My playground I use for playing with fancy and exciting technologies. This one's for [elm].

## Purpose

The purpose of this playground is to explore, study and assess the [elm] language.

## Demo site

Visit the :small_blue_diamond: [demo site](https://ccamel.github.io/playground-elm/index.html) and play in your browser. The demo is a pure [SPA]  (100% clientside application) written in [elm].

## Building and Running

As the project is generated from [elm-app](https://github.com/tom76kimo/generator-elm-app#readme) generator, more help can be found in the github of that project; even if a lot of changes have been made.

At first, all the node packages this project depends on must be installed locally. This can be done with the following command:

```bash
yarn
```

The build can be launched with:

```bash
yarn build
```

Then, open `./dist/index.html` file in your browser.

If you prefer, the site can be published by a local HTTP server. In this mode, if any change is detected, the build of the project will be started again, and the site automatically updated in the browser; which is nice during the development phases.

The publication is launched with the following command:

```bash
yarn serve
```

The site is accessible through the `http://localhost:3000/` endpoint.

## Technologies

[![elm-logo][elm-logo]][elm] ELM language

## License

[MIT] © [Chris Camel]

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fccamel%2Fplayground-elm?ref=badge_large)

[elm]: http://elm-lang.org/

[elm-logo]: doc/assets/logo-elm.png

[SPA]: https://en.wikipedia.org/wiki/Single-page_application

[Chris Camel]: https://github.com/ccamel
[MIT]: https://tldrlegal.com/license/mit-license
