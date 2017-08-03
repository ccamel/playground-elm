/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__(1);


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

	'use strict';

	__webpack_require__(2);
	__webpack_require__(6);
	__webpack_require__(14);
	__webpack_require__(16);

	var Elm = __webpack_require__(17);
	var mountNode = document.getElementById('main');

	var app = Elm.Main.embed(mountNode);


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

	// style-loader: Adds some css to the DOM by adding a <style> tag

	// load the styles
	var content = __webpack_require__(3);
	if(typeof content === 'string') content = [[module.id, content, '']];
	// add the styles to the DOM
	var update = __webpack_require__(5)(content, {});
	if(content.locals) module.exports = content.locals;
	// Hot Module Replacement
	if(false) {
		// When the styles change, update the <style> tags
		if(!content.locals) {
			module.hot.accept("!!../../../css-loader/index.js!./bootstrap.css", function() {
				var newContent = require("!!../../../css-loader/index.js!./bootstrap.css");
				if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];
				update(newContent);
			});
		}
		// When the module is disposed, remove the <style> tags
		module.hot.dispose(function() { update(); });
	}

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

	exports = module.exports = __webpack_require__(4)();
	// imports


	// module
	exports.push([module.id, "/*!\n * Bootstrap v4.0.0-alpha.6 (https://getbootstrap.com)\n * Copyright 2011-2017 The Bootstrap Authors\n * Copyright 2011-2017 Twitter, Inc.\n * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)\n */\n/*! normalize.css v5.0.0 | MIT License | github.com/necolas/normalize.css */\nhtml {\n  font-family: sans-serif;\n  line-height: 1.15;\n  -ms-text-size-adjust: 100%;\n  -webkit-text-size-adjust: 100%;\n}\n\nbody {\n  margin: 0;\n}\n\narticle,\naside,\nfooter,\nheader,\nnav,\nsection {\n  display: block;\n}\n\nh1 {\n  font-size: 2em;\n  margin: 0.67em 0;\n}\n\nfigcaption,\nfigure,\nmain {\n  display: block;\n}\n\nfigure {\n  margin: 1em 40px;\n}\n\nhr {\n  -webkit-box-sizing: content-box;\n          box-sizing: content-box;\n  height: 0;\n  overflow: visible;\n}\n\npre {\n  font-family: monospace, monospace;\n  font-size: 1em;\n}\n\na {\n  background-color: transparent;\n  -webkit-text-decoration-skip: objects;\n}\n\na:active,\na:hover {\n  outline-width: 0;\n}\n\nabbr[title] {\n  border-bottom: none;\n  text-decoration: underline;\n  text-decoration: underline dotted;\n}\n\nb,\nstrong {\n  font-weight: inherit;\n}\n\nb,\nstrong {\n  font-weight: bolder;\n}\n\ncode,\nkbd,\nsamp {\n  font-family: monospace, monospace;\n  font-size: 1em;\n}\n\ndfn {\n  font-style: italic;\n}\n\nmark {\n  background-color: #ff0;\n  color: #000;\n}\n\nsmall {\n  font-size: 80%;\n}\n\nsub,\nsup {\n  font-size: 75%;\n  line-height: 0;\n  position: relative;\n  vertical-align: baseline;\n}\n\nsub {\n  bottom: -0.25em;\n}\n\nsup {\n  top: -0.5em;\n}\n\naudio,\nvideo {\n  display: inline-block;\n}\n\naudio:not([controls]) {\n  display: none;\n  height: 0;\n}\n\nimg {\n  border-style: none;\n}\n\nsvg:not(:root) {\n  overflow: hidden;\n}\n\nbutton,\ninput,\noptgroup,\nselect,\ntextarea {\n  font-family: sans-serif;\n  font-size: 100%;\n  line-height: 1.15;\n  margin: 0;\n}\n\nbutton,\ninput {\n  overflow: visible;\n}\n\nbutton,\nselect {\n  text-transform: none;\n}\n\nbutton,\nhtml [type=\"button\"],\n[type=\"reset\"],\n[type=\"submit\"] {\n  -webkit-appearance: button;\n}\n\nbutton::-moz-focus-inner,\n[type=\"button\"]::-moz-focus-inner,\n[type=\"reset\"]::-moz-focus-inner,\n[type=\"submit\"]::-moz-focus-inner {\n  border-style: none;\n  padding: 0;\n}\n\nbutton:-moz-focusring,\n[type=\"button\"]:-moz-focusring,\n[type=\"reset\"]:-moz-focusring,\n[type=\"submit\"]:-moz-focusring {\n  outline: 1px dotted ButtonText;\n}\n\nfieldset {\n  border: 1px solid #c0c0c0;\n  margin: 0 2px;\n  padding: 0.35em 0.625em 0.75em;\n}\n\nlegend {\n  -webkit-box-sizing: border-box;\n          box-sizing: border-box;\n  color: inherit;\n  display: table;\n  max-width: 100%;\n  padding: 0;\n  white-space: normal;\n}\n\nprogress {\n  display: inline-block;\n  vertical-align: baseline;\n}\n\ntextarea {\n  overflow: auto;\n}\n\n[type=\"checkbox\"],\n[type=\"radio\"] {\n  -webkit-box-sizing: border-box;\n          box-sizing: border-box;\n  padding: 0;\n}\n\n[type=\"number\"]::-webkit-inner-spin-button,\n[type=\"number\"]::-webkit-outer-spin-button {\n  height: auto;\n}\n\n[type=\"search\"] {\n  -webkit-appearance: textfield;\n  outline-offset: -2px;\n}\n\n[type=\"search\"]::-webkit-search-cancel-button,\n[type=\"search\"]::-webkit-search-decoration {\n  -webkit-appearance: none;\n}\n\n::-webkit-file-upload-button {\n  -webkit-appearance: button;\n  font: inherit;\n}\n\ndetails,\nmenu {\n  display: block;\n}\n\nsummary {\n  display: list-item;\n}\n\ncanvas {\n  display: inline-block;\n}\n\ntemplate {\n  display: none;\n}\n\n[hidden] {\n  display: none;\n}\n\n@media print {\n  *,\n  *::before,\n  *::after,\n  p::first-letter,\n  div::first-letter,\n  blockquote::first-letter,\n  li::first-letter,\n  p::first-line,\n  div::first-line,\n  blockquote::first-line,\n  li::first-line {\n    text-shadow: none !important;\n    -webkit-box-shadow: none !important;\n            box-shadow: none !important;\n  }\n  a,\n  a:visited {\n    text-decoration: underline;\n  }\n  abbr[title]::after {\n    content: \" (\" attr(title) \")\";\n  }\n  pre {\n    white-space: pre-wrap !important;\n  }\n  pre,\n  blockquote {\n    border: 1px solid #999;\n    page-break-inside: avoid;\n  }\n  thead {\n    display: table-header-group;\n  }\n  tr,\n  img {\n    page-break-inside: avoid;\n  }\n  p,\n  h2,\n  h3 {\n    orphans: 3;\n    widows: 3;\n  }\n  h2,\n  h3 {\n    page-break-after: avoid;\n  }\n  .navbar {\n    display: none;\n  }\n  .badge {\n    border: 1px solid #000;\n  }\n  .table {\n    border-collapse: collapse !important;\n  }\n  .table td,\n  .table th {\n    background-color: #fff !important;\n  }\n  .table-bordered th,\n  .table-bordered td {\n    border: 1px solid #ddd !important;\n  }\n}\n\nhtml {\n  -webkit-box-sizing: border-box;\n          box-sizing: border-box;\n}\n\n*,\n*::before,\n*::after {\n  -webkit-box-sizing: inherit;\n          box-sizing: inherit;\n}\n\n@-ms-viewport {\n  width: device-width;\n}\n\nhtml {\n  -ms-overflow-style: scrollbar;\n  -webkit-tap-highlight-color: transparent;\n}\n\nbody {\n  font-family: -apple-system, system-ui, BlinkMacSystemFont, \"Segoe UI\", Roboto, \"Helvetica Neue\", Arial, sans-serif;\n  font-size: 1rem;\n  font-weight: normal;\n  line-height: 1.5;\n  color: #292b2c;\n  background-color: #fff;\n}\n\n[tabindex=\"-1\"]:focus {\n  outline: none !important;\n}\n\nh1, h2, h3, h4, h5, h6 {\n  margin-top: 0;\n  margin-bottom: .5rem;\n}\n\np {\n  margin-top: 0;\n  margin-bottom: 1rem;\n}\n\nabbr[title],\nabbr[data-original-title] {\n  cursor: help;\n}\n\naddress {\n  margin-bottom: 1rem;\n  font-style: normal;\n  line-height: inherit;\n}\n\nol,\nul,\ndl {\n  margin-top: 0;\n  margin-bottom: 1rem;\n}\n\nol ol,\nul ul,\nol ul,\nul ol {\n  margin-bottom: 0;\n}\n\ndt {\n  font-weight: bold;\n}\n\ndd {\n  margin-bottom: .5rem;\n  margin-left: 0;\n}\n\nblockquote {\n  margin: 0 0 1rem;\n}\n\na {\n  color: #0275d8;\n  text-decoration: none;\n}\n\na:focus, a:hover {\n  color: #014c8c;\n  text-decoration: underline;\n}\n\na:not([href]):not([tabindex]) {\n  color: inherit;\n  text-decoration: none;\n}\n\na:not([href]):not([tabindex]):focus, a:not([href]):not([tabindex]):hover {\n  color: inherit;\n  text-decoration: none;\n}\n\na:not([href]):not([tabindex]):focus {\n  outline: 0;\n}\n\npre {\n  margin-top: 0;\n  margin-bottom: 1rem;\n  overflow: auto;\n}\n\nfigure {\n  margin: 0 0 1rem;\n}\n\nimg {\n  vertical-align: middle;\n}\n\n[role=\"button\"] {\n  cursor: pointer;\n}\n\na,\narea,\nbutton,\n[role=\"button\"],\ninput,\nlabel,\nselect,\nsummary,\ntextarea {\n  -ms-touch-action: manipulation;\n      touch-action: manipulation;\n}\n\ntable {\n  border-collapse: collapse;\n  background-color: transparent;\n}\n\ncaption {\n  padding-top: 0.75rem;\n  padding-bottom: 0.75rem;\n  color: #636c72;\n  text-align: left;\n  caption-side: bottom;\n}\n\nth {\n  text-align: left;\n}\n\nlabel {\n  display: inline-block;\n  margin-bottom: .5rem;\n}\n\nbutton:focus {\n  outline: 1px dotted;\n  outline: 5px auto -webkit-focus-ring-color;\n}\n\ninput,\nbutton,\nselect,\ntextarea {\n  line-height: inherit;\n}\n\ninput[type=\"radio\"]:disabled,\ninput[type=\"checkbox\"]:disabled {\n  cursor: not-allowed;\n}\n\ninput[type=\"date\"],\ninput[type=\"time\"],\ninput[type=\"datetime-local\"],\ninput[type=\"month\"] {\n  -webkit-appearance: listbox;\n}\n\ntextarea {\n  resize: vertical;\n}\n\nfieldset {\n  min-width: 0;\n  padding: 0;\n  margin: 0;\n  border: 0;\n}\n\nlegend {\n  display: block;\n  width: 100%;\n  padding: 0;\n  margin-bottom: .5rem;\n  font-size: 1.5rem;\n  line-height: inherit;\n}\n\ninput[type=\"search\"] {\n  -webkit-appearance: none;\n}\n\noutput {\n  display: inline-block;\n}\n\n[hidden] {\n  display: none !important;\n}\n\nh1, h2, h3, h4, h5, h6,\n.h1, .h2, .h3, .h4, .h5, .h6 {\n  margin-bottom: 0.5rem;\n  font-family: inherit;\n  font-weight: 500;\n  line-height: 1.1;\n  color: inherit;\n}\n\nh1, .h1 {\n  font-size: 2.5rem;\n}\n\nh2, .h2 {\n  font-size: 2rem;\n}\n\nh3, .h3 {\n  font-size: 1.75rem;\n}\n\nh4, .h4 {\n  font-size: 1.5rem;\n}\n\nh5, .h5 {\n  font-size: 1.25rem;\n}\n\nh6, .h6 {\n  font-size: 1rem;\n}\n\n.lead {\n  font-size: 1.25rem;\n  font-weight: 300;\n}\n\n.display-1 {\n  font-size: 6rem;\n  font-weight: 300;\n  line-height: 1.1;\n}\n\n.display-2 {\n  font-size: 5.5rem;\n  font-weight: 300;\n  line-height: 1.1;\n}\n\n.display-3 {\n  font-size: 4.5rem;\n  font-weight: 300;\n  line-height: 1.1;\n}\n\n.display-4 {\n  font-size: 3.5rem;\n  font-weight: 300;\n  line-height: 1.1;\n}\n\nhr {\n  margin-top: 1rem;\n  margin-bottom: 1rem;\n  border: 0;\n  border-top: 1px solid rgba(0, 0, 0, 0.1);\n}\n\nsmall,\n.small {\n  font-size: 80%;\n  font-weight: normal;\n}\n\nmark,\n.mark {\n  padding: 0.2em;\n  background-color: #fcf8e3;\n}\n\n.list-unstyled {\n  padding-left: 0;\n  list-style: none;\n}\n\n.list-inline {\n  padding-left: 0;\n  list-style: none;\n}\n\n.list-inline-item {\n  display: inline-block;\n}\n\n.list-inline-item:not(:last-child) {\n  margin-right: 5px;\n}\n\n.initialism {\n  font-size: 90%;\n  text-transform: uppercase;\n}\n\n.blockquote {\n  padding: 0.5rem 1rem;\n  margin-bottom: 1rem;\n  font-size: 1.25rem;\n  border-left: 0.25rem solid #eceeef;\n}\n\n.blockquote-footer {\n  display: block;\n  font-size: 80%;\n  color: #636c72;\n}\n\n.blockquote-footer::before {\n  content: \"\\2014   \\A0\";\n}\n\n.blockquote-reverse {\n  padding-right: 1rem;\n  padding-left: 0;\n  text-align: right;\n  border-right: 0.25rem solid #eceeef;\n  border-left: 0;\n}\n\n.blockquote-reverse .blockquote-footer::before {\n  content: \"\";\n}\n\n.blockquote-reverse .blockquote-footer::after {\n  content: \"\\A0   \\2014\";\n}\n\n.img-fluid {\n  max-width: 100%;\n  height: auto;\n}\n\n.img-thumbnail {\n  padding: 0.25rem;\n  background-color: #fff;\n  border: 1px solid #ddd;\n  border-radius: 0.25rem;\n  -webkit-transition: all 0.2s ease-in-out;\n  -o-transition: all 0.2s ease-in-out;\n  transition: all 0.2s ease-in-out;\n  max-width: 100%;\n  height: auto;\n}\n\n.figure {\n  display: inline-block;\n}\n\n.figure-img {\n  margin-bottom: 0.5rem;\n  line-height: 1;\n}\n\n.figure-caption {\n  font-size: 90%;\n  color: #636c72;\n}\n\ncode,\nkbd,\npre,\nsamp {\n  font-family: Menlo, Monaco, Consolas, \"Liberation Mono\", \"Courier New\", monospace;\n}\n\ncode {\n  padding: 0.2rem 0.4rem;\n  font-size: 90%;\n  color: #bd4147;\n  background-color: #f7f7f9;\n  border-radius: 0.25rem;\n}\n\na > code {\n  padding: 0;\n  color: inherit;\n  background-color: inherit;\n}\n\nkbd {\n  padding: 0.2rem 0.4rem;\n  font-size: 90%;\n  color: #fff;\n  background-color: #292b2c;\n  border-radius: 0.2rem;\n}\n\nkbd kbd {\n  padding: 0;\n  font-size: 100%;\n  font-weight: bold;\n}\n\npre {\n  display: block;\n  margin-top: 0;\n  margin-bottom: 1rem;\n  font-size: 90%;\n  color: #292b2c;\n}\n\npre code {\n  padding: 0;\n  font-size: inherit;\n  color: inherit;\n  background-color: transparent;\n  border-radius: 0;\n}\n\n.pre-scrollable {\n  max-height: 340px;\n  overflow-y: scroll;\n}\n\n.container {\n  position: relative;\n  margin-left: auto;\n  margin-right: auto;\n  padding-right: 15px;\n  padding-left: 15px;\n}\n\n@media (min-width: 576px) {\n  .container {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 768px) {\n  .container {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 992px) {\n  .container {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 1200px) {\n  .container {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 576px) {\n  .container {\n    width: 540px;\n    max-width: 100%;\n  }\n}\n\n@media (min-width: 768px) {\n  .container {\n    width: 720px;\n    max-width: 100%;\n  }\n}\n\n@media (min-width: 992px) {\n  .container {\n    width: 960px;\n    max-width: 100%;\n  }\n}\n\n@media (min-width: 1200px) {\n  .container {\n    width: 1140px;\n    max-width: 100%;\n  }\n}\n\n.container-fluid {\n  position: relative;\n  margin-left: auto;\n  margin-right: auto;\n  padding-right: 15px;\n  padding-left: 15px;\n}\n\n@media (min-width: 576px) {\n  .container-fluid {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 768px) {\n  .container-fluid {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 992px) {\n  .container-fluid {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 1200px) {\n  .container-fluid {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n.row {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-flex-wrap: wrap;\n      -ms-flex-wrap: wrap;\n          flex-wrap: wrap;\n  margin-right: -15px;\n  margin-left: -15px;\n}\n\n@media (min-width: 576px) {\n  .row {\n    margin-right: -15px;\n    margin-left: -15px;\n  }\n}\n\n@media (min-width: 768px) {\n  .row {\n    margin-right: -15px;\n    margin-left: -15px;\n  }\n}\n\n@media (min-width: 992px) {\n  .row {\n    margin-right: -15px;\n    margin-left: -15px;\n  }\n}\n\n@media (min-width: 1200px) {\n  .row {\n    margin-right: -15px;\n    margin-left: -15px;\n  }\n}\n\n.no-gutters {\n  margin-right: 0;\n  margin-left: 0;\n}\n\n.no-gutters > .col,\n.no-gutters > [class*=\"col-\"] {\n  padding-right: 0;\n  padding-left: 0;\n}\n\n.col-1, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-10, .col-11, .col-12, .col, .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm, .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12, .col-md, .col-lg-1, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg, .col-xl-1, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl {\n  position: relative;\n  width: 100%;\n  min-height: 1px;\n  padding-right: 15px;\n  padding-left: 15px;\n}\n\n@media (min-width: 576px) {\n  .col-1, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-10, .col-11, .col-12, .col, .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm, .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12, .col-md, .col-lg-1, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg, .col-xl-1, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 768px) {\n  .col-1, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-10, .col-11, .col-12, .col, .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm, .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12, .col-md, .col-lg-1, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg, .col-xl-1, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 992px) {\n  .col-1, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-10, .col-11, .col-12, .col, .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm, .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12, .col-md, .col-lg-1, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg, .col-xl-1, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n@media (min-width: 1200px) {\n  .col-1, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-10, .col-11, .col-12, .col, .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm, .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12, .col-md, .col-lg-1, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg, .col-xl-1, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl {\n    padding-right: 15px;\n    padding-left: 15px;\n  }\n}\n\n.col {\n  -webkit-flex-basis: 0;\n      -ms-flex-preferred-size: 0;\n          flex-basis: 0;\n  -webkit-box-flex: 1;\n  -webkit-flex-grow: 1;\n      -ms-flex-positive: 1;\n          flex-grow: 1;\n  max-width: 100%;\n}\n\n.col-auto {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 auto;\n      -ms-flex: 0 0 auto;\n          flex: 0 0 auto;\n  width: auto;\n}\n\n.col-1 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 8.333333%;\n      -ms-flex: 0 0 8.333333%;\n          flex: 0 0 8.333333%;\n  max-width: 8.333333%;\n}\n\n.col-2 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 16.666667%;\n      -ms-flex: 0 0 16.666667%;\n          flex: 0 0 16.666667%;\n  max-width: 16.666667%;\n}\n\n.col-3 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 25%;\n      -ms-flex: 0 0 25%;\n          flex: 0 0 25%;\n  max-width: 25%;\n}\n\n.col-4 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 33.333333%;\n      -ms-flex: 0 0 33.333333%;\n          flex: 0 0 33.333333%;\n  max-width: 33.333333%;\n}\n\n.col-5 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 41.666667%;\n      -ms-flex: 0 0 41.666667%;\n          flex: 0 0 41.666667%;\n  max-width: 41.666667%;\n}\n\n.col-6 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 50%;\n      -ms-flex: 0 0 50%;\n          flex: 0 0 50%;\n  max-width: 50%;\n}\n\n.col-7 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 58.333333%;\n      -ms-flex: 0 0 58.333333%;\n          flex: 0 0 58.333333%;\n  max-width: 58.333333%;\n}\n\n.col-8 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 66.666667%;\n      -ms-flex: 0 0 66.666667%;\n          flex: 0 0 66.666667%;\n  max-width: 66.666667%;\n}\n\n.col-9 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 75%;\n      -ms-flex: 0 0 75%;\n          flex: 0 0 75%;\n  max-width: 75%;\n}\n\n.col-10 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 83.333333%;\n      -ms-flex: 0 0 83.333333%;\n          flex: 0 0 83.333333%;\n  max-width: 83.333333%;\n}\n\n.col-11 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 91.666667%;\n      -ms-flex: 0 0 91.666667%;\n          flex: 0 0 91.666667%;\n  max-width: 91.666667%;\n}\n\n.col-12 {\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 0 100%;\n      -ms-flex: 0 0 100%;\n          flex: 0 0 100%;\n  max-width: 100%;\n}\n\n.pull-0 {\n  right: auto;\n}\n\n.pull-1 {\n  right: 8.333333%;\n}\n\n.pull-2 {\n  right: 16.666667%;\n}\n\n.pull-3 {\n  right: 25%;\n}\n\n.pull-4 {\n  right: 33.333333%;\n}\n\n.pull-5 {\n  right: 41.666667%;\n}\n\n.pull-6 {\n  right: 50%;\n}\n\n.pull-7 {\n  right: 58.333333%;\n}\n\n.pull-8 {\n  right: 66.666667%;\n}\n\n.pull-9 {\n  right: 75%;\n}\n\n.pull-10 {\n  right: 83.333333%;\n}\n\n.pull-11 {\n  right: 91.666667%;\n}\n\n.pull-12 {\n  right: 100%;\n}\n\n.push-0 {\n  left: auto;\n}\n\n.push-1 {\n  left: 8.333333%;\n}\n\n.push-2 {\n  left: 16.666667%;\n}\n\n.push-3 {\n  left: 25%;\n}\n\n.push-4 {\n  left: 33.333333%;\n}\n\n.push-5 {\n  left: 41.666667%;\n}\n\n.push-6 {\n  left: 50%;\n}\n\n.push-7 {\n  left: 58.333333%;\n}\n\n.push-8 {\n  left: 66.666667%;\n}\n\n.push-9 {\n  left: 75%;\n}\n\n.push-10 {\n  left: 83.333333%;\n}\n\n.push-11 {\n  left: 91.666667%;\n}\n\n.push-12 {\n  left: 100%;\n}\n\n.offset-1 {\n  margin-left: 8.333333%;\n}\n\n.offset-2 {\n  margin-left: 16.666667%;\n}\n\n.offset-3 {\n  margin-left: 25%;\n}\n\n.offset-4 {\n  margin-left: 33.333333%;\n}\n\n.offset-5 {\n  margin-left: 41.666667%;\n}\n\n.offset-6 {\n  margin-left: 50%;\n}\n\n.offset-7 {\n  margin-left: 58.333333%;\n}\n\n.offset-8 {\n  margin-left: 66.666667%;\n}\n\n.offset-9 {\n  margin-left: 75%;\n}\n\n.offset-10 {\n  margin-left: 83.333333%;\n}\n\n.offset-11 {\n  margin-left: 91.666667%;\n}\n\n@media (min-width: 576px) {\n  .col-sm {\n    -webkit-flex-basis: 0;\n        -ms-flex-preferred-size: 0;\n            flex-basis: 0;\n    -webkit-box-flex: 1;\n    -webkit-flex-grow: 1;\n        -ms-flex-positive: 1;\n            flex-grow: 1;\n    max-width: 100%;\n  }\n  .col-sm-auto {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 auto;\n        -ms-flex: 0 0 auto;\n            flex: 0 0 auto;\n    width: auto;\n  }\n  .col-sm-1 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 8.333333%;\n        -ms-flex: 0 0 8.333333%;\n            flex: 0 0 8.333333%;\n    max-width: 8.333333%;\n  }\n  .col-sm-2 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 16.666667%;\n        -ms-flex: 0 0 16.666667%;\n            flex: 0 0 16.666667%;\n    max-width: 16.666667%;\n  }\n  .col-sm-3 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 25%;\n        -ms-flex: 0 0 25%;\n            flex: 0 0 25%;\n    max-width: 25%;\n  }\n  .col-sm-4 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 33.333333%;\n        -ms-flex: 0 0 33.333333%;\n            flex: 0 0 33.333333%;\n    max-width: 33.333333%;\n  }\n  .col-sm-5 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 41.666667%;\n        -ms-flex: 0 0 41.666667%;\n            flex: 0 0 41.666667%;\n    max-width: 41.666667%;\n  }\n  .col-sm-6 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 50%;\n        -ms-flex: 0 0 50%;\n            flex: 0 0 50%;\n    max-width: 50%;\n  }\n  .col-sm-7 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 58.333333%;\n        -ms-flex: 0 0 58.333333%;\n            flex: 0 0 58.333333%;\n    max-width: 58.333333%;\n  }\n  .col-sm-8 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 66.666667%;\n        -ms-flex: 0 0 66.666667%;\n            flex: 0 0 66.666667%;\n    max-width: 66.666667%;\n  }\n  .col-sm-9 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 75%;\n        -ms-flex: 0 0 75%;\n            flex: 0 0 75%;\n    max-width: 75%;\n  }\n  .col-sm-10 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 83.333333%;\n        -ms-flex: 0 0 83.333333%;\n            flex: 0 0 83.333333%;\n    max-width: 83.333333%;\n  }\n  .col-sm-11 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 91.666667%;\n        -ms-flex: 0 0 91.666667%;\n            flex: 0 0 91.666667%;\n    max-width: 91.666667%;\n  }\n  .col-sm-12 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 100%;\n        -ms-flex: 0 0 100%;\n            flex: 0 0 100%;\n    max-width: 100%;\n  }\n  .pull-sm-0 {\n    right: auto;\n  }\n  .pull-sm-1 {\n    right: 8.333333%;\n  }\n  .pull-sm-2 {\n    right: 16.666667%;\n  }\n  .pull-sm-3 {\n    right: 25%;\n  }\n  .pull-sm-4 {\n    right: 33.333333%;\n  }\n  .pull-sm-5 {\n    right: 41.666667%;\n  }\n  .pull-sm-6 {\n    right: 50%;\n  }\n  .pull-sm-7 {\n    right: 58.333333%;\n  }\n  .pull-sm-8 {\n    right: 66.666667%;\n  }\n  .pull-sm-9 {\n    right: 75%;\n  }\n  .pull-sm-10 {\n    right: 83.333333%;\n  }\n  .pull-sm-11 {\n    right: 91.666667%;\n  }\n  .pull-sm-12 {\n    right: 100%;\n  }\n  .push-sm-0 {\n    left: auto;\n  }\n  .push-sm-1 {\n    left: 8.333333%;\n  }\n  .push-sm-2 {\n    left: 16.666667%;\n  }\n  .push-sm-3 {\n    left: 25%;\n  }\n  .push-sm-4 {\n    left: 33.333333%;\n  }\n  .push-sm-5 {\n    left: 41.666667%;\n  }\n  .push-sm-6 {\n    left: 50%;\n  }\n  .push-sm-7 {\n    left: 58.333333%;\n  }\n  .push-sm-8 {\n    left: 66.666667%;\n  }\n  .push-sm-9 {\n    left: 75%;\n  }\n  .push-sm-10 {\n    left: 83.333333%;\n  }\n  .push-sm-11 {\n    left: 91.666667%;\n  }\n  .push-sm-12 {\n    left: 100%;\n  }\n  .offset-sm-0 {\n    margin-left: 0%;\n  }\n  .offset-sm-1 {\n    margin-left: 8.333333%;\n  }\n  .offset-sm-2 {\n    margin-left: 16.666667%;\n  }\n  .offset-sm-3 {\n    margin-left: 25%;\n  }\n  .offset-sm-4 {\n    margin-left: 33.333333%;\n  }\n  .offset-sm-5 {\n    margin-left: 41.666667%;\n  }\n  .offset-sm-6 {\n    margin-left: 50%;\n  }\n  .offset-sm-7 {\n    margin-left: 58.333333%;\n  }\n  .offset-sm-8 {\n    margin-left: 66.666667%;\n  }\n  .offset-sm-9 {\n    margin-left: 75%;\n  }\n  .offset-sm-10 {\n    margin-left: 83.333333%;\n  }\n  .offset-sm-11 {\n    margin-left: 91.666667%;\n  }\n}\n\n@media (min-width: 768px) {\n  .col-md {\n    -webkit-flex-basis: 0;\n        -ms-flex-preferred-size: 0;\n            flex-basis: 0;\n    -webkit-box-flex: 1;\n    -webkit-flex-grow: 1;\n        -ms-flex-positive: 1;\n            flex-grow: 1;\n    max-width: 100%;\n  }\n  .col-md-auto {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 auto;\n        -ms-flex: 0 0 auto;\n            flex: 0 0 auto;\n    width: auto;\n  }\n  .col-md-1 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 8.333333%;\n        -ms-flex: 0 0 8.333333%;\n            flex: 0 0 8.333333%;\n    max-width: 8.333333%;\n  }\n  .col-md-2 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 16.666667%;\n        -ms-flex: 0 0 16.666667%;\n            flex: 0 0 16.666667%;\n    max-width: 16.666667%;\n  }\n  .col-md-3 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 25%;\n        -ms-flex: 0 0 25%;\n            flex: 0 0 25%;\n    max-width: 25%;\n  }\n  .col-md-4 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 33.333333%;\n        -ms-flex: 0 0 33.333333%;\n            flex: 0 0 33.333333%;\n    max-width: 33.333333%;\n  }\n  .col-md-5 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 41.666667%;\n        -ms-flex: 0 0 41.666667%;\n            flex: 0 0 41.666667%;\n    max-width: 41.666667%;\n  }\n  .col-md-6 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 50%;\n        -ms-flex: 0 0 50%;\n            flex: 0 0 50%;\n    max-width: 50%;\n  }\n  .col-md-7 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 58.333333%;\n        -ms-flex: 0 0 58.333333%;\n            flex: 0 0 58.333333%;\n    max-width: 58.333333%;\n  }\n  .col-md-8 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 66.666667%;\n        -ms-flex: 0 0 66.666667%;\n            flex: 0 0 66.666667%;\n    max-width: 66.666667%;\n  }\n  .col-md-9 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 75%;\n        -ms-flex: 0 0 75%;\n            flex: 0 0 75%;\n    max-width: 75%;\n  }\n  .col-md-10 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 83.333333%;\n        -ms-flex: 0 0 83.333333%;\n            flex: 0 0 83.333333%;\n    max-width: 83.333333%;\n  }\n  .col-md-11 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 91.666667%;\n        -ms-flex: 0 0 91.666667%;\n            flex: 0 0 91.666667%;\n    max-width: 91.666667%;\n  }\n  .col-md-12 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 100%;\n        -ms-flex: 0 0 100%;\n            flex: 0 0 100%;\n    max-width: 100%;\n  }\n  .pull-md-0 {\n    right: auto;\n  }\n  .pull-md-1 {\n    right: 8.333333%;\n  }\n  .pull-md-2 {\n    right: 16.666667%;\n  }\n  .pull-md-3 {\n    right: 25%;\n  }\n  .pull-md-4 {\n    right: 33.333333%;\n  }\n  .pull-md-5 {\n    right: 41.666667%;\n  }\n  .pull-md-6 {\n    right: 50%;\n  }\n  .pull-md-7 {\n    right: 58.333333%;\n  }\n  .pull-md-8 {\n    right: 66.666667%;\n  }\n  .pull-md-9 {\n    right: 75%;\n  }\n  .pull-md-10 {\n    right: 83.333333%;\n  }\n  .pull-md-11 {\n    right: 91.666667%;\n  }\n  .pull-md-12 {\n    right: 100%;\n  }\n  .push-md-0 {\n    left: auto;\n  }\n  .push-md-1 {\n    left: 8.333333%;\n  }\n  .push-md-2 {\n    left: 16.666667%;\n  }\n  .push-md-3 {\n    left: 25%;\n  }\n  .push-md-4 {\n    left: 33.333333%;\n  }\n  .push-md-5 {\n    left: 41.666667%;\n  }\n  .push-md-6 {\n    left: 50%;\n  }\n  .push-md-7 {\n    left: 58.333333%;\n  }\n  .push-md-8 {\n    left: 66.666667%;\n  }\n  .push-md-9 {\n    left: 75%;\n  }\n  .push-md-10 {\n    left: 83.333333%;\n  }\n  .push-md-11 {\n    left: 91.666667%;\n  }\n  .push-md-12 {\n    left: 100%;\n  }\n  .offset-md-0 {\n    margin-left: 0%;\n  }\n  .offset-md-1 {\n    margin-left: 8.333333%;\n  }\n  .offset-md-2 {\n    margin-left: 16.666667%;\n  }\n  .offset-md-3 {\n    margin-left: 25%;\n  }\n  .offset-md-4 {\n    margin-left: 33.333333%;\n  }\n  .offset-md-5 {\n    margin-left: 41.666667%;\n  }\n  .offset-md-6 {\n    margin-left: 50%;\n  }\n  .offset-md-7 {\n    margin-left: 58.333333%;\n  }\n  .offset-md-8 {\n    margin-left: 66.666667%;\n  }\n  .offset-md-9 {\n    margin-left: 75%;\n  }\n  .offset-md-10 {\n    margin-left: 83.333333%;\n  }\n  .offset-md-11 {\n    margin-left: 91.666667%;\n  }\n}\n\n@media (min-width: 992px) {\n  .col-lg {\n    -webkit-flex-basis: 0;\n        -ms-flex-preferred-size: 0;\n            flex-basis: 0;\n    -webkit-box-flex: 1;\n    -webkit-flex-grow: 1;\n        -ms-flex-positive: 1;\n            flex-grow: 1;\n    max-width: 100%;\n  }\n  .col-lg-auto {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 auto;\n        -ms-flex: 0 0 auto;\n            flex: 0 0 auto;\n    width: auto;\n  }\n  .col-lg-1 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 8.333333%;\n        -ms-flex: 0 0 8.333333%;\n            flex: 0 0 8.333333%;\n    max-width: 8.333333%;\n  }\n  .col-lg-2 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 16.666667%;\n        -ms-flex: 0 0 16.666667%;\n            flex: 0 0 16.666667%;\n    max-width: 16.666667%;\n  }\n  .col-lg-3 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 25%;\n        -ms-flex: 0 0 25%;\n            flex: 0 0 25%;\n    max-width: 25%;\n  }\n  .col-lg-4 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 33.333333%;\n        -ms-flex: 0 0 33.333333%;\n            flex: 0 0 33.333333%;\n    max-width: 33.333333%;\n  }\n  .col-lg-5 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 41.666667%;\n        -ms-flex: 0 0 41.666667%;\n            flex: 0 0 41.666667%;\n    max-width: 41.666667%;\n  }\n  .col-lg-6 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 50%;\n        -ms-flex: 0 0 50%;\n            flex: 0 0 50%;\n    max-width: 50%;\n  }\n  .col-lg-7 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 58.333333%;\n        -ms-flex: 0 0 58.333333%;\n            flex: 0 0 58.333333%;\n    max-width: 58.333333%;\n  }\n  .col-lg-8 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 66.666667%;\n        -ms-flex: 0 0 66.666667%;\n            flex: 0 0 66.666667%;\n    max-width: 66.666667%;\n  }\n  .col-lg-9 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 75%;\n        -ms-flex: 0 0 75%;\n            flex: 0 0 75%;\n    max-width: 75%;\n  }\n  .col-lg-10 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 83.333333%;\n        -ms-flex: 0 0 83.333333%;\n            flex: 0 0 83.333333%;\n    max-width: 83.333333%;\n  }\n  .col-lg-11 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 91.666667%;\n        -ms-flex: 0 0 91.666667%;\n            flex: 0 0 91.666667%;\n    max-width: 91.666667%;\n  }\n  .col-lg-12 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 100%;\n        -ms-flex: 0 0 100%;\n            flex: 0 0 100%;\n    max-width: 100%;\n  }\n  .pull-lg-0 {\n    right: auto;\n  }\n  .pull-lg-1 {\n    right: 8.333333%;\n  }\n  .pull-lg-2 {\n    right: 16.666667%;\n  }\n  .pull-lg-3 {\n    right: 25%;\n  }\n  .pull-lg-4 {\n    right: 33.333333%;\n  }\n  .pull-lg-5 {\n    right: 41.666667%;\n  }\n  .pull-lg-6 {\n    right: 50%;\n  }\n  .pull-lg-7 {\n    right: 58.333333%;\n  }\n  .pull-lg-8 {\n    right: 66.666667%;\n  }\n  .pull-lg-9 {\n    right: 75%;\n  }\n  .pull-lg-10 {\n    right: 83.333333%;\n  }\n  .pull-lg-11 {\n    right: 91.666667%;\n  }\n  .pull-lg-12 {\n    right: 100%;\n  }\n  .push-lg-0 {\n    left: auto;\n  }\n  .push-lg-1 {\n    left: 8.333333%;\n  }\n  .push-lg-2 {\n    left: 16.666667%;\n  }\n  .push-lg-3 {\n    left: 25%;\n  }\n  .push-lg-4 {\n    left: 33.333333%;\n  }\n  .push-lg-5 {\n    left: 41.666667%;\n  }\n  .push-lg-6 {\n    left: 50%;\n  }\n  .push-lg-7 {\n    left: 58.333333%;\n  }\n  .push-lg-8 {\n    left: 66.666667%;\n  }\n  .push-lg-9 {\n    left: 75%;\n  }\n  .push-lg-10 {\n    left: 83.333333%;\n  }\n  .push-lg-11 {\n    left: 91.666667%;\n  }\n  .push-lg-12 {\n    left: 100%;\n  }\n  .offset-lg-0 {\n    margin-left: 0%;\n  }\n  .offset-lg-1 {\n    margin-left: 8.333333%;\n  }\n  .offset-lg-2 {\n    margin-left: 16.666667%;\n  }\n  .offset-lg-3 {\n    margin-left: 25%;\n  }\n  .offset-lg-4 {\n    margin-left: 33.333333%;\n  }\n  .offset-lg-5 {\n    margin-left: 41.666667%;\n  }\n  .offset-lg-6 {\n    margin-left: 50%;\n  }\n  .offset-lg-7 {\n    margin-left: 58.333333%;\n  }\n  .offset-lg-8 {\n    margin-left: 66.666667%;\n  }\n  .offset-lg-9 {\n    margin-left: 75%;\n  }\n  .offset-lg-10 {\n    margin-left: 83.333333%;\n  }\n  .offset-lg-11 {\n    margin-left: 91.666667%;\n  }\n}\n\n@media (min-width: 1200px) {\n  .col-xl {\n    -webkit-flex-basis: 0;\n        -ms-flex-preferred-size: 0;\n            flex-basis: 0;\n    -webkit-box-flex: 1;\n    -webkit-flex-grow: 1;\n        -ms-flex-positive: 1;\n            flex-grow: 1;\n    max-width: 100%;\n  }\n  .col-xl-auto {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 auto;\n        -ms-flex: 0 0 auto;\n            flex: 0 0 auto;\n    width: auto;\n  }\n  .col-xl-1 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 8.333333%;\n        -ms-flex: 0 0 8.333333%;\n            flex: 0 0 8.333333%;\n    max-width: 8.333333%;\n  }\n  .col-xl-2 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 16.666667%;\n        -ms-flex: 0 0 16.666667%;\n            flex: 0 0 16.666667%;\n    max-width: 16.666667%;\n  }\n  .col-xl-3 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 25%;\n        -ms-flex: 0 0 25%;\n            flex: 0 0 25%;\n    max-width: 25%;\n  }\n  .col-xl-4 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 33.333333%;\n        -ms-flex: 0 0 33.333333%;\n            flex: 0 0 33.333333%;\n    max-width: 33.333333%;\n  }\n  .col-xl-5 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 41.666667%;\n        -ms-flex: 0 0 41.666667%;\n            flex: 0 0 41.666667%;\n    max-width: 41.666667%;\n  }\n  .col-xl-6 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 50%;\n        -ms-flex: 0 0 50%;\n            flex: 0 0 50%;\n    max-width: 50%;\n  }\n  .col-xl-7 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 58.333333%;\n        -ms-flex: 0 0 58.333333%;\n            flex: 0 0 58.333333%;\n    max-width: 58.333333%;\n  }\n  .col-xl-8 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 66.666667%;\n        -ms-flex: 0 0 66.666667%;\n            flex: 0 0 66.666667%;\n    max-width: 66.666667%;\n  }\n  .col-xl-9 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 75%;\n        -ms-flex: 0 0 75%;\n            flex: 0 0 75%;\n    max-width: 75%;\n  }\n  .col-xl-10 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 83.333333%;\n        -ms-flex: 0 0 83.333333%;\n            flex: 0 0 83.333333%;\n    max-width: 83.333333%;\n  }\n  .col-xl-11 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 91.666667%;\n        -ms-flex: 0 0 91.666667%;\n            flex: 0 0 91.666667%;\n    max-width: 91.666667%;\n  }\n  .col-xl-12 {\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 100%;\n        -ms-flex: 0 0 100%;\n            flex: 0 0 100%;\n    max-width: 100%;\n  }\n  .pull-xl-0 {\n    right: auto;\n  }\n  .pull-xl-1 {\n    right: 8.333333%;\n  }\n  .pull-xl-2 {\n    right: 16.666667%;\n  }\n  .pull-xl-3 {\n    right: 25%;\n  }\n  .pull-xl-4 {\n    right: 33.333333%;\n  }\n  .pull-xl-5 {\n    right: 41.666667%;\n  }\n  .pull-xl-6 {\n    right: 50%;\n  }\n  .pull-xl-7 {\n    right: 58.333333%;\n  }\n  .pull-xl-8 {\n    right: 66.666667%;\n  }\n  .pull-xl-9 {\n    right: 75%;\n  }\n  .pull-xl-10 {\n    right: 83.333333%;\n  }\n  .pull-xl-11 {\n    right: 91.666667%;\n  }\n  .pull-xl-12 {\n    right: 100%;\n  }\n  .push-xl-0 {\n    left: auto;\n  }\n  .push-xl-1 {\n    left: 8.333333%;\n  }\n  .push-xl-2 {\n    left: 16.666667%;\n  }\n  .push-xl-3 {\n    left: 25%;\n  }\n  .push-xl-4 {\n    left: 33.333333%;\n  }\n  .push-xl-5 {\n    left: 41.666667%;\n  }\n  .push-xl-6 {\n    left: 50%;\n  }\n  .push-xl-7 {\n    left: 58.333333%;\n  }\n  .push-xl-8 {\n    left: 66.666667%;\n  }\n  .push-xl-9 {\n    left: 75%;\n  }\n  .push-xl-10 {\n    left: 83.333333%;\n  }\n  .push-xl-11 {\n    left: 91.666667%;\n  }\n  .push-xl-12 {\n    left: 100%;\n  }\n  .offset-xl-0 {\n    margin-left: 0%;\n  }\n  .offset-xl-1 {\n    margin-left: 8.333333%;\n  }\n  .offset-xl-2 {\n    margin-left: 16.666667%;\n  }\n  .offset-xl-3 {\n    margin-left: 25%;\n  }\n  .offset-xl-4 {\n    margin-left: 33.333333%;\n  }\n  .offset-xl-5 {\n    margin-left: 41.666667%;\n  }\n  .offset-xl-6 {\n    margin-left: 50%;\n  }\n  .offset-xl-7 {\n    margin-left: 58.333333%;\n  }\n  .offset-xl-8 {\n    margin-left: 66.666667%;\n  }\n  .offset-xl-9 {\n    margin-left: 75%;\n  }\n  .offset-xl-10 {\n    margin-left: 83.333333%;\n  }\n  .offset-xl-11 {\n    margin-left: 91.666667%;\n  }\n}\n\n.table {\n  width: 100%;\n  max-width: 100%;\n  margin-bottom: 1rem;\n}\n\n.table th,\n.table td {\n  padding: 0.75rem;\n  vertical-align: top;\n  border-top: 1px solid #eceeef;\n}\n\n.table thead th {\n  vertical-align: bottom;\n  border-bottom: 2px solid #eceeef;\n}\n\n.table tbody + tbody {\n  border-top: 2px solid #eceeef;\n}\n\n.table .table {\n  background-color: #fff;\n}\n\n.table-sm th,\n.table-sm td {\n  padding: 0.3rem;\n}\n\n.table-bordered {\n  border: 1px solid #eceeef;\n}\n\n.table-bordered th,\n.table-bordered td {\n  border: 1px solid #eceeef;\n}\n\n.table-bordered thead th,\n.table-bordered thead td {\n  border-bottom-width: 2px;\n}\n\n.table-striped tbody tr:nth-of-type(odd) {\n  background-color: rgba(0, 0, 0, 0.05);\n}\n\n.table-hover tbody tr:hover {\n  background-color: rgba(0, 0, 0, 0.075);\n}\n\n.table-active,\n.table-active > th,\n.table-active > td {\n  background-color: rgba(0, 0, 0, 0.075);\n}\n\n.table-hover .table-active:hover {\n  background-color: rgba(0, 0, 0, 0.075);\n}\n\n.table-hover .table-active:hover > td,\n.table-hover .table-active:hover > th {\n  background-color: rgba(0, 0, 0, 0.075);\n}\n\n.table-success,\n.table-success > th,\n.table-success > td {\n  background-color: #dff0d8;\n}\n\n.table-hover .table-success:hover {\n  background-color: #d0e9c6;\n}\n\n.table-hover .table-success:hover > td,\n.table-hover .table-success:hover > th {\n  background-color: #d0e9c6;\n}\n\n.table-info,\n.table-info > th,\n.table-info > td {\n  background-color: #d9edf7;\n}\n\n.table-hover .table-info:hover {\n  background-color: #c4e3f3;\n}\n\n.table-hover .table-info:hover > td,\n.table-hover .table-info:hover > th {\n  background-color: #c4e3f3;\n}\n\n.table-warning,\n.table-warning > th,\n.table-warning > td {\n  background-color: #fcf8e3;\n}\n\n.table-hover .table-warning:hover {\n  background-color: #faf2cc;\n}\n\n.table-hover .table-warning:hover > td,\n.table-hover .table-warning:hover > th {\n  background-color: #faf2cc;\n}\n\n.table-danger,\n.table-danger > th,\n.table-danger > td {\n  background-color: #f2dede;\n}\n\n.table-hover .table-danger:hover {\n  background-color: #ebcccc;\n}\n\n.table-hover .table-danger:hover > td,\n.table-hover .table-danger:hover > th {\n  background-color: #ebcccc;\n}\n\n.thead-inverse th {\n  color: #fff;\n  background-color: #292b2c;\n}\n\n.thead-default th {\n  color: #464a4c;\n  background-color: #eceeef;\n}\n\n.table-inverse {\n  color: #fff;\n  background-color: #292b2c;\n}\n\n.table-inverse th,\n.table-inverse td,\n.table-inverse thead th {\n  border-color: #fff;\n}\n\n.table-inverse.table-bordered {\n  border: 0;\n}\n\n.table-responsive {\n  display: block;\n  width: 100%;\n  overflow-x: auto;\n  -ms-overflow-style: -ms-autohiding-scrollbar;\n}\n\n.table-responsive.table-bordered {\n  border: 0;\n}\n\n.form-control {\n  display: block;\n  width: 100%;\n  padding: 0.5rem 0.75rem;\n  font-size: 1rem;\n  line-height: 1.25;\n  color: #464a4c;\n  background-color: #fff;\n  background-image: none;\n  -webkit-background-clip: padding-box;\n          background-clip: padding-box;\n  border: 1px solid rgba(0, 0, 0, 0.15);\n  border-radius: 0.25rem;\n  -webkit-transition: border-color ease-in-out 0.15s, -webkit-box-shadow ease-in-out 0.15s;\n  transition: border-color ease-in-out 0.15s, -webkit-box-shadow ease-in-out 0.15s;\n  -o-transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;\n  transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;\n  transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s, -webkit-box-shadow ease-in-out 0.15s;\n}\n\n.form-control::-ms-expand {\n  background-color: transparent;\n  border: 0;\n}\n\n.form-control:focus {\n  color: #464a4c;\n  background-color: #fff;\n  border-color: #5cb3fd;\n  outline: none;\n}\n\n.form-control::-webkit-input-placeholder {\n  color: #636c72;\n  opacity: 1;\n}\n\n.form-control::-moz-placeholder {\n  color: #636c72;\n  opacity: 1;\n}\n\n.form-control:-ms-input-placeholder {\n  color: #636c72;\n  opacity: 1;\n}\n\n.form-control::placeholder {\n  color: #636c72;\n  opacity: 1;\n}\n\n.form-control:disabled, .form-control[readonly] {\n  background-color: #eceeef;\n  opacity: 1;\n}\n\n.form-control:disabled {\n  cursor: not-allowed;\n}\n\nselect.form-control:not([size]):not([multiple]) {\n  height: calc(2.25rem + 2px);\n}\n\nselect.form-control:focus::-ms-value {\n  color: #464a4c;\n  background-color: #fff;\n}\n\n.form-control-file,\n.form-control-range {\n  display: block;\n}\n\n.col-form-label {\n  padding-top: calc(0.5rem - 1px * 2);\n  padding-bottom: calc(0.5rem - 1px * 2);\n  margin-bottom: 0;\n}\n\n.col-form-label-lg {\n  padding-top: calc(0.75rem - 1px * 2);\n  padding-bottom: calc(0.75rem - 1px * 2);\n  font-size: 1.25rem;\n}\n\n.col-form-label-sm {\n  padding-top: calc(0.25rem - 1px * 2);\n  padding-bottom: calc(0.25rem - 1px * 2);\n  font-size: 0.875rem;\n}\n\n.col-form-legend {\n  padding-top: 0.5rem;\n  padding-bottom: 0.5rem;\n  margin-bottom: 0;\n  font-size: 1rem;\n}\n\n.form-control-static {\n  padding-top: 0.5rem;\n  padding-bottom: 0.5rem;\n  margin-bottom: 0;\n  line-height: 1.25;\n  border: solid transparent;\n  border-width: 1px 0;\n}\n\n.form-control-static.form-control-sm, .input-group-sm > .form-control-static.form-control,\n.input-group-sm > .form-control-static.input-group-addon,\n.input-group-sm > .input-group-btn > .form-control-static.btn, .form-control-static.form-control-lg, .input-group-lg > .form-control-static.form-control,\n.input-group-lg > .form-control-static.input-group-addon,\n.input-group-lg > .input-group-btn > .form-control-static.btn {\n  padding-right: 0;\n  padding-left: 0;\n}\n\n.form-control-sm, .input-group-sm > .form-control,\n.input-group-sm > .input-group-addon,\n.input-group-sm > .input-group-btn > .btn {\n  padding: 0.25rem 0.5rem;\n  font-size: 0.875rem;\n  border-radius: 0.2rem;\n}\n\nselect.form-control-sm:not([size]):not([multiple]), .input-group-sm > select.form-control:not([size]):not([multiple]),\n.input-group-sm > select.input-group-addon:not([size]):not([multiple]),\n.input-group-sm > .input-group-btn > select.btn:not([size]):not([multiple]) {\n  height: 1.8125rem;\n}\n\n.form-control-lg, .input-group-lg > .form-control,\n.input-group-lg > .input-group-addon,\n.input-group-lg > .input-group-btn > .btn {\n  padding: 0.75rem 1.5rem;\n  font-size: 1.25rem;\n  border-radius: 0.3rem;\n}\n\nselect.form-control-lg:not([size]):not([multiple]), .input-group-lg > select.form-control:not([size]):not([multiple]),\n.input-group-lg > select.input-group-addon:not([size]):not([multiple]),\n.input-group-lg > .input-group-btn > select.btn:not([size]):not([multiple]) {\n  height: 3.166667rem;\n}\n\n.form-group {\n  margin-bottom: 1rem;\n}\n\n.form-text {\n  display: block;\n  margin-top: 0.25rem;\n}\n\n.form-check {\n  position: relative;\n  display: block;\n  margin-bottom: 0.5rem;\n}\n\n.form-check.disabled .form-check-label {\n  color: #636c72;\n  cursor: not-allowed;\n}\n\n.form-check-label {\n  padding-left: 1.25rem;\n  margin-bottom: 0;\n  cursor: pointer;\n}\n\n.form-check-input {\n  position: absolute;\n  margin-top: 0.25rem;\n  margin-left: -1.25rem;\n}\n\n.form-check-input:only-child {\n  position: static;\n}\n\n.form-check-inline {\n  display: inline-block;\n}\n\n.form-check-inline .form-check-label {\n  vertical-align: middle;\n}\n\n.form-check-inline + .form-check-inline {\n  margin-left: 0.75rem;\n}\n\n.form-control-feedback {\n  margin-top: 0.25rem;\n}\n\n.form-control-success,\n.form-control-warning,\n.form-control-danger {\n  padding-right: 2.25rem;\n  background-repeat: no-repeat;\n  background-position: center right 0.5625rem;\n  -webkit-background-size: 1.125rem 1.125rem;\n          background-size: 1.125rem 1.125rem;\n}\n\n.has-success .form-control-feedback,\n.has-success .form-control-label,\n.has-success .col-form-label,\n.has-success .form-check-label,\n.has-success .custom-control {\n  color: #5cb85c;\n}\n\n.has-success .form-control {\n  border-color: #5cb85c;\n}\n\n.has-success .input-group-addon {\n  color: #5cb85c;\n  border-color: #5cb85c;\n  background-color: #eaf6ea;\n}\n\n.has-success .form-control-success {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3E%3Cpath fill='%235cb85c' d='M2.3 6.73L.6 4.53c-.4-1.04.46-1.4 1.1-.8l1.1 1.4 3.4-3.8c.6-.63 1.6-.27 1.2.7l-4 4.6c-.43.5-.8.4-1.1.1z'/%3E%3C/svg%3E\");\n}\n\n.has-warning .form-control-feedback,\n.has-warning .form-control-label,\n.has-warning .col-form-label,\n.has-warning .form-check-label,\n.has-warning .custom-control {\n  color: #f0ad4e;\n}\n\n.has-warning .form-control {\n  border-color: #f0ad4e;\n}\n\n.has-warning .input-group-addon {\n  color: #f0ad4e;\n  border-color: #f0ad4e;\n  background-color: white;\n}\n\n.has-warning .form-control-warning {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3E%3Cpath fill='%23f0ad4e' d='M4.4 5.324h-.8v-2.46h.8zm0 1.42h-.8V5.89h.8zM3.76.63L.04 7.075c-.115.2.016.425.26.426h7.397c.242 0 .372-.226.258-.426C6.726 4.924 5.47 2.79 4.253.63c-.113-.174-.39-.174-.494 0z'/%3E%3C/svg%3E\");\n}\n\n.has-danger .form-control-feedback,\n.has-danger .form-control-label,\n.has-danger .col-form-label,\n.has-danger .form-check-label,\n.has-danger .custom-control {\n  color: #d9534f;\n}\n\n.has-danger .form-control {\n  border-color: #d9534f;\n}\n\n.has-danger .input-group-addon {\n  color: #d9534f;\n  border-color: #d9534f;\n  background-color: #fdf7f7;\n}\n\n.has-danger .form-control-danger {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23d9534f' viewBox='-2 -2 7 7'%3E%3Cpath stroke='%23d9534f' d='M0 0l3 3m0-3L0 3'/%3E%3Ccircle r='.5'/%3E%3Ccircle cx='3' r='.5'/%3E%3Ccircle cy='3' r='.5'/%3E%3Ccircle cx='3' cy='3' r='.5'/%3E%3C/svg%3E\");\n}\n\n.form-inline {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-flex-flow: row wrap;\n      -ms-flex-flow: row wrap;\n          flex-flow: row wrap;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n}\n\n.form-inline .form-check {\n  width: 100%;\n}\n\n@media (min-width: 576px) {\n  .form-inline label {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n    -webkit-box-pack: center;\n    -webkit-justify-content: center;\n        -ms-flex-pack: center;\n            justify-content: center;\n    margin-bottom: 0;\n  }\n  .form-inline .form-group {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-box-flex: 0;\n    -webkit-flex: 0 0 auto;\n        -ms-flex: 0 0 auto;\n            flex: 0 0 auto;\n    -webkit-flex-flow: row wrap;\n        -ms-flex-flow: row wrap;\n            flex-flow: row wrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n    margin-bottom: 0;\n  }\n  .form-inline .form-control {\n    display: inline-block;\n    width: auto;\n    vertical-align: middle;\n  }\n  .form-inline .form-control-static {\n    display: inline-block;\n  }\n  .form-inline .input-group {\n    width: auto;\n  }\n  .form-inline .form-control-label {\n    margin-bottom: 0;\n    vertical-align: middle;\n  }\n  .form-inline .form-check {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n    -webkit-box-pack: center;\n    -webkit-justify-content: center;\n        -ms-flex-pack: center;\n            justify-content: center;\n    width: auto;\n    margin-top: 0;\n    margin-bottom: 0;\n  }\n  .form-inline .form-check-label {\n    padding-left: 0;\n  }\n  .form-inline .form-check-input {\n    position: relative;\n    margin-top: 0;\n    margin-right: 0.25rem;\n    margin-left: 0;\n  }\n  .form-inline .custom-control {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n    -webkit-box-pack: center;\n    -webkit-justify-content: center;\n        -ms-flex-pack: center;\n            justify-content: center;\n    padding-left: 0;\n  }\n  .form-inline .custom-control-indicator {\n    position: static;\n    display: inline-block;\n    margin-right: 0.25rem;\n    vertical-align: text-bottom;\n  }\n  .form-inline .has-feedback .form-control-feedback {\n    top: 0;\n  }\n}\n\n.btn {\n  display: inline-block;\n  font-weight: normal;\n  line-height: 1.25;\n  text-align: center;\n  white-space: nowrap;\n  vertical-align: middle;\n  -webkit-user-select: none;\n     -moz-user-select: none;\n      -ms-user-select: none;\n          user-select: none;\n  border: 1px solid transparent;\n  padding: 0.5rem 1rem;\n  font-size: 1rem;\n  border-radius: 0.25rem;\n  -webkit-transition: all 0.2s ease-in-out;\n  -o-transition: all 0.2s ease-in-out;\n  transition: all 0.2s ease-in-out;\n}\n\n.btn:focus, .btn:hover {\n  text-decoration: none;\n}\n\n.btn:focus, .btn.focus {\n  outline: 0;\n  -webkit-box-shadow: 0 0 0 2px rgba(2, 117, 216, 0.25);\n          box-shadow: 0 0 0 2px rgba(2, 117, 216, 0.25);\n}\n\n.btn.disabled, .btn:disabled {\n  cursor: not-allowed;\n  opacity: .65;\n}\n\n.btn:active, .btn.active {\n  background-image: none;\n}\n\na.btn.disabled,\nfieldset[disabled] a.btn {\n  pointer-events: none;\n}\n\n.btn-primary {\n  color: #fff;\n  background-color: #0275d8;\n  border-color: #0275d8;\n}\n\n.btn-primary:hover {\n  color: #fff;\n  background-color: #025aa5;\n  border-color: #01549b;\n}\n\n.btn-primary:focus, .btn-primary.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(2, 117, 216, 0.5);\n          box-shadow: 0 0 0 2px rgba(2, 117, 216, 0.5);\n}\n\n.btn-primary.disabled, .btn-primary:disabled {\n  background-color: #0275d8;\n  border-color: #0275d8;\n}\n\n.btn-primary:active, .btn-primary.active,\n.show > .btn-primary.dropdown-toggle {\n  color: #fff;\n  background-color: #025aa5;\n  background-image: none;\n  border-color: #01549b;\n}\n\n.btn-secondary {\n  color: #292b2c;\n  background-color: #fff;\n  border-color: #ccc;\n}\n\n.btn-secondary:hover {\n  color: #292b2c;\n  background-color: #e6e6e6;\n  border-color: #adadad;\n}\n\n.btn-secondary:focus, .btn-secondary.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(204, 204, 204, 0.5);\n          box-shadow: 0 0 0 2px rgba(204, 204, 204, 0.5);\n}\n\n.btn-secondary.disabled, .btn-secondary:disabled {\n  background-color: #fff;\n  border-color: #ccc;\n}\n\n.btn-secondary:active, .btn-secondary.active,\n.show > .btn-secondary.dropdown-toggle {\n  color: #292b2c;\n  background-color: #e6e6e6;\n  background-image: none;\n  border-color: #adadad;\n}\n\n.btn-info {\n  color: #fff;\n  background-color: #5bc0de;\n  border-color: #5bc0de;\n}\n\n.btn-info:hover {\n  color: #fff;\n  background-color: #31b0d5;\n  border-color: #2aabd2;\n}\n\n.btn-info:focus, .btn-info.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(91, 192, 222, 0.5);\n          box-shadow: 0 0 0 2px rgba(91, 192, 222, 0.5);\n}\n\n.btn-info.disabled, .btn-info:disabled {\n  background-color: #5bc0de;\n  border-color: #5bc0de;\n}\n\n.btn-info:active, .btn-info.active,\n.show > .btn-info.dropdown-toggle {\n  color: #fff;\n  background-color: #31b0d5;\n  background-image: none;\n  border-color: #2aabd2;\n}\n\n.btn-success {\n  color: #fff;\n  background-color: #5cb85c;\n  border-color: #5cb85c;\n}\n\n.btn-success:hover {\n  color: #fff;\n  background-color: #449d44;\n  border-color: #419641;\n}\n\n.btn-success:focus, .btn-success.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(92, 184, 92, 0.5);\n          box-shadow: 0 0 0 2px rgba(92, 184, 92, 0.5);\n}\n\n.btn-success.disabled, .btn-success:disabled {\n  background-color: #5cb85c;\n  border-color: #5cb85c;\n}\n\n.btn-success:active, .btn-success.active,\n.show > .btn-success.dropdown-toggle {\n  color: #fff;\n  background-color: #449d44;\n  background-image: none;\n  border-color: #419641;\n}\n\n.btn-warning {\n  color: #fff;\n  background-color: #f0ad4e;\n  border-color: #f0ad4e;\n}\n\n.btn-warning:hover {\n  color: #fff;\n  background-color: #ec971f;\n  border-color: #eb9316;\n}\n\n.btn-warning:focus, .btn-warning.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(240, 173, 78, 0.5);\n          box-shadow: 0 0 0 2px rgba(240, 173, 78, 0.5);\n}\n\n.btn-warning.disabled, .btn-warning:disabled {\n  background-color: #f0ad4e;\n  border-color: #f0ad4e;\n}\n\n.btn-warning:active, .btn-warning.active,\n.show > .btn-warning.dropdown-toggle {\n  color: #fff;\n  background-color: #ec971f;\n  background-image: none;\n  border-color: #eb9316;\n}\n\n.btn-danger {\n  color: #fff;\n  background-color: #d9534f;\n  border-color: #d9534f;\n}\n\n.btn-danger:hover {\n  color: #fff;\n  background-color: #c9302c;\n  border-color: #c12e2a;\n}\n\n.btn-danger:focus, .btn-danger.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(217, 83, 79, 0.5);\n          box-shadow: 0 0 0 2px rgba(217, 83, 79, 0.5);\n}\n\n.btn-danger.disabled, .btn-danger:disabled {\n  background-color: #d9534f;\n  border-color: #d9534f;\n}\n\n.btn-danger:active, .btn-danger.active,\n.show > .btn-danger.dropdown-toggle {\n  color: #fff;\n  background-color: #c9302c;\n  background-image: none;\n  border-color: #c12e2a;\n}\n\n.btn-outline-primary {\n  color: #0275d8;\n  background-image: none;\n  background-color: transparent;\n  border-color: #0275d8;\n}\n\n.btn-outline-primary:hover {\n  color: #fff;\n  background-color: #0275d8;\n  border-color: #0275d8;\n}\n\n.btn-outline-primary:focus, .btn-outline-primary.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(2, 117, 216, 0.5);\n          box-shadow: 0 0 0 2px rgba(2, 117, 216, 0.5);\n}\n\n.btn-outline-primary.disabled, .btn-outline-primary:disabled {\n  color: #0275d8;\n  background-color: transparent;\n}\n\n.btn-outline-primary:active, .btn-outline-primary.active,\n.show > .btn-outline-primary.dropdown-toggle {\n  color: #fff;\n  background-color: #0275d8;\n  border-color: #0275d8;\n}\n\n.btn-outline-secondary {\n  color: #ccc;\n  background-image: none;\n  background-color: transparent;\n  border-color: #ccc;\n}\n\n.btn-outline-secondary:hover {\n  color: #fff;\n  background-color: #ccc;\n  border-color: #ccc;\n}\n\n.btn-outline-secondary:focus, .btn-outline-secondary.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(204, 204, 204, 0.5);\n          box-shadow: 0 0 0 2px rgba(204, 204, 204, 0.5);\n}\n\n.btn-outline-secondary.disabled, .btn-outline-secondary:disabled {\n  color: #ccc;\n  background-color: transparent;\n}\n\n.btn-outline-secondary:active, .btn-outline-secondary.active,\n.show > .btn-outline-secondary.dropdown-toggle {\n  color: #fff;\n  background-color: #ccc;\n  border-color: #ccc;\n}\n\n.btn-outline-info {\n  color: #5bc0de;\n  background-image: none;\n  background-color: transparent;\n  border-color: #5bc0de;\n}\n\n.btn-outline-info:hover {\n  color: #fff;\n  background-color: #5bc0de;\n  border-color: #5bc0de;\n}\n\n.btn-outline-info:focus, .btn-outline-info.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(91, 192, 222, 0.5);\n          box-shadow: 0 0 0 2px rgba(91, 192, 222, 0.5);\n}\n\n.btn-outline-info.disabled, .btn-outline-info:disabled {\n  color: #5bc0de;\n  background-color: transparent;\n}\n\n.btn-outline-info:active, .btn-outline-info.active,\n.show > .btn-outline-info.dropdown-toggle {\n  color: #fff;\n  background-color: #5bc0de;\n  border-color: #5bc0de;\n}\n\n.btn-outline-success {\n  color: #5cb85c;\n  background-image: none;\n  background-color: transparent;\n  border-color: #5cb85c;\n}\n\n.btn-outline-success:hover {\n  color: #fff;\n  background-color: #5cb85c;\n  border-color: #5cb85c;\n}\n\n.btn-outline-success:focus, .btn-outline-success.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(92, 184, 92, 0.5);\n          box-shadow: 0 0 0 2px rgba(92, 184, 92, 0.5);\n}\n\n.btn-outline-success.disabled, .btn-outline-success:disabled {\n  color: #5cb85c;\n  background-color: transparent;\n}\n\n.btn-outline-success:active, .btn-outline-success.active,\n.show > .btn-outline-success.dropdown-toggle {\n  color: #fff;\n  background-color: #5cb85c;\n  border-color: #5cb85c;\n}\n\n.btn-outline-warning {\n  color: #f0ad4e;\n  background-image: none;\n  background-color: transparent;\n  border-color: #f0ad4e;\n}\n\n.btn-outline-warning:hover {\n  color: #fff;\n  background-color: #f0ad4e;\n  border-color: #f0ad4e;\n}\n\n.btn-outline-warning:focus, .btn-outline-warning.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(240, 173, 78, 0.5);\n          box-shadow: 0 0 0 2px rgba(240, 173, 78, 0.5);\n}\n\n.btn-outline-warning.disabled, .btn-outline-warning:disabled {\n  color: #f0ad4e;\n  background-color: transparent;\n}\n\n.btn-outline-warning:active, .btn-outline-warning.active,\n.show > .btn-outline-warning.dropdown-toggle {\n  color: #fff;\n  background-color: #f0ad4e;\n  border-color: #f0ad4e;\n}\n\n.btn-outline-danger {\n  color: #d9534f;\n  background-image: none;\n  background-color: transparent;\n  border-color: #d9534f;\n}\n\n.btn-outline-danger:hover {\n  color: #fff;\n  background-color: #d9534f;\n  border-color: #d9534f;\n}\n\n.btn-outline-danger:focus, .btn-outline-danger.focus {\n  -webkit-box-shadow: 0 0 0 2px rgba(217, 83, 79, 0.5);\n          box-shadow: 0 0 0 2px rgba(217, 83, 79, 0.5);\n}\n\n.btn-outline-danger.disabled, .btn-outline-danger:disabled {\n  color: #d9534f;\n  background-color: transparent;\n}\n\n.btn-outline-danger:active, .btn-outline-danger.active,\n.show > .btn-outline-danger.dropdown-toggle {\n  color: #fff;\n  background-color: #d9534f;\n  border-color: #d9534f;\n}\n\n.btn-link {\n  font-weight: normal;\n  color: #0275d8;\n  border-radius: 0;\n}\n\n.btn-link, .btn-link:active, .btn-link.active, .btn-link:disabled {\n  background-color: transparent;\n}\n\n.btn-link, .btn-link:focus, .btn-link:active {\n  border-color: transparent;\n}\n\n.btn-link:hover {\n  border-color: transparent;\n}\n\n.btn-link:focus, .btn-link:hover {\n  color: #014c8c;\n  text-decoration: underline;\n  background-color: transparent;\n}\n\n.btn-link:disabled {\n  color: #636c72;\n}\n\n.btn-link:disabled:focus, .btn-link:disabled:hover {\n  text-decoration: none;\n}\n\n.btn-lg, .btn-group-lg > .btn {\n  padding: 0.75rem 1.5rem;\n  font-size: 1.25rem;\n  border-radius: 0.3rem;\n}\n\n.btn-sm, .btn-group-sm > .btn {\n  padding: 0.25rem 0.5rem;\n  font-size: 0.875rem;\n  border-radius: 0.2rem;\n}\n\n.btn-block {\n  display: block;\n  width: 100%;\n}\n\n.btn-block + .btn-block {\n  margin-top: 0.5rem;\n}\n\ninput[type=\"submit\"].btn-block,\ninput[type=\"reset\"].btn-block,\ninput[type=\"button\"].btn-block {\n  width: 100%;\n}\n\n.fade {\n  opacity: 0;\n  -webkit-transition: opacity 0.15s linear;\n  -o-transition: opacity 0.15s linear;\n  transition: opacity 0.15s linear;\n}\n\n.fade.show {\n  opacity: 1;\n}\n\n.collapse {\n  display: none;\n}\n\n.collapse.show {\n  display: block;\n}\n\ntr.collapse.show {\n  display: table-row;\n}\n\ntbody.collapse.show {\n  display: table-row-group;\n}\n\n.collapsing {\n  position: relative;\n  height: 0;\n  overflow: hidden;\n  -webkit-transition: height 0.35s ease;\n  -o-transition: height 0.35s ease;\n  transition: height 0.35s ease;\n}\n\n.dropup,\n.dropdown {\n  position: relative;\n}\n\n.dropdown-toggle::after {\n  display: inline-block;\n  width: 0;\n  height: 0;\n  margin-left: 0.3em;\n  vertical-align: middle;\n  content: \"\";\n  border-top: 0.3em solid;\n  border-right: 0.3em solid transparent;\n  border-left: 0.3em solid transparent;\n}\n\n.dropdown-toggle:focus {\n  outline: 0;\n}\n\n.dropup .dropdown-toggle::after {\n  border-top: 0;\n  border-bottom: 0.3em solid;\n}\n\n.dropdown-menu {\n  position: absolute;\n  top: 100%;\n  left: 0;\n  z-index: 1000;\n  display: none;\n  float: left;\n  min-width: 10rem;\n  padding: 0.5rem 0;\n  margin: 0.125rem 0 0;\n  font-size: 1rem;\n  color: #292b2c;\n  text-align: left;\n  list-style: none;\n  background-color: #fff;\n  -webkit-background-clip: padding-box;\n          background-clip: padding-box;\n  border: 1px solid rgba(0, 0, 0, 0.15);\n  border-radius: 0.25rem;\n}\n\n.dropdown-divider {\n  height: 1px;\n  margin: 0.5rem 0;\n  overflow: hidden;\n  background-color: #eceeef;\n}\n\n.dropdown-item {\n  display: block;\n  width: 100%;\n  padding: 3px 1.5rem;\n  clear: both;\n  font-weight: normal;\n  color: #292b2c;\n  text-align: inherit;\n  white-space: nowrap;\n  background: none;\n  border: 0;\n}\n\n.dropdown-item:focus, .dropdown-item:hover {\n  color: #1d1e1f;\n  text-decoration: none;\n  background-color: #f7f7f9;\n}\n\n.dropdown-item.active, .dropdown-item:active {\n  color: #fff;\n  text-decoration: none;\n  background-color: #0275d8;\n}\n\n.dropdown-item.disabled, .dropdown-item:disabled {\n  color: #636c72;\n  cursor: not-allowed;\n  background-color: transparent;\n}\n\n.show > .dropdown-menu {\n  display: block;\n}\n\n.show > a {\n  outline: 0;\n}\n\n.dropdown-menu-right {\n  right: 0;\n  left: auto;\n}\n\n.dropdown-menu-left {\n  right: auto;\n  left: 0;\n}\n\n.dropdown-header {\n  display: block;\n  padding: 0.5rem 1.5rem;\n  margin-bottom: 0;\n  font-size: 0.875rem;\n  color: #636c72;\n  white-space: nowrap;\n}\n\n.dropdown-backdrop {\n  position: fixed;\n  top: 0;\n  right: 0;\n  bottom: 0;\n  left: 0;\n  z-index: 990;\n}\n\n.dropup .dropdown-menu {\n  top: auto;\n  bottom: 100%;\n  margin-bottom: 0.125rem;\n}\n\n.btn-group,\n.btn-group-vertical {\n  position: relative;\n  display: -webkit-inline-box;\n  display: -webkit-inline-flex;\n  display: -ms-inline-flexbox;\n  display: inline-flex;\n  vertical-align: middle;\n}\n\n.btn-group > .btn,\n.btn-group-vertical > .btn {\n  position: relative;\n  -webkit-box-flex: 0;\n  -webkit-flex: 0 1 auto;\n      -ms-flex: 0 1 auto;\n          flex: 0 1 auto;\n}\n\n.btn-group > .btn:hover,\n.btn-group-vertical > .btn:hover {\n  z-index: 2;\n}\n\n.btn-group > .btn:focus, .btn-group > .btn:active, .btn-group > .btn.active,\n.btn-group-vertical > .btn:focus,\n.btn-group-vertical > .btn:active,\n.btn-group-vertical > .btn.active {\n  z-index: 2;\n}\n\n.btn-group .btn + .btn,\n.btn-group .btn + .btn-group,\n.btn-group .btn-group + .btn,\n.btn-group .btn-group + .btn-group,\n.btn-group-vertical .btn + .btn,\n.btn-group-vertical .btn + .btn-group,\n.btn-group-vertical .btn-group + .btn,\n.btn-group-vertical .btn-group + .btn-group {\n  margin-left: -1px;\n}\n\n.btn-toolbar {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-pack: start;\n  -webkit-justify-content: flex-start;\n      -ms-flex-pack: start;\n          justify-content: flex-start;\n}\n\n.btn-toolbar .input-group {\n  width: auto;\n}\n\n.btn-group > .btn:not(:first-child):not(:last-child):not(.dropdown-toggle) {\n  border-radius: 0;\n}\n\n.btn-group > .btn:first-child {\n  margin-left: 0;\n}\n\n.btn-group > .btn:first-child:not(:last-child):not(.dropdown-toggle) {\n  border-bottom-right-radius: 0;\n  border-top-right-radius: 0;\n}\n\n.btn-group > .btn:last-child:not(:first-child),\n.btn-group > .dropdown-toggle:not(:first-child) {\n  border-bottom-left-radius: 0;\n  border-top-left-radius: 0;\n}\n\n.btn-group > .btn-group {\n  float: left;\n}\n\n.btn-group > .btn-group:not(:first-child):not(:last-child) > .btn {\n  border-radius: 0;\n}\n\n.btn-group > .btn-group:first-child:not(:last-child) > .btn:last-child,\n.btn-group > .btn-group:first-child:not(:last-child) > .dropdown-toggle {\n  border-bottom-right-radius: 0;\n  border-top-right-radius: 0;\n}\n\n.btn-group > .btn-group:last-child:not(:first-child) > .btn:first-child {\n  border-bottom-left-radius: 0;\n  border-top-left-radius: 0;\n}\n\n.btn-group .dropdown-toggle:active,\n.btn-group.open .dropdown-toggle {\n  outline: 0;\n}\n\n.btn + .dropdown-toggle-split {\n  padding-right: 0.75rem;\n  padding-left: 0.75rem;\n}\n\n.btn + .dropdown-toggle-split::after {\n  margin-left: 0;\n}\n\n.btn-sm + .dropdown-toggle-split, .btn-group-sm > .btn + .dropdown-toggle-split {\n  padding-right: 0.375rem;\n  padding-left: 0.375rem;\n}\n\n.btn-lg + .dropdown-toggle-split, .btn-group-lg > .btn + .dropdown-toggle-split {\n  padding-right: 1.125rem;\n  padding-left: 1.125rem;\n}\n\n.btn-group-vertical {\n  display: -webkit-inline-box;\n  display: -webkit-inline-flex;\n  display: -ms-inline-flexbox;\n  display: inline-flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n  -webkit-box-align: start;\n  -webkit-align-items: flex-start;\n      -ms-flex-align: start;\n          align-items: flex-start;\n  -webkit-box-pack: center;\n  -webkit-justify-content: center;\n      -ms-flex-pack: center;\n          justify-content: center;\n}\n\n.btn-group-vertical .btn,\n.btn-group-vertical .btn-group {\n  width: 100%;\n}\n\n.btn-group-vertical > .btn + .btn,\n.btn-group-vertical > .btn + .btn-group,\n.btn-group-vertical > .btn-group + .btn,\n.btn-group-vertical > .btn-group + .btn-group {\n  margin-top: -1px;\n  margin-left: 0;\n}\n\n.btn-group-vertical > .btn:not(:first-child):not(:last-child) {\n  border-radius: 0;\n}\n\n.btn-group-vertical > .btn:first-child:not(:last-child) {\n  border-bottom-right-radius: 0;\n  border-bottom-left-radius: 0;\n}\n\n.btn-group-vertical > .btn:last-child:not(:first-child) {\n  border-top-right-radius: 0;\n  border-top-left-radius: 0;\n}\n\n.btn-group-vertical > .btn-group:not(:first-child):not(:last-child) > .btn {\n  border-radius: 0;\n}\n\n.btn-group-vertical > .btn-group:first-child:not(:last-child) > .btn:last-child,\n.btn-group-vertical > .btn-group:first-child:not(:last-child) > .dropdown-toggle {\n  border-bottom-right-radius: 0;\n  border-bottom-left-radius: 0;\n}\n\n.btn-group-vertical > .btn-group:last-child:not(:first-child) > .btn:first-child {\n  border-top-right-radius: 0;\n  border-top-left-radius: 0;\n}\n\n[data-toggle=\"buttons\"] > .btn input[type=\"radio\"],\n[data-toggle=\"buttons\"] > .btn input[type=\"checkbox\"],\n[data-toggle=\"buttons\"] > .btn-group > .btn input[type=\"radio\"],\n[data-toggle=\"buttons\"] > .btn-group > .btn input[type=\"checkbox\"] {\n  position: absolute;\n  clip: rect(0, 0, 0, 0);\n  pointer-events: none;\n}\n\n.input-group {\n  position: relative;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  width: 100%;\n}\n\n.input-group .form-control {\n  position: relative;\n  z-index: 2;\n  -webkit-box-flex: 1;\n  -webkit-flex: 1 1 auto;\n      -ms-flex: 1 1 auto;\n          flex: 1 1 auto;\n  width: 1%;\n  margin-bottom: 0;\n}\n\n.input-group .form-control:focus, .input-group .form-control:active, .input-group .form-control:hover {\n  z-index: 3;\n}\n\n.input-group-addon,\n.input-group-btn,\n.input-group .form-control {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n  -webkit-box-pack: center;\n  -webkit-justify-content: center;\n      -ms-flex-pack: center;\n          justify-content: center;\n}\n\n.input-group-addon:not(:first-child):not(:last-child),\n.input-group-btn:not(:first-child):not(:last-child),\n.input-group .form-control:not(:first-child):not(:last-child) {\n  border-radius: 0;\n}\n\n.input-group-addon,\n.input-group-btn {\n  white-space: nowrap;\n  vertical-align: middle;\n}\n\n.input-group-addon {\n  padding: 0.5rem 0.75rem;\n  margin-bottom: 0;\n  font-size: 1rem;\n  font-weight: normal;\n  line-height: 1.25;\n  color: #464a4c;\n  text-align: center;\n  background-color: #eceeef;\n  border: 1px solid rgba(0, 0, 0, 0.15);\n  border-radius: 0.25rem;\n}\n\n.input-group-addon.form-control-sm,\n.input-group-sm > .input-group-addon,\n.input-group-sm > .input-group-btn > .input-group-addon.btn {\n  padding: 0.25rem 0.5rem;\n  font-size: 0.875rem;\n  border-radius: 0.2rem;\n}\n\n.input-group-addon.form-control-lg,\n.input-group-lg > .input-group-addon,\n.input-group-lg > .input-group-btn > .input-group-addon.btn {\n  padding: 0.75rem 1.5rem;\n  font-size: 1.25rem;\n  border-radius: 0.3rem;\n}\n\n.input-group-addon input[type=\"radio\"],\n.input-group-addon input[type=\"checkbox\"] {\n  margin-top: 0;\n}\n\n.input-group .form-control:not(:last-child),\n.input-group-addon:not(:last-child),\n.input-group-btn:not(:last-child) > .btn,\n.input-group-btn:not(:last-child) > .btn-group > .btn,\n.input-group-btn:not(:last-child) > .dropdown-toggle,\n.input-group-btn:not(:first-child) > .btn:not(:last-child):not(.dropdown-toggle),\n.input-group-btn:not(:first-child) > .btn-group:not(:last-child) > .btn {\n  border-bottom-right-radius: 0;\n  border-top-right-radius: 0;\n}\n\n.input-group-addon:not(:last-child) {\n  border-right: 0;\n}\n\n.input-group .form-control:not(:first-child),\n.input-group-addon:not(:first-child),\n.input-group-btn:not(:first-child) > .btn,\n.input-group-btn:not(:first-child) > .btn-group > .btn,\n.input-group-btn:not(:first-child) > .dropdown-toggle,\n.input-group-btn:not(:last-child) > .btn:not(:first-child),\n.input-group-btn:not(:last-child) > .btn-group:not(:first-child) > .btn {\n  border-bottom-left-radius: 0;\n  border-top-left-radius: 0;\n}\n\n.form-control + .input-group-addon:not(:first-child) {\n  border-left: 0;\n}\n\n.input-group-btn {\n  position: relative;\n  font-size: 0;\n  white-space: nowrap;\n}\n\n.input-group-btn > .btn {\n  position: relative;\n  -webkit-box-flex: 1;\n  -webkit-flex: 1 1 0%;\n      -ms-flex: 1 1 0%;\n          flex: 1 1 0%;\n}\n\n.input-group-btn > .btn + .btn {\n  margin-left: -1px;\n}\n\n.input-group-btn > .btn:focus, .input-group-btn > .btn:active, .input-group-btn > .btn:hover {\n  z-index: 3;\n}\n\n.input-group-btn:not(:last-child) > .btn,\n.input-group-btn:not(:last-child) > .btn-group {\n  margin-right: -1px;\n}\n\n.input-group-btn:not(:first-child) > .btn,\n.input-group-btn:not(:first-child) > .btn-group {\n  z-index: 2;\n  margin-left: -1px;\n}\n\n.input-group-btn:not(:first-child) > .btn:focus, .input-group-btn:not(:first-child) > .btn:active, .input-group-btn:not(:first-child) > .btn:hover,\n.input-group-btn:not(:first-child) > .btn-group:focus,\n.input-group-btn:not(:first-child) > .btn-group:active,\n.input-group-btn:not(:first-child) > .btn-group:hover {\n  z-index: 3;\n}\n\n.custom-control {\n  position: relative;\n  display: -webkit-inline-box;\n  display: -webkit-inline-flex;\n  display: -ms-inline-flexbox;\n  display: inline-flex;\n  min-height: 1.5rem;\n  padding-left: 1.5rem;\n  margin-right: 1rem;\n  cursor: pointer;\n}\n\n.custom-control-input {\n  position: absolute;\n  z-index: -1;\n  opacity: 0;\n}\n\n.custom-control-input:checked ~ .custom-control-indicator {\n  color: #fff;\n  background-color: #0275d8;\n}\n\n.custom-control-input:focus ~ .custom-control-indicator {\n  -webkit-box-shadow: 0 0 0 1px #fff, 0 0 0 3px #0275d8;\n          box-shadow: 0 0 0 1px #fff, 0 0 0 3px #0275d8;\n}\n\n.custom-control-input:active ~ .custom-control-indicator {\n  color: #fff;\n  background-color: #8fcafe;\n}\n\n.custom-control-input:disabled ~ .custom-control-indicator {\n  cursor: not-allowed;\n  background-color: #eceeef;\n}\n\n.custom-control-input:disabled ~ .custom-control-description {\n  color: #636c72;\n  cursor: not-allowed;\n}\n\n.custom-control-indicator {\n  position: absolute;\n  top: 0.25rem;\n  left: 0;\n  display: block;\n  width: 1rem;\n  height: 1rem;\n  pointer-events: none;\n  -webkit-user-select: none;\n     -moz-user-select: none;\n      -ms-user-select: none;\n          user-select: none;\n  background-color: #ddd;\n  background-repeat: no-repeat;\n  background-position: center center;\n  -webkit-background-size: 50% 50%;\n          background-size: 50% 50%;\n}\n\n.custom-checkbox .custom-control-indicator {\n  border-radius: 0.25rem;\n}\n\n.custom-checkbox .custom-control-input:checked ~ .custom-control-indicator {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3E%3Cpath fill='%23fff' d='M6.564.75l-3.59 3.612-1.538-1.55L0 4.26 2.974 7.25 8 2.193z'/%3E%3C/svg%3E\");\n}\n\n.custom-checkbox .custom-control-input:indeterminate ~ .custom-control-indicator {\n  background-color: #0275d8;\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 4'%3E%3Cpath stroke='%23fff' d='M0 2h4'/%3E%3C/svg%3E\");\n}\n\n.custom-radio .custom-control-indicator {\n  border-radius: 50%;\n}\n\n.custom-radio .custom-control-input:checked ~ .custom-control-indicator {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'%3E%3Ccircle r='3' fill='%23fff'/%3E%3C/svg%3E\");\n}\n\n.custom-controls-stacked {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n}\n\n.custom-controls-stacked .custom-control {\n  margin-bottom: 0.25rem;\n}\n\n.custom-controls-stacked .custom-control + .custom-control {\n  margin-left: 0;\n}\n\n.custom-select {\n  display: inline-block;\n  max-width: 100%;\n  height: calc(2.25rem + 2px);\n  padding: 0.375rem 1.75rem 0.375rem 0.75rem;\n  line-height: 1.25;\n  color: #464a4c;\n  vertical-align: middle;\n  background: #fff url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'%3E%3Cpath fill='%23333' d='M2 0L0 2h4zm0 5L0 3h4z'/%3E%3C/svg%3E\") no-repeat right 0.75rem center;\n  -webkit-background-size: 8px 10px;\n          background-size: 8px 10px;\n  border: 1px solid rgba(0, 0, 0, 0.15);\n  border-radius: 0.25rem;\n  -moz-appearance: none;\n  -webkit-appearance: none;\n}\n\n.custom-select:focus {\n  border-color: #5cb3fd;\n  outline: none;\n}\n\n.custom-select:focus::-ms-value {\n  color: #464a4c;\n  background-color: #fff;\n}\n\n.custom-select:disabled {\n  color: #636c72;\n  cursor: not-allowed;\n  background-color: #eceeef;\n}\n\n.custom-select::-ms-expand {\n  opacity: 0;\n}\n\n.custom-select-sm {\n  padding-top: 0.375rem;\n  padding-bottom: 0.375rem;\n  font-size: 75%;\n}\n\n.custom-file {\n  position: relative;\n  display: inline-block;\n  max-width: 100%;\n  height: 2.5rem;\n  margin-bottom: 0;\n  cursor: pointer;\n}\n\n.custom-file-input {\n  min-width: 14rem;\n  max-width: 100%;\n  height: 2.5rem;\n  margin: 0;\n  filter: alpha(opacity=0);\n  opacity: 0;\n}\n\n.custom-file-control {\n  position: absolute;\n  top: 0;\n  right: 0;\n  left: 0;\n  z-index: 5;\n  height: 2.5rem;\n  padding: 0.5rem 1rem;\n  line-height: 1.5;\n  color: #464a4c;\n  pointer-events: none;\n  -webkit-user-select: none;\n     -moz-user-select: none;\n      -ms-user-select: none;\n          user-select: none;\n  background-color: #fff;\n  border: 1px solid rgba(0, 0, 0, 0.15);\n  border-radius: 0.25rem;\n}\n\n.custom-file-control:lang(en)::after {\n  content: \"Choose file...\";\n}\n\n.custom-file-control::before {\n  position: absolute;\n  top: -1px;\n  right: -1px;\n  bottom: -1px;\n  z-index: 6;\n  display: block;\n  height: 2.5rem;\n  padding: 0.5rem 1rem;\n  line-height: 1.5;\n  color: #464a4c;\n  background-color: #eceeef;\n  border: 1px solid rgba(0, 0, 0, 0.15);\n  border-radius: 0 0.25rem 0.25rem 0;\n}\n\n.custom-file-control:lang(en)::before {\n  content: \"Browse\";\n}\n\n.nav {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  padding-left: 0;\n  margin-bottom: 0;\n  list-style: none;\n}\n\n.nav-link {\n  display: block;\n  padding: 0.5em 1em;\n}\n\n.nav-link:focus, .nav-link:hover {\n  text-decoration: none;\n}\n\n.nav-link.disabled {\n  color: #636c72;\n  cursor: not-allowed;\n}\n\n.nav-tabs {\n  border-bottom: 1px solid #ddd;\n}\n\n.nav-tabs .nav-item {\n  margin-bottom: -1px;\n}\n\n.nav-tabs .nav-link {\n  border: 1px solid transparent;\n  border-top-right-radius: 0.25rem;\n  border-top-left-radius: 0.25rem;\n}\n\n.nav-tabs .nav-link:focus, .nav-tabs .nav-link:hover {\n  border-color: #eceeef #eceeef #ddd;\n}\n\n.nav-tabs .nav-link.disabled {\n  color: #636c72;\n  background-color: transparent;\n  border-color: transparent;\n}\n\n.nav-tabs .nav-link.active,\n.nav-tabs .nav-item.show .nav-link {\n  color: #464a4c;\n  background-color: #fff;\n  border-color: #ddd #ddd #fff;\n}\n\n.nav-tabs .dropdown-menu {\n  margin-top: -1px;\n  border-top-right-radius: 0;\n  border-top-left-radius: 0;\n}\n\n.nav-pills .nav-link {\n  border-radius: 0.25rem;\n}\n\n.nav-pills .nav-link.active,\n.nav-pills .nav-item.show .nav-link {\n  color: #fff;\n  cursor: default;\n  background-color: #0275d8;\n}\n\n.nav-fill .nav-item {\n  -webkit-box-flex: 1;\n  -webkit-flex: 1 1 auto;\n      -ms-flex: 1 1 auto;\n          flex: 1 1 auto;\n  text-align: center;\n}\n\n.nav-justified .nav-item {\n  -webkit-box-flex: 1;\n  -webkit-flex: 1 1 100%;\n      -ms-flex: 1 1 100%;\n          flex: 1 1 100%;\n  text-align: center;\n}\n\n.tab-content > .tab-pane {\n  display: none;\n}\n\n.tab-content > .active {\n  display: block;\n}\n\n.navbar {\n  position: relative;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n  padding: 0.5rem 1rem;\n}\n\n.navbar-brand {\n  display: inline-block;\n  padding-top: .25rem;\n  padding-bottom: .25rem;\n  margin-right: 1rem;\n  font-size: 1.25rem;\n  line-height: inherit;\n  white-space: nowrap;\n}\n\n.navbar-brand:focus, .navbar-brand:hover {\n  text-decoration: none;\n}\n\n.navbar-nav {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n  padding-left: 0;\n  margin-bottom: 0;\n  list-style: none;\n}\n\n.navbar-nav .nav-link {\n  padding-right: 0;\n  padding-left: 0;\n}\n\n.navbar-text {\n  display: inline-block;\n  padding-top: .425rem;\n  padding-bottom: .425rem;\n}\n\n.navbar-toggler {\n  -webkit-align-self: flex-start;\n      -ms-flex-item-align: start;\n          align-self: flex-start;\n  padding: 0.25rem 0.75rem;\n  font-size: 1.25rem;\n  line-height: 1;\n  background: transparent;\n  border: 1px solid transparent;\n  border-radius: 0.25rem;\n}\n\n.navbar-toggler:focus, .navbar-toggler:hover {\n  text-decoration: none;\n}\n\n.navbar-toggler-icon {\n  display: inline-block;\n  width: 1.5em;\n  height: 1.5em;\n  vertical-align: middle;\n  content: \"\";\n  background: no-repeat center center;\n  -webkit-background-size: 100% 100%;\n          background-size: 100% 100%;\n}\n\n.navbar-toggler-left {\n  position: absolute;\n  left: 1rem;\n}\n\n.navbar-toggler-right {\n  position: absolute;\n  right: 1rem;\n}\n\n@media (max-width: 575px) {\n  .navbar-toggleable .navbar-nav .dropdown-menu {\n    position: static;\n    float: none;\n  }\n  .navbar-toggleable > .container {\n    padding-right: 0;\n    padding-left: 0;\n  }\n}\n\n@media (min-width: 576px) {\n  .navbar-toggleable {\n    -webkit-box-orient: horizontal;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: row;\n        -ms-flex-direction: row;\n            flex-direction: row;\n    -webkit-flex-wrap: nowrap;\n        -ms-flex-wrap: nowrap;\n            flex-wrap: nowrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n  }\n  .navbar-toggleable .navbar-nav {\n    -webkit-box-orient: horizontal;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: row;\n        -ms-flex-direction: row;\n            flex-direction: row;\n  }\n  .navbar-toggleable .navbar-nav .nav-link {\n    padding-right: .5rem;\n    padding-left: .5rem;\n  }\n  .navbar-toggleable > .container {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-flex-wrap: nowrap;\n        -ms-flex-wrap: nowrap;\n            flex-wrap: nowrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n  }\n  .navbar-toggleable .navbar-collapse {\n    display: -webkit-box !important;\n    display: -webkit-flex !important;\n    display: -ms-flexbox !important;\n    display: flex !important;\n    width: 100%;\n  }\n  .navbar-toggleable .navbar-toggler {\n    display: none;\n  }\n}\n\n@media (max-width: 767px) {\n  .navbar-toggleable-sm .navbar-nav .dropdown-menu {\n    position: static;\n    float: none;\n  }\n  .navbar-toggleable-sm > .container {\n    padding-right: 0;\n    padding-left: 0;\n  }\n}\n\n@media (min-width: 768px) {\n  .navbar-toggleable-sm {\n    -webkit-box-orient: horizontal;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: row;\n        -ms-flex-direction: row;\n            flex-direction: row;\n    -webkit-flex-wrap: nowrap;\n        -ms-flex-wrap: nowrap;\n            flex-wrap: nowrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n  }\n  .navbar-toggleable-sm .navbar-nav {\n    -webkit-box-orient: horizontal;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: row;\n        -ms-flex-direction: row;\n            flex-direction: row;\n  }\n  .navbar-toggleable-sm .navbar-nav .nav-link {\n    padding-right: .5rem;\n    padding-left: .5rem;\n  }\n  .navbar-toggleable-sm > .container {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-flex-wrap: nowrap;\n        -ms-flex-wrap: nowrap;\n            flex-wrap: nowrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n  }\n  .navbar-toggleable-sm .navbar-collapse {\n    display: -webkit-box !important;\n    display: -webkit-flex !important;\n    display: -ms-flexbox !important;\n    display: flex !important;\n    width: 100%;\n  }\n  .navbar-toggleable-sm .navbar-toggler {\n    display: none;\n  }\n}\n\n@media (max-width: 991px) {\n  .navbar-toggleable-md .navbar-nav .dropdown-menu {\n    position: static;\n    float: none;\n  }\n  .navbar-toggleable-md > .container {\n    padding-right: 0;\n    padding-left: 0;\n  }\n}\n\n@media (min-width: 992px) {\n  .navbar-toggleable-md {\n    -webkit-box-orient: horizontal;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: row;\n        -ms-flex-direction: row;\n            flex-direction: row;\n    -webkit-flex-wrap: nowrap;\n        -ms-flex-wrap: nowrap;\n            flex-wrap: nowrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n  }\n  .navbar-toggleable-md .navbar-nav {\n    -webkit-box-orient: horizontal;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: row;\n        -ms-flex-direction: row;\n            flex-direction: row;\n  }\n  .navbar-toggleable-md .navbar-nav .nav-link {\n    padding-right: .5rem;\n    padding-left: .5rem;\n  }\n  .navbar-toggleable-md > .container {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-flex-wrap: nowrap;\n        -ms-flex-wrap: nowrap;\n            flex-wrap: nowrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n  }\n  .navbar-toggleable-md .navbar-collapse {\n    display: -webkit-box !important;\n    display: -webkit-flex !important;\n    display: -ms-flexbox !important;\n    display: flex !important;\n    width: 100%;\n  }\n  .navbar-toggleable-md .navbar-toggler {\n    display: none;\n  }\n}\n\n@media (max-width: 1199px) {\n  .navbar-toggleable-lg .navbar-nav .dropdown-menu {\n    position: static;\n    float: none;\n  }\n  .navbar-toggleable-lg > .container {\n    padding-right: 0;\n    padding-left: 0;\n  }\n}\n\n@media (min-width: 1200px) {\n  .navbar-toggleable-lg {\n    -webkit-box-orient: horizontal;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: row;\n        -ms-flex-direction: row;\n            flex-direction: row;\n    -webkit-flex-wrap: nowrap;\n        -ms-flex-wrap: nowrap;\n            flex-wrap: nowrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n  }\n  .navbar-toggleable-lg .navbar-nav {\n    -webkit-box-orient: horizontal;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: row;\n        -ms-flex-direction: row;\n            flex-direction: row;\n  }\n  .navbar-toggleable-lg .navbar-nav .nav-link {\n    padding-right: .5rem;\n    padding-left: .5rem;\n  }\n  .navbar-toggleable-lg > .container {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-flex-wrap: nowrap;\n        -ms-flex-wrap: nowrap;\n            flex-wrap: nowrap;\n    -webkit-box-align: center;\n    -webkit-align-items: center;\n        -ms-flex-align: center;\n            align-items: center;\n  }\n  .navbar-toggleable-lg .navbar-collapse {\n    display: -webkit-box !important;\n    display: -webkit-flex !important;\n    display: -ms-flexbox !important;\n    display: flex !important;\n    width: 100%;\n  }\n  .navbar-toggleable-lg .navbar-toggler {\n    display: none;\n  }\n}\n\n.navbar-toggleable-xl {\n  -webkit-box-orient: horizontal;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: row;\n      -ms-flex-direction: row;\n          flex-direction: row;\n  -webkit-flex-wrap: nowrap;\n      -ms-flex-wrap: nowrap;\n          flex-wrap: nowrap;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n}\n\n.navbar-toggleable-xl .navbar-nav .dropdown-menu {\n  position: static;\n  float: none;\n}\n\n.navbar-toggleable-xl > .container {\n  padding-right: 0;\n  padding-left: 0;\n}\n\n.navbar-toggleable-xl .navbar-nav {\n  -webkit-box-orient: horizontal;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: row;\n      -ms-flex-direction: row;\n          flex-direction: row;\n}\n\n.navbar-toggleable-xl .navbar-nav .nav-link {\n  padding-right: .5rem;\n  padding-left: .5rem;\n}\n\n.navbar-toggleable-xl > .container {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-flex-wrap: nowrap;\n      -ms-flex-wrap: nowrap;\n          flex-wrap: nowrap;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n}\n\n.navbar-toggleable-xl .navbar-collapse {\n  display: -webkit-box !important;\n  display: -webkit-flex !important;\n  display: -ms-flexbox !important;\n  display: flex !important;\n  width: 100%;\n}\n\n.navbar-toggleable-xl .navbar-toggler {\n  display: none;\n}\n\n.navbar-light .navbar-brand,\n.navbar-light .navbar-toggler {\n  color: rgba(0, 0, 0, 0.9);\n}\n\n.navbar-light .navbar-brand:focus, .navbar-light .navbar-brand:hover,\n.navbar-light .navbar-toggler:focus,\n.navbar-light .navbar-toggler:hover {\n  color: rgba(0, 0, 0, 0.9);\n}\n\n.navbar-light .navbar-nav .nav-link {\n  color: rgba(0, 0, 0, 0.5);\n}\n\n.navbar-light .navbar-nav .nav-link:focus, .navbar-light .navbar-nav .nav-link:hover {\n  color: rgba(0, 0, 0, 0.7);\n}\n\n.navbar-light .navbar-nav .nav-link.disabled {\n  color: rgba(0, 0, 0, 0.3);\n}\n\n.navbar-light .navbar-nav .open > .nav-link,\n.navbar-light .navbar-nav .active > .nav-link,\n.navbar-light .navbar-nav .nav-link.open,\n.navbar-light .navbar-nav .nav-link.active {\n  color: rgba(0, 0, 0, 0.9);\n}\n\n.navbar-light .navbar-toggler {\n  border-color: rgba(0, 0, 0, 0.1);\n}\n\n.navbar-light .navbar-toggler-icon {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 32 32' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(0, 0, 0, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 8h24M4 16h24M4 24h24'/%3E%3C/svg%3E\");\n}\n\n.navbar-light .navbar-text {\n  color: rgba(0, 0, 0, 0.5);\n}\n\n.navbar-inverse .navbar-brand,\n.navbar-inverse .navbar-toggler {\n  color: white;\n}\n\n.navbar-inverse .navbar-brand:focus, .navbar-inverse .navbar-brand:hover,\n.navbar-inverse .navbar-toggler:focus,\n.navbar-inverse .navbar-toggler:hover {\n  color: white;\n}\n\n.navbar-inverse .navbar-nav .nav-link {\n  color: rgba(255, 255, 255, 0.5);\n}\n\n.navbar-inverse .navbar-nav .nav-link:focus, .navbar-inverse .navbar-nav .nav-link:hover {\n  color: rgba(255, 255, 255, 0.75);\n}\n\n.navbar-inverse .navbar-nav .nav-link.disabled {\n  color: rgba(255, 255, 255, 0.25);\n}\n\n.navbar-inverse .navbar-nav .open > .nav-link,\n.navbar-inverse .navbar-nav .active > .nav-link,\n.navbar-inverse .navbar-nav .nav-link.open,\n.navbar-inverse .navbar-nav .nav-link.active {\n  color: white;\n}\n\n.navbar-inverse .navbar-toggler {\n  border-color: rgba(255, 255, 255, 0.1);\n}\n\n.navbar-inverse .navbar-toggler-icon {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 32 32' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 255, 255, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 8h24M4 16h24M4 24h24'/%3E%3C/svg%3E\");\n}\n\n.navbar-inverse .navbar-text {\n  color: rgba(255, 255, 255, 0.5);\n}\n\n.card {\n  position: relative;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n  background-color: #fff;\n  border: 1px solid rgba(0, 0, 0, 0.125);\n  border-radius: 0.25rem;\n}\n\n.card-block {\n  -webkit-box-flex: 1;\n  -webkit-flex: 1 1 auto;\n      -ms-flex: 1 1 auto;\n          flex: 1 1 auto;\n  padding: 1.25rem;\n}\n\n.card-title {\n  margin-bottom: 0.75rem;\n}\n\n.card-subtitle {\n  margin-top: -0.375rem;\n  margin-bottom: 0;\n}\n\n.card-text:last-child {\n  margin-bottom: 0;\n}\n\n.card-link:hover {\n  text-decoration: none;\n}\n\n.card-link + .card-link {\n  margin-left: 1.25rem;\n}\n\n.card > .list-group:first-child .list-group-item:first-child {\n  border-top-right-radius: 0.25rem;\n  border-top-left-radius: 0.25rem;\n}\n\n.card > .list-group:last-child .list-group-item:last-child {\n  border-bottom-right-radius: 0.25rem;\n  border-bottom-left-radius: 0.25rem;\n}\n\n.card-header {\n  padding: 0.75rem 1.25rem;\n  margin-bottom: 0;\n  background-color: #f7f7f9;\n  border-bottom: 1px solid rgba(0, 0, 0, 0.125);\n}\n\n.card-header:first-child {\n  border-radius: calc(0.25rem - 1px) calc(0.25rem - 1px) 0 0;\n}\n\n.card-footer {\n  padding: 0.75rem 1.25rem;\n  background-color: #f7f7f9;\n  border-top: 1px solid rgba(0, 0, 0, 0.125);\n}\n\n.card-footer:last-child {\n  border-radius: 0 0 calc(0.25rem - 1px) calc(0.25rem - 1px);\n}\n\n.card-header-tabs {\n  margin-right: -0.625rem;\n  margin-bottom: -0.75rem;\n  margin-left: -0.625rem;\n  border-bottom: 0;\n}\n\n.card-header-pills {\n  margin-right: -0.625rem;\n  margin-left: -0.625rem;\n}\n\n.card-primary {\n  background-color: #0275d8;\n  border-color: #0275d8;\n}\n\n.card-primary .card-header,\n.card-primary .card-footer {\n  background-color: transparent;\n}\n\n.card-success {\n  background-color: #5cb85c;\n  border-color: #5cb85c;\n}\n\n.card-success .card-header,\n.card-success .card-footer {\n  background-color: transparent;\n}\n\n.card-info {\n  background-color: #5bc0de;\n  border-color: #5bc0de;\n}\n\n.card-info .card-header,\n.card-info .card-footer {\n  background-color: transparent;\n}\n\n.card-warning {\n  background-color: #f0ad4e;\n  border-color: #f0ad4e;\n}\n\n.card-warning .card-header,\n.card-warning .card-footer {\n  background-color: transparent;\n}\n\n.card-danger {\n  background-color: #d9534f;\n  border-color: #d9534f;\n}\n\n.card-danger .card-header,\n.card-danger .card-footer {\n  background-color: transparent;\n}\n\n.card-outline-primary {\n  background-color: transparent;\n  border-color: #0275d8;\n}\n\n.card-outline-secondary {\n  background-color: transparent;\n  border-color: #ccc;\n}\n\n.card-outline-info {\n  background-color: transparent;\n  border-color: #5bc0de;\n}\n\n.card-outline-success {\n  background-color: transparent;\n  border-color: #5cb85c;\n}\n\n.card-outline-warning {\n  background-color: transparent;\n  border-color: #f0ad4e;\n}\n\n.card-outline-danger {\n  background-color: transparent;\n  border-color: #d9534f;\n}\n\n.card-inverse {\n  color: rgba(255, 255, 255, 0.65);\n}\n\n.card-inverse .card-header,\n.card-inverse .card-footer {\n  background-color: transparent;\n  border-color: rgba(255, 255, 255, 0.2);\n}\n\n.card-inverse .card-header,\n.card-inverse .card-footer,\n.card-inverse .card-title,\n.card-inverse .card-blockquote {\n  color: #fff;\n}\n\n.card-inverse .card-link,\n.card-inverse .card-text,\n.card-inverse .card-subtitle,\n.card-inverse .card-blockquote .blockquote-footer {\n  color: rgba(255, 255, 255, 0.65);\n}\n\n.card-inverse .card-link:focus, .card-inverse .card-link:hover {\n  color: #fff;\n}\n\n.card-blockquote {\n  padding: 0;\n  margin-bottom: 0;\n  border-left: 0;\n}\n\n.card-img {\n  border-radius: calc(0.25rem - 1px);\n}\n\n.card-img-overlay {\n  position: absolute;\n  top: 0;\n  right: 0;\n  bottom: 0;\n  left: 0;\n  padding: 1.25rem;\n}\n\n.card-img-top {\n  border-top-right-radius: calc(0.25rem - 1px);\n  border-top-left-radius: calc(0.25rem - 1px);\n}\n\n.card-img-bottom {\n  border-bottom-right-radius: calc(0.25rem - 1px);\n  border-bottom-left-radius: calc(0.25rem - 1px);\n}\n\n@media (min-width: 576px) {\n  .card-deck {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-flex-flow: row wrap;\n        -ms-flex-flow: row wrap;\n            flex-flow: row wrap;\n  }\n  .card-deck .card {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-box-flex: 1;\n    -webkit-flex: 1 0 0%;\n        -ms-flex: 1 0 0%;\n            flex: 1 0 0%;\n    -webkit-box-orient: vertical;\n    -webkit-box-direction: normal;\n    -webkit-flex-direction: column;\n        -ms-flex-direction: column;\n            flex-direction: column;\n  }\n  .card-deck .card:not(:first-child) {\n    margin-left: 15px;\n  }\n  .card-deck .card:not(:last-child) {\n    margin-right: 15px;\n  }\n}\n\n@media (min-width: 576px) {\n  .card-group {\n    display: -webkit-box;\n    display: -webkit-flex;\n    display: -ms-flexbox;\n    display: flex;\n    -webkit-flex-flow: row wrap;\n        -ms-flex-flow: row wrap;\n            flex-flow: row wrap;\n  }\n  .card-group .card {\n    -webkit-box-flex: 1;\n    -webkit-flex: 1 0 0%;\n        -ms-flex: 1 0 0%;\n            flex: 1 0 0%;\n  }\n  .card-group .card + .card {\n    margin-left: 0;\n    border-left: 0;\n  }\n  .card-group .card:first-child {\n    border-bottom-right-radius: 0;\n    border-top-right-radius: 0;\n  }\n  .card-group .card:first-child .card-img-top {\n    border-top-right-radius: 0;\n  }\n  .card-group .card:first-child .card-img-bottom {\n    border-bottom-right-radius: 0;\n  }\n  .card-group .card:last-child {\n    border-bottom-left-radius: 0;\n    border-top-left-radius: 0;\n  }\n  .card-group .card:last-child .card-img-top {\n    border-top-left-radius: 0;\n  }\n  .card-group .card:last-child .card-img-bottom {\n    border-bottom-left-radius: 0;\n  }\n  .card-group .card:not(:first-child):not(:last-child) {\n    border-radius: 0;\n  }\n  .card-group .card:not(:first-child):not(:last-child) .card-img-top,\n  .card-group .card:not(:first-child):not(:last-child) .card-img-bottom {\n    border-radius: 0;\n  }\n}\n\n@media (min-width: 576px) {\n  .card-columns {\n    -webkit-column-count: 3;\n       -moz-column-count: 3;\n            column-count: 3;\n    -webkit-column-gap: 1.25rem;\n       -moz-column-gap: 1.25rem;\n            column-gap: 1.25rem;\n  }\n  .card-columns .card {\n    display: inline-block;\n    width: 100%;\n    margin-bottom: 0.75rem;\n  }\n}\n\n.breadcrumb {\n  padding: 0.75rem 1rem;\n  margin-bottom: 1rem;\n  list-style: none;\n  background-color: #eceeef;\n  border-radius: 0.25rem;\n}\n\n.breadcrumb::after {\n  display: block;\n  content: \"\";\n  clear: both;\n}\n\n.breadcrumb-item {\n  float: left;\n}\n\n.breadcrumb-item + .breadcrumb-item::before {\n  display: inline-block;\n  padding-right: 0.5rem;\n  padding-left: 0.5rem;\n  color: #636c72;\n  content: \"/\";\n}\n\n.breadcrumb-item + .breadcrumb-item:hover::before {\n  text-decoration: underline;\n}\n\n.breadcrumb-item + .breadcrumb-item:hover::before {\n  text-decoration: none;\n}\n\n.breadcrumb-item.active {\n  color: #636c72;\n}\n\n.pagination {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  padding-left: 0;\n  list-style: none;\n  border-radius: 0.25rem;\n}\n\n.page-item:first-child .page-link {\n  margin-left: 0;\n  border-bottom-left-radius: 0.25rem;\n  border-top-left-radius: 0.25rem;\n}\n\n.page-item:last-child .page-link {\n  border-bottom-right-radius: 0.25rem;\n  border-top-right-radius: 0.25rem;\n}\n\n.page-item.active .page-link {\n  z-index: 2;\n  color: #fff;\n  background-color: #0275d8;\n  border-color: #0275d8;\n}\n\n.page-item.disabled .page-link {\n  color: #636c72;\n  pointer-events: none;\n  cursor: not-allowed;\n  background-color: #fff;\n  border-color: #ddd;\n}\n\n.page-link {\n  position: relative;\n  display: block;\n  padding: 0.5rem 0.75rem;\n  margin-left: -1px;\n  line-height: 1.25;\n  color: #0275d8;\n  background-color: #fff;\n  border: 1px solid #ddd;\n}\n\n.page-link:focus, .page-link:hover {\n  color: #014c8c;\n  text-decoration: none;\n  background-color: #eceeef;\n  border-color: #ddd;\n}\n\n.pagination-lg .page-link {\n  padding: 0.75rem 1.5rem;\n  font-size: 1.25rem;\n}\n\n.pagination-lg .page-item:first-child .page-link {\n  border-bottom-left-radius: 0.3rem;\n  border-top-left-radius: 0.3rem;\n}\n\n.pagination-lg .page-item:last-child .page-link {\n  border-bottom-right-radius: 0.3rem;\n  border-top-right-radius: 0.3rem;\n}\n\n.pagination-sm .page-link {\n  padding: 0.25rem 0.5rem;\n  font-size: 0.875rem;\n}\n\n.pagination-sm .page-item:first-child .page-link {\n  border-bottom-left-radius: 0.2rem;\n  border-top-left-radius: 0.2rem;\n}\n\n.pagination-sm .page-item:last-child .page-link {\n  border-bottom-right-radius: 0.2rem;\n  border-top-right-radius: 0.2rem;\n}\n\n.badge {\n  display: inline-block;\n  padding: 0.25em 0.4em;\n  font-size: 75%;\n  font-weight: bold;\n  line-height: 1;\n  color: #fff;\n  text-align: center;\n  white-space: nowrap;\n  vertical-align: baseline;\n  border-radius: 0.25rem;\n}\n\n.badge:empty {\n  display: none;\n}\n\n.btn .badge {\n  position: relative;\n  top: -1px;\n}\n\na.badge:focus, a.badge:hover {\n  color: #fff;\n  text-decoration: none;\n  cursor: pointer;\n}\n\n.badge-pill {\n  padding-right: 0.6em;\n  padding-left: 0.6em;\n  border-radius: 10rem;\n}\n\n.badge-default {\n  background-color: #636c72;\n}\n\n.badge-default[href]:focus, .badge-default[href]:hover {\n  background-color: #4b5257;\n}\n\n.badge-primary {\n  background-color: #0275d8;\n}\n\n.badge-primary[href]:focus, .badge-primary[href]:hover {\n  background-color: #025aa5;\n}\n\n.badge-success {\n  background-color: #5cb85c;\n}\n\n.badge-success[href]:focus, .badge-success[href]:hover {\n  background-color: #449d44;\n}\n\n.badge-info {\n  background-color: #5bc0de;\n}\n\n.badge-info[href]:focus, .badge-info[href]:hover {\n  background-color: #31b0d5;\n}\n\n.badge-warning {\n  background-color: #f0ad4e;\n}\n\n.badge-warning[href]:focus, .badge-warning[href]:hover {\n  background-color: #ec971f;\n}\n\n.badge-danger {\n  background-color: #d9534f;\n}\n\n.badge-danger[href]:focus, .badge-danger[href]:hover {\n  background-color: #c9302c;\n}\n\n.jumbotron {\n  padding: 2rem 1rem;\n  margin-bottom: 2rem;\n  background-color: #eceeef;\n  border-radius: 0.3rem;\n}\n\n@media (min-width: 576px) {\n  .jumbotron {\n    padding: 4rem 2rem;\n  }\n}\n\n.jumbotron-hr {\n  border-top-color: #d0d5d8;\n}\n\n.jumbotron-fluid {\n  padding-right: 0;\n  padding-left: 0;\n  border-radius: 0;\n}\n\n.alert {\n  padding: 0.75rem 1.25rem;\n  margin-bottom: 1rem;\n  border: 1px solid transparent;\n  border-radius: 0.25rem;\n}\n\n.alert-heading {\n  color: inherit;\n}\n\n.alert-link {\n  font-weight: bold;\n}\n\n.alert-dismissible .close {\n  position: relative;\n  top: -0.75rem;\n  right: -1.25rem;\n  padding: 0.75rem 1.25rem;\n  color: inherit;\n}\n\n.alert-success {\n  background-color: #dff0d8;\n  border-color: #d0e9c6;\n  color: #3c763d;\n}\n\n.alert-success hr {\n  border-top-color: #c1e2b3;\n}\n\n.alert-success .alert-link {\n  color: #2b542c;\n}\n\n.alert-info {\n  background-color: #d9edf7;\n  border-color: #bcdff1;\n  color: #31708f;\n}\n\n.alert-info hr {\n  border-top-color: #a6d5ec;\n}\n\n.alert-info .alert-link {\n  color: #245269;\n}\n\n.alert-warning {\n  background-color: #fcf8e3;\n  border-color: #faf2cc;\n  color: #8a6d3b;\n}\n\n.alert-warning hr {\n  border-top-color: #f7ecb5;\n}\n\n.alert-warning .alert-link {\n  color: #66512c;\n}\n\n.alert-danger {\n  background-color: #f2dede;\n  border-color: #ebcccc;\n  color: #a94442;\n}\n\n.alert-danger hr {\n  border-top-color: #e4b9b9;\n}\n\n.alert-danger .alert-link {\n  color: #843534;\n}\n\n@-webkit-keyframes progress-bar-stripes {\n  from {\n    background-position: 1rem 0;\n  }\n  to {\n    background-position: 0 0;\n  }\n}\n\n@-o-keyframes progress-bar-stripes {\n  from {\n    background-position: 1rem 0;\n  }\n  to {\n    background-position: 0 0;\n  }\n}\n\n@keyframes progress-bar-stripes {\n  from {\n    background-position: 1rem 0;\n  }\n  to {\n    background-position: 0 0;\n  }\n}\n\n.progress {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  overflow: hidden;\n  font-size: 0.75rem;\n  line-height: 1rem;\n  text-align: center;\n  background-color: #eceeef;\n  border-radius: 0.25rem;\n}\n\n.progress-bar {\n  height: 1rem;\n  color: #fff;\n  background-color: #0275d8;\n}\n\n.progress-bar-striped {\n  background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, 0.15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, 0.15) 50%, rgba(255, 255, 255, 0.15) 75%, transparent 75%, transparent);\n  background-image: -o-linear-gradient(45deg, rgba(255, 255, 255, 0.15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, 0.15) 50%, rgba(255, 255, 255, 0.15) 75%, transparent 75%, transparent);\n  background-image: linear-gradient(45deg, rgba(255, 255, 255, 0.15) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, 0.15) 50%, rgba(255, 255, 255, 0.15) 75%, transparent 75%, transparent);\n  -webkit-background-size: 1rem 1rem;\n          background-size: 1rem 1rem;\n}\n\n.progress-bar-animated {\n  -webkit-animation: progress-bar-stripes 1s linear infinite;\n       -o-animation: progress-bar-stripes 1s linear infinite;\n          animation: progress-bar-stripes 1s linear infinite;\n}\n\n.media {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-align: start;\n  -webkit-align-items: flex-start;\n      -ms-flex-align: start;\n          align-items: flex-start;\n}\n\n.media-body {\n  -webkit-box-flex: 1;\n  -webkit-flex: 1 1 0%;\n      -ms-flex: 1 1 0%;\n          flex: 1 1 0%;\n}\n\n.list-group {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n  padding-left: 0;\n  margin-bottom: 0;\n}\n\n.list-group-item-action {\n  width: 100%;\n  color: #464a4c;\n  text-align: inherit;\n}\n\n.list-group-item-action .list-group-item-heading {\n  color: #292b2c;\n}\n\n.list-group-item-action:focus, .list-group-item-action:hover {\n  color: #464a4c;\n  text-decoration: none;\n  background-color: #f7f7f9;\n}\n\n.list-group-item-action:active {\n  color: #292b2c;\n  background-color: #eceeef;\n}\n\n.list-group-item {\n  position: relative;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-flex-flow: row wrap;\n      -ms-flex-flow: row wrap;\n          flex-flow: row wrap;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n  padding: 0.75rem 1.25rem;\n  margin-bottom: -1px;\n  background-color: #fff;\n  border: 1px solid rgba(0, 0, 0, 0.125);\n}\n\n.list-group-item:first-child {\n  border-top-right-radius: 0.25rem;\n  border-top-left-radius: 0.25rem;\n}\n\n.list-group-item:last-child {\n  margin-bottom: 0;\n  border-bottom-right-radius: 0.25rem;\n  border-bottom-left-radius: 0.25rem;\n}\n\n.list-group-item:focus, .list-group-item:hover {\n  text-decoration: none;\n}\n\n.list-group-item.disabled, .list-group-item:disabled {\n  color: #636c72;\n  cursor: not-allowed;\n  background-color: #fff;\n}\n\n.list-group-item.disabled .list-group-item-heading, .list-group-item:disabled .list-group-item-heading {\n  color: inherit;\n}\n\n.list-group-item.disabled .list-group-item-text, .list-group-item:disabled .list-group-item-text {\n  color: #636c72;\n}\n\n.list-group-item.active {\n  z-index: 2;\n  color: #fff;\n  background-color: #0275d8;\n  border-color: #0275d8;\n}\n\n.list-group-item.active .list-group-item-heading,\n.list-group-item.active .list-group-item-heading > small,\n.list-group-item.active .list-group-item-heading > .small {\n  color: inherit;\n}\n\n.list-group-item.active .list-group-item-text {\n  color: #daeeff;\n}\n\n.list-group-flush .list-group-item {\n  border-right: 0;\n  border-left: 0;\n  border-radius: 0;\n}\n\n.list-group-flush:first-child .list-group-item:first-child {\n  border-top: 0;\n}\n\n.list-group-flush:last-child .list-group-item:last-child {\n  border-bottom: 0;\n}\n\n.list-group-item-success {\n  color: #3c763d;\n  background-color: #dff0d8;\n}\n\na.list-group-item-success,\nbutton.list-group-item-success {\n  color: #3c763d;\n}\n\na.list-group-item-success .list-group-item-heading,\nbutton.list-group-item-success .list-group-item-heading {\n  color: inherit;\n}\n\na.list-group-item-success:focus, a.list-group-item-success:hover,\nbutton.list-group-item-success:focus,\nbutton.list-group-item-success:hover {\n  color: #3c763d;\n  background-color: #d0e9c6;\n}\n\na.list-group-item-success.active,\nbutton.list-group-item-success.active {\n  color: #fff;\n  background-color: #3c763d;\n  border-color: #3c763d;\n}\n\n.list-group-item-info {\n  color: #31708f;\n  background-color: #d9edf7;\n}\n\na.list-group-item-info,\nbutton.list-group-item-info {\n  color: #31708f;\n}\n\na.list-group-item-info .list-group-item-heading,\nbutton.list-group-item-info .list-group-item-heading {\n  color: inherit;\n}\n\na.list-group-item-info:focus, a.list-group-item-info:hover,\nbutton.list-group-item-info:focus,\nbutton.list-group-item-info:hover {\n  color: #31708f;\n  background-color: #c4e3f3;\n}\n\na.list-group-item-info.active,\nbutton.list-group-item-info.active {\n  color: #fff;\n  background-color: #31708f;\n  border-color: #31708f;\n}\n\n.list-group-item-warning {\n  color: #8a6d3b;\n  background-color: #fcf8e3;\n}\n\na.list-group-item-warning,\nbutton.list-group-item-warning {\n  color: #8a6d3b;\n}\n\na.list-group-item-warning .list-group-item-heading,\nbutton.list-group-item-warning .list-group-item-heading {\n  color: inherit;\n}\n\na.list-group-item-warning:focus, a.list-group-item-warning:hover,\nbutton.list-group-item-warning:focus,\nbutton.list-group-item-warning:hover {\n  color: #8a6d3b;\n  background-color: #faf2cc;\n}\n\na.list-group-item-warning.active,\nbutton.list-group-item-warning.active {\n  color: #fff;\n  background-color: #8a6d3b;\n  border-color: #8a6d3b;\n}\n\n.list-group-item-danger {\n  color: #a94442;\n  background-color: #f2dede;\n}\n\na.list-group-item-danger,\nbutton.list-group-item-danger {\n  color: #a94442;\n}\n\na.list-group-item-danger .list-group-item-heading,\nbutton.list-group-item-danger .list-group-item-heading {\n  color: inherit;\n}\n\na.list-group-item-danger:focus, a.list-group-item-danger:hover,\nbutton.list-group-item-danger:focus,\nbutton.list-group-item-danger:hover {\n  color: #a94442;\n  background-color: #ebcccc;\n}\n\na.list-group-item-danger.active,\nbutton.list-group-item-danger.active {\n  color: #fff;\n  background-color: #a94442;\n  border-color: #a94442;\n}\n\n.embed-responsive {\n  position: relative;\n  display: block;\n  width: 100%;\n  padding: 0;\n  overflow: hidden;\n}\n\n.embed-responsive::before {\n  display: block;\n  content: \"\";\n}\n\n.embed-responsive .embed-responsive-item,\n.embed-responsive iframe,\n.embed-responsive embed,\n.embed-responsive object,\n.embed-responsive video {\n  position: absolute;\n  top: 0;\n  bottom: 0;\n  left: 0;\n  width: 100%;\n  height: 100%;\n  border: 0;\n}\n\n.embed-responsive-21by9::before {\n  padding-top: 42.857143%;\n}\n\n.embed-responsive-16by9::before {\n  padding-top: 56.25%;\n}\n\n.embed-responsive-4by3::before {\n  padding-top: 75%;\n}\n\n.embed-responsive-1by1::before {\n  padding-top: 100%;\n}\n\n.close {\n  float: right;\n  font-size: 1.5rem;\n  font-weight: bold;\n  line-height: 1;\n  color: #000;\n  text-shadow: 0 1px 0 #fff;\n  opacity: .5;\n}\n\n.close:focus, .close:hover {\n  color: #000;\n  text-decoration: none;\n  cursor: pointer;\n  opacity: .75;\n}\n\nbutton.close {\n  padding: 0;\n  cursor: pointer;\n  background: transparent;\n  border: 0;\n  -webkit-appearance: none;\n}\n\n.modal-open {\n  overflow: hidden;\n}\n\n.modal {\n  position: fixed;\n  top: 0;\n  right: 0;\n  bottom: 0;\n  left: 0;\n  z-index: 1050;\n  display: none;\n  overflow: hidden;\n  outline: 0;\n}\n\n.modal.fade .modal-dialog {\n  -webkit-transition: -webkit-transform 0.3s ease-out;\n  transition: -webkit-transform 0.3s ease-out;\n  -o-transition: -o-transform 0.3s ease-out;\n  transition: transform 0.3s ease-out;\n  transition: transform 0.3s ease-out, -webkit-transform 0.3s ease-out, -o-transform 0.3s ease-out;\n  -webkit-transform: translate(0, -25%);\n       -o-transform: translate(0, -25%);\n          transform: translate(0, -25%);\n}\n\n.modal.show .modal-dialog {\n  -webkit-transform: translate(0, 0);\n       -o-transform: translate(0, 0);\n          transform: translate(0, 0);\n}\n\n.modal-open .modal {\n  overflow-x: hidden;\n  overflow-y: auto;\n}\n\n.modal-dialog {\n  position: relative;\n  width: auto;\n  margin: 10px;\n}\n\n.modal-content {\n  position: relative;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-orient: vertical;\n  -webkit-box-direction: normal;\n  -webkit-flex-direction: column;\n      -ms-flex-direction: column;\n          flex-direction: column;\n  background-color: #fff;\n  -webkit-background-clip: padding-box;\n          background-clip: padding-box;\n  border: 1px solid rgba(0, 0, 0, 0.2);\n  border-radius: 0.3rem;\n  outline: 0;\n}\n\n.modal-backdrop {\n  position: fixed;\n  top: 0;\n  right: 0;\n  bottom: 0;\n  left: 0;\n  z-index: 1040;\n  background-color: #000;\n}\n\n.modal-backdrop.fade {\n  opacity: 0;\n}\n\n.modal-backdrop.show {\n  opacity: 0.5;\n}\n\n.modal-header {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n  -webkit-box-pack: justify;\n  -webkit-justify-content: space-between;\n      -ms-flex-pack: justify;\n          justify-content: space-between;\n  padding: 15px;\n  border-bottom: 1px solid #eceeef;\n}\n\n.modal-title {\n  margin-bottom: 0;\n  line-height: 1.5;\n}\n\n.modal-body {\n  position: relative;\n  -webkit-box-flex: 1;\n  -webkit-flex: 1 1 auto;\n      -ms-flex: 1 1 auto;\n          flex: 1 1 auto;\n  padding: 15px;\n}\n\n.modal-footer {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n  -webkit-box-pack: end;\n  -webkit-justify-content: flex-end;\n      -ms-flex-pack: end;\n          justify-content: flex-end;\n  padding: 15px;\n  border-top: 1px solid #eceeef;\n}\n\n.modal-footer > :not(:first-child) {\n  margin-left: .25rem;\n}\n\n.modal-footer > :not(:last-child) {\n  margin-right: .25rem;\n}\n\n.modal-scrollbar-measure {\n  position: absolute;\n  top: -9999px;\n  width: 50px;\n  height: 50px;\n  overflow: scroll;\n}\n\n@media (min-width: 576px) {\n  .modal-dialog {\n    max-width: 500px;\n    margin: 30px auto;\n  }\n  .modal-sm {\n    max-width: 300px;\n  }\n}\n\n@media (min-width: 992px) {\n  .modal-lg {\n    max-width: 800px;\n  }\n}\n\n.tooltip {\n  position: absolute;\n  z-index: 1070;\n  display: block;\n  font-family: -apple-system, system-ui, BlinkMacSystemFont, \"Segoe UI\", Roboto, \"Helvetica Neue\", Arial, sans-serif;\n  font-style: normal;\n  font-weight: normal;\n  letter-spacing: normal;\n  line-break: auto;\n  line-height: 1.5;\n  text-align: left;\n  text-align: start;\n  text-decoration: none;\n  text-shadow: none;\n  text-transform: none;\n  white-space: normal;\n  word-break: normal;\n  word-spacing: normal;\n  font-size: 0.875rem;\n  word-wrap: break-word;\n  opacity: 0;\n}\n\n.tooltip.show {\n  opacity: 0.9;\n}\n\n.tooltip.tooltip-top, .tooltip.bs-tether-element-attached-bottom {\n  padding: 5px 0;\n  margin-top: -3px;\n}\n\n.tooltip.tooltip-top .tooltip-inner::before, .tooltip.bs-tether-element-attached-bottom .tooltip-inner::before {\n  bottom: 0;\n  left: 50%;\n  margin-left: -5px;\n  content: \"\";\n  border-width: 5px 5px 0;\n  border-top-color: #000;\n}\n\n.tooltip.tooltip-right, .tooltip.bs-tether-element-attached-left {\n  padding: 0 5px;\n  margin-left: 3px;\n}\n\n.tooltip.tooltip-right .tooltip-inner::before, .tooltip.bs-tether-element-attached-left .tooltip-inner::before {\n  top: 50%;\n  left: 0;\n  margin-top: -5px;\n  content: \"\";\n  border-width: 5px 5px 5px 0;\n  border-right-color: #000;\n}\n\n.tooltip.tooltip-bottom, .tooltip.bs-tether-element-attached-top {\n  padding: 5px 0;\n  margin-top: 3px;\n}\n\n.tooltip.tooltip-bottom .tooltip-inner::before, .tooltip.bs-tether-element-attached-top .tooltip-inner::before {\n  top: 0;\n  left: 50%;\n  margin-left: -5px;\n  content: \"\";\n  border-width: 0 5px 5px;\n  border-bottom-color: #000;\n}\n\n.tooltip.tooltip-left, .tooltip.bs-tether-element-attached-right {\n  padding: 0 5px;\n  margin-left: -3px;\n}\n\n.tooltip.tooltip-left .tooltip-inner::before, .tooltip.bs-tether-element-attached-right .tooltip-inner::before {\n  top: 50%;\n  right: 0;\n  margin-top: -5px;\n  content: \"\";\n  border-width: 5px 0 5px 5px;\n  border-left-color: #000;\n}\n\n.tooltip-inner {\n  max-width: 200px;\n  padding: 3px 8px;\n  color: #fff;\n  text-align: center;\n  background-color: #000;\n  border-radius: 0.25rem;\n}\n\n.tooltip-inner::before {\n  position: absolute;\n  width: 0;\n  height: 0;\n  border-color: transparent;\n  border-style: solid;\n}\n\n.popover {\n  position: absolute;\n  top: 0;\n  left: 0;\n  z-index: 1060;\n  display: block;\n  max-width: 276px;\n  padding: 1px;\n  font-family: -apple-system, system-ui, BlinkMacSystemFont, \"Segoe UI\", Roboto, \"Helvetica Neue\", Arial, sans-serif;\n  font-style: normal;\n  font-weight: normal;\n  letter-spacing: normal;\n  line-break: auto;\n  line-height: 1.5;\n  text-align: left;\n  text-align: start;\n  text-decoration: none;\n  text-shadow: none;\n  text-transform: none;\n  white-space: normal;\n  word-break: normal;\n  word-spacing: normal;\n  font-size: 0.875rem;\n  word-wrap: break-word;\n  background-color: #fff;\n  -webkit-background-clip: padding-box;\n          background-clip: padding-box;\n  border: 1px solid rgba(0, 0, 0, 0.2);\n  border-radius: 0.3rem;\n}\n\n.popover.popover-top, .popover.bs-tether-element-attached-bottom {\n  margin-top: -10px;\n}\n\n.popover.popover-top::before, .popover.popover-top::after, .popover.bs-tether-element-attached-bottom::before, .popover.bs-tether-element-attached-bottom::after {\n  left: 50%;\n  border-bottom-width: 0;\n}\n\n.popover.popover-top::before, .popover.bs-tether-element-attached-bottom::before {\n  bottom: -11px;\n  margin-left: -11px;\n  border-top-color: rgba(0, 0, 0, 0.25);\n}\n\n.popover.popover-top::after, .popover.bs-tether-element-attached-bottom::after {\n  bottom: -10px;\n  margin-left: -10px;\n  border-top-color: #fff;\n}\n\n.popover.popover-right, .popover.bs-tether-element-attached-left {\n  margin-left: 10px;\n}\n\n.popover.popover-right::before, .popover.popover-right::after, .popover.bs-tether-element-attached-left::before, .popover.bs-tether-element-attached-left::after {\n  top: 50%;\n  border-left-width: 0;\n}\n\n.popover.popover-right::before, .popover.bs-tether-element-attached-left::before {\n  left: -11px;\n  margin-top: -11px;\n  border-right-color: rgba(0, 0, 0, 0.25);\n}\n\n.popover.popover-right::after, .popover.bs-tether-element-attached-left::after {\n  left: -10px;\n  margin-top: -10px;\n  border-right-color: #fff;\n}\n\n.popover.popover-bottom, .popover.bs-tether-element-attached-top {\n  margin-top: 10px;\n}\n\n.popover.popover-bottom::before, .popover.popover-bottom::after, .popover.bs-tether-element-attached-top::before, .popover.bs-tether-element-attached-top::after {\n  left: 50%;\n  border-top-width: 0;\n}\n\n.popover.popover-bottom::before, .popover.bs-tether-element-attached-top::before {\n  top: -11px;\n  margin-left: -11px;\n  border-bottom-color: rgba(0, 0, 0, 0.25);\n}\n\n.popover.popover-bottom::after, .popover.bs-tether-element-attached-top::after {\n  top: -10px;\n  margin-left: -10px;\n  border-bottom-color: #f7f7f7;\n}\n\n.popover.popover-bottom .popover-title::before, .popover.bs-tether-element-attached-top .popover-title::before {\n  position: absolute;\n  top: 0;\n  left: 50%;\n  display: block;\n  width: 20px;\n  margin-left: -10px;\n  content: \"\";\n  border-bottom: 1px solid #f7f7f7;\n}\n\n.popover.popover-left, .popover.bs-tether-element-attached-right {\n  margin-left: -10px;\n}\n\n.popover.popover-left::before, .popover.popover-left::after, .popover.bs-tether-element-attached-right::before, .popover.bs-tether-element-attached-right::after {\n  top: 50%;\n  border-right-width: 0;\n}\n\n.popover.popover-left::before, .popover.bs-tether-element-attached-right::before {\n  right: -11px;\n  margin-top: -11px;\n  border-left-color: rgba(0, 0, 0, 0.25);\n}\n\n.popover.popover-left::after, .popover.bs-tether-element-attached-right::after {\n  right: -10px;\n  margin-top: -10px;\n  border-left-color: #fff;\n}\n\n.popover-title {\n  padding: 8px 14px;\n  margin-bottom: 0;\n  font-size: 1rem;\n  background-color: #f7f7f7;\n  border-bottom: 1px solid #ebebeb;\n  border-top-right-radius: calc(0.3rem - 1px);\n  border-top-left-radius: calc(0.3rem - 1px);\n}\n\n.popover-title:empty {\n  display: none;\n}\n\n.popover-content {\n  padding: 9px 14px;\n}\n\n.popover::before,\n.popover::after {\n  position: absolute;\n  display: block;\n  width: 0;\n  height: 0;\n  border-color: transparent;\n  border-style: solid;\n}\n\n.popover::before {\n  content: \"\";\n  border-width: 11px;\n}\n\n.popover::after {\n  content: \"\";\n  border-width: 10px;\n}\n\n.carousel {\n  position: relative;\n}\n\n.carousel-inner {\n  position: relative;\n  width: 100%;\n  overflow: hidden;\n}\n\n.carousel-item {\n  position: relative;\n  display: none;\n  width: 100%;\n}\n\n@media (-webkit-transform-3d) {\n  .carousel-item {\n    -webkit-transition: -webkit-transform 0.6s ease-in-out;\n    transition: -webkit-transform 0.6s ease-in-out;\n    -o-transition: -o-transform 0.6s ease-in-out;\n    transition: transform 0.6s ease-in-out;\n    transition: transform 0.6s ease-in-out, -webkit-transform 0.6s ease-in-out, -o-transform 0.6s ease-in-out;\n    -webkit-backface-visibility: hidden;\n            backface-visibility: hidden;\n    -webkit-perspective: 1000px;\n            perspective: 1000px;\n  }\n}\n\n@supports ((-webkit-transform: translate3d(0, 0, 0)) or (transform: translate3d(0, 0, 0))) {\n  .carousel-item {\n    -webkit-transition: -webkit-transform 0.6s ease-in-out;\n    transition: -webkit-transform 0.6s ease-in-out;\n    -o-transition: -o-transform 0.6s ease-in-out;\n    transition: transform 0.6s ease-in-out;\n    transition: transform 0.6s ease-in-out, -webkit-transform 0.6s ease-in-out, -o-transform 0.6s ease-in-out;\n    -webkit-backface-visibility: hidden;\n            backface-visibility: hidden;\n    -webkit-perspective: 1000px;\n            perspective: 1000px;\n  }\n}\n\n.carousel-item.active,\n.carousel-item-next,\n.carousel-item-prev {\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n}\n\n.carousel-item-next,\n.carousel-item-prev {\n  position: absolute;\n  top: 0;\n}\n\n@media (-webkit-transform-3d) {\n  .carousel-item-next.carousel-item-left,\n  .carousel-item-prev.carousel-item-right {\n    -webkit-transform: translate3d(0, 0, 0);\n            transform: translate3d(0, 0, 0);\n  }\n  .carousel-item-next,\n  .active.carousel-item-right {\n    -webkit-transform: translate3d(100%, 0, 0);\n            transform: translate3d(100%, 0, 0);\n  }\n  .carousel-item-prev,\n  .active.carousel-item-left {\n    -webkit-transform: translate3d(-100%, 0, 0);\n            transform: translate3d(-100%, 0, 0);\n  }\n}\n\n@supports ((-webkit-transform: translate3d(0, 0, 0)) or (transform: translate3d(0, 0, 0))) {\n  .carousel-item-next.carousel-item-left,\n  .carousel-item-prev.carousel-item-right {\n    -webkit-transform: translate3d(0, 0, 0);\n            transform: translate3d(0, 0, 0);\n  }\n  .carousel-item-next,\n  .active.carousel-item-right {\n    -webkit-transform: translate3d(100%, 0, 0);\n            transform: translate3d(100%, 0, 0);\n  }\n  .carousel-item-prev,\n  .active.carousel-item-left {\n    -webkit-transform: translate3d(-100%, 0, 0);\n            transform: translate3d(-100%, 0, 0);\n  }\n}\n\n.carousel-control-prev,\n.carousel-control-next {\n  position: absolute;\n  top: 0;\n  bottom: 0;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-align: center;\n  -webkit-align-items: center;\n      -ms-flex-align: center;\n          align-items: center;\n  -webkit-box-pack: center;\n  -webkit-justify-content: center;\n      -ms-flex-pack: center;\n          justify-content: center;\n  width: 15%;\n  color: #fff;\n  text-align: center;\n  opacity: 0.5;\n}\n\n.carousel-control-prev:focus, .carousel-control-prev:hover,\n.carousel-control-next:focus,\n.carousel-control-next:hover {\n  color: #fff;\n  text-decoration: none;\n  outline: 0;\n  opacity: .9;\n}\n\n.carousel-control-prev {\n  left: 0;\n}\n\n.carousel-control-next {\n  right: 0;\n}\n\n.carousel-control-prev-icon,\n.carousel-control-next-icon {\n  display: inline-block;\n  width: 20px;\n  height: 20px;\n  background: transparent no-repeat center center;\n  -webkit-background-size: 100% 100%;\n          background-size: 100% 100%;\n}\n\n.carousel-control-prev-icon {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23fff' viewBox='0 0 8 8'%3E%3Cpath d='M4 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E\");\n}\n\n.carousel-control-next-icon {\n  background-image: url(\"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23fff' viewBox='0 0 8 8'%3E%3Cpath d='M1.5 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E\");\n}\n\n.carousel-indicators {\n  position: absolute;\n  right: 0;\n  bottom: 10px;\n  left: 0;\n  z-index: 15;\n  display: -webkit-box;\n  display: -webkit-flex;\n  display: -ms-flexbox;\n  display: flex;\n  -webkit-box-pack: center;\n  -webkit-justify-content: center;\n      -ms-flex-pack: center;\n          justify-content: center;\n  padding-left: 0;\n  margin-right: 15%;\n  margin-left: 15%;\n  list-style: none;\n}\n\n.carousel-indicators li {\n  position: relative;\n  -webkit-box-flex: 1;\n  -webkit-flex: 1 0 auto;\n      -ms-flex: 1 0 auto;\n          flex: 1 0 auto;\n  max-width: 30px;\n  height: 3px;\n  margin-right: 3px;\n  margin-left: 3px;\n  text-indent: -999px;\n  cursor: pointer;\n  background-color: rgba(255, 255, 255, 0.5);\n}\n\n.carousel-indicators li::before {\n  position: absolute;\n  top: -10px;\n  left: 0;\n  display: inline-block;\n  width: 100%;\n  height: 10px;\n  content: \"\";\n}\n\n.carousel-indicators li::after {\n  position: absolute;\n  bottom: -10px;\n  left: 0;\n  display: inline-block;\n  width: 100%;\n  height: 10px;\n  content: \"\";\n}\n\n.carousel-indicators .active {\n  background-color: #fff;\n}\n\n.carousel-caption {\n  position: absolute;\n  right: 15%;\n  bottom: 20px;\n  left: 15%;\n  z-index: 10;\n  padding-top: 20px;\n  padding-bottom: 20px;\n  color: #fff;\n  text-align: center;\n}\n\n.align-baseline {\n  vertical-align: baseline !important;\n}\n\n.align-top {\n  vertical-align: top !important;\n}\n\n.align-middle {\n  vertical-align: middle !important;\n}\n\n.align-bottom {\n  vertical-align: bottom !important;\n}\n\n.align-text-bottom {\n  vertical-align: text-bottom !important;\n}\n\n.align-text-top {\n  vertical-align: text-top !important;\n}\n\n.bg-faded {\n  background-color: #f7f7f7;\n}\n\n.bg-primary {\n  background-color: #0275d8 !important;\n}\n\na.bg-primary:focus, a.bg-primary:hover {\n  background-color: #025aa5 !important;\n}\n\n.bg-success {\n  background-color: #5cb85c !important;\n}\n\na.bg-success:focus, a.bg-success:hover {\n  background-color: #449d44 !important;\n}\n\n.bg-info {\n  background-color: #5bc0de !important;\n}\n\na.bg-info:focus, a.bg-info:hover {\n  background-color: #31b0d5 !important;\n}\n\n.bg-warning {\n  background-color: #f0ad4e !important;\n}\n\na.bg-warning:focus, a.bg-warning:hover {\n  background-color: #ec971f !important;\n}\n\n.bg-danger {\n  background-color: #d9534f !important;\n}\n\na.bg-danger:focus, a.bg-danger:hover {\n  background-color: #c9302c !important;\n}\n\n.bg-inverse {\n  background-color: #292b2c !important;\n}\n\na.bg-inverse:focus, a.bg-inverse:hover {\n  background-color: #101112 !important;\n}\n\n.border-0 {\n  border: 0 !important;\n}\n\n.border-top-0 {\n  border-top: 0 !important;\n}\n\n.border-right-0 {\n  border-right: 0 !important;\n}\n\n.border-bottom-0 {\n  border-bottom: 0 !important;\n}\n\n.border-left-0 {\n  border-left: 0 !important;\n}\n\n.rounded {\n  border-radius: 0.25rem;\n}\n\n.rounded-top {\n  border-top-right-radius: 0.25rem;\n  border-top-left-radius: 0.25rem;\n}\n\n.rounded-right {\n  border-bottom-right-radius: 0.25rem;\n  border-top-right-radius: 0.25rem;\n}\n\n.rounded-bottom {\n  border-bottom-right-radius: 0.25rem;\n  border-bottom-left-radius: 0.25rem;\n}\n\n.rounded-left {\n  border-bottom-left-radius: 0.25rem;\n  border-top-left-radius: 0.25rem;\n}\n\n.rounded-circle {\n  border-radius: 50%;\n}\n\n.rounded-0 {\n  border-radius: 0;\n}\n\n.clearfix::after {\n  display: block;\n  content: \"\";\n  clear: both;\n}\n\n.d-none {\n  display: none !important;\n}\n\n.d-inline {\n  display: inline !important;\n}\n\n.d-inline-block {\n  display: inline-block !important;\n}\n\n.d-block {\n  display: block !important;\n}\n\n.d-table {\n  display: table !important;\n}\n\n.d-table-cell {\n  display: table-cell !important;\n}\n\n.d-flex {\n  display: -webkit-box !important;\n  display: -webkit-flex !important;\n  display: -ms-flexbox !important;\n  display: flex !important;\n}\n\n.d-inline-flex {\n  display: -webkit-inline-box !important;\n  display: -webkit-inline-flex !important;\n  display: -ms-inline-flexbox !important;\n  display: inline-flex !important;\n}\n\n@media (min-width: 576px) {\n  .d-sm-none {\n    display: none !important;\n  }\n  .d-sm-inline {\n    display: inline !important;\n  }\n  .d-sm-inline-block {\n    display: inline-block !important;\n  }\n  .d-sm-block {\n    display: block !important;\n  }\n  .d-sm-table {\n    display: table !important;\n  }\n  .d-sm-table-cell {\n    display: table-cell !important;\n  }\n  .d-sm-flex {\n    display: -webkit-box !important;\n    display: -webkit-flex !important;\n    display: -ms-flexbox !important;\n    display: flex !important;\n  }\n  .d-sm-inline-flex {\n    display: -webkit-inline-box !important;\n    display: -webkit-inline-flex !important;\n    display: -ms-inline-flexbox !important;\n    display: inline-flex !important;\n  }\n}\n\n@media (min-width: 768px) {\n  .d-md-none {\n    display: none !important;\n  }\n  .d-md-inline {\n    display: inline !important;\n  }\n  .d-md-inline-block {\n    display: inline-block !important;\n  }\n  .d-md-block {\n    display: block !important;\n  }\n  .d-md-table {\n    display: table !important;\n  }\n  .d-md-table-cell {\n    display: table-cell !important;\n  }\n  .d-md-flex {\n    display: -webkit-box !important;\n    display: -webkit-flex !important;\n    display: -ms-flexbox !important;\n    display: flex !important;\n  }\n  .d-md-inline-flex {\n    display: -webkit-inline-box !important;\n    display: -webkit-inline-flex !important;\n    display: -ms-inline-flexbox !important;\n    display: inline-flex !important;\n  }\n}\n\n@media (min-width: 992px) {\n  .d-lg-none {\n    display: none !important;\n  }\n  .d-lg-inline {\n    display: inline !important;\n  }\n  .d-lg-inline-block {\n    display: inline-block !important;\n  }\n  .d-lg-block {\n    display: block !important;\n  }\n  .d-lg-table {\n    display: table !important;\n  }\n  .d-lg-table-cell {\n    display: table-cell !important;\n  }\n  .d-lg-flex {\n    display: -webkit-box !important;\n    display: -webkit-flex !important;\n    display: -ms-flexbox !important;\n    display: flex !important;\n  }\n  .d-lg-inline-flex {\n    display: -webkit-inline-box !important;\n    display: -webkit-inline-flex !important;\n    display: -ms-inline-flexbox !important;\n    display: inline-flex !important;\n  }\n}\n\n@media (min-width: 1200px) {\n  .d-xl-none {\n    display: none !important;\n  }\n  .d-xl-inline {\n    display: inline !important;\n  }\n  .d-xl-inline-block {\n    display: inline-block !important;\n  }\n  .d-xl-block {\n    display: block !important;\n  }\n  .d-xl-table {\n    display: table !important;\n  }\n  .d-xl-table-cell {\n    display: table-cell !important;\n  }\n  .d-xl-flex {\n    display: -webkit-box !important;\n    display: -webkit-flex !important;\n    display: -ms-flexbox !important;\n    display: flex !important;\n  }\n  .d-xl-inline-flex {\n    display: -webkit-inline-box !important;\n    display: -webkit-inline-flex !important;\n    display: -ms-inline-flexbox !important;\n    display: inline-flex !important;\n  }\n}\n\n.flex-first {\n  -webkit-box-ordinal-group: 0;\n  -webkit-order: -1;\n      -ms-flex-order: -1;\n          order: -1;\n}\n\n.flex-last {\n  -webkit-box-ordinal-group: 2;\n  -webkit-order: 1;\n      -ms-flex-order: 1;\n          order: 1;\n}\n\n.flex-unordered {\n  -webkit-box-ordinal-group: 1;\n  -webkit-order: 0;\n      -ms-flex-order: 0;\n          order: 0;\n}\n\n.flex-row {\n  -webkit-box-orient: horizontal !important;\n  -webkit-box-direction: normal !important;\n  -webkit-flex-direction: row !important;\n      -ms-flex-direction: row !important;\n          flex-direction: row !important;\n}\n\n.flex-column {\n  -webkit-box-orient: vertical !important;\n  -webkit-box-direction: normal !important;\n  -webkit-flex-direction: column !important;\n      -ms-flex-direction: column !important;\n          flex-direction: column !important;\n}\n\n.flex-row-reverse {\n  -webkit-box-orient: horizontal !important;\n  -webkit-box-direction: reverse !important;\n  -webkit-flex-direction: row-reverse !important;\n      -ms-flex-direction: row-reverse !important;\n          flex-direction: row-reverse !important;\n}\n\n.flex-column-reverse {\n  -webkit-box-orient: vertical !important;\n  -webkit-box-direction: reverse !important;\n  -webkit-flex-direction: column-reverse !important;\n      -ms-flex-direction: column-reverse !important;\n          flex-direction: column-reverse !important;\n}\n\n.flex-wrap {\n  -webkit-flex-wrap: wrap !important;\n      -ms-flex-wrap: wrap !important;\n          flex-wrap: wrap !important;\n}\n\n.flex-nowrap {\n  -webkit-flex-wrap: nowrap !important;\n      -ms-flex-wrap: nowrap !important;\n          flex-wrap: nowrap !important;\n}\n\n.flex-wrap-reverse {\n  -webkit-flex-wrap: wrap-reverse !important;\n      -ms-flex-wrap: wrap-reverse !important;\n          flex-wrap: wrap-reverse !important;\n}\n\n.justify-content-start {\n  -webkit-box-pack: start !important;\n  -webkit-justify-content: flex-start !important;\n      -ms-flex-pack: start !important;\n          justify-content: flex-start !important;\n}\n\n.justify-content-end {\n  -webkit-box-pack: end !important;\n  -webkit-justify-content: flex-end !important;\n      -ms-flex-pack: end !important;\n          justify-content: flex-end !important;\n}\n\n.justify-content-center {\n  -webkit-box-pack: center !important;\n  -webkit-justify-content: center !important;\n      -ms-flex-pack: center !important;\n          justify-content: center !important;\n}\n\n.justify-content-between {\n  -webkit-box-pack: justify !important;\n  -webkit-justify-content: space-between !important;\n      -ms-flex-pack: justify !important;\n          justify-content: space-between !important;\n}\n\n.justify-content-around {\n  -webkit-justify-content: space-around !important;\n      -ms-flex-pack: distribute !important;\n          justify-content: space-around !important;\n}\n\n.align-items-start {\n  -webkit-box-align: start !important;\n  -webkit-align-items: flex-start !important;\n      -ms-flex-align: start !important;\n          align-items: flex-start !important;\n}\n\n.align-items-end {\n  -webkit-box-align: end !important;\n  -webkit-align-items: flex-end !important;\n      -ms-flex-align: end !important;\n          align-items: flex-end !important;\n}\n\n.align-items-center {\n  -webkit-box-align: center !important;\n  -webkit-align-items: center !important;\n      -ms-flex-align: center !important;\n          align-items: center !important;\n}\n\n.align-items-baseline {\n  -webkit-box-align: baseline !important;\n  -webkit-align-items: baseline !important;\n      -ms-flex-align: baseline !important;\n          align-items: baseline !important;\n}\n\n.align-items-stretch {\n  -webkit-box-align: stretch !important;\n  -webkit-align-items: stretch !important;\n      -ms-flex-align: stretch !important;\n          align-items: stretch !important;\n}\n\n.align-content-start {\n  -webkit-align-content: flex-start !important;\n      -ms-flex-line-pack: start !important;\n          align-content: flex-start !important;\n}\n\n.align-content-end {\n  -webkit-align-content: flex-end !important;\n      -ms-flex-line-pack: end !important;\n          align-content: flex-end !important;\n}\n\n.align-content-center {\n  -webkit-align-content: center !important;\n      -ms-flex-line-pack: center !important;\n          align-content: center !important;\n}\n\n.align-content-between {\n  -webkit-align-content: space-between !important;\n      -ms-flex-line-pack: justify !important;\n          align-content: space-between !important;\n}\n\n.align-content-around {\n  -webkit-align-content: space-around !important;\n      -ms-flex-line-pack: distribute !important;\n          align-content: space-around !important;\n}\n\n.align-content-stretch {\n  -webkit-align-content: stretch !important;\n      -ms-flex-line-pack: stretch !important;\n          align-content: stretch !important;\n}\n\n.align-self-auto {\n  -webkit-align-self: auto !important;\n      -ms-flex-item-align: auto !important;\n              -ms-grid-row-align: auto !important;\n          align-self: auto !important;\n}\n\n.align-self-start {\n  -webkit-align-self: flex-start !important;\n      -ms-flex-item-align: start !important;\n          align-self: flex-start !important;\n}\n\n.align-self-end {\n  -webkit-align-self: flex-end !important;\n      -ms-flex-item-align: end !important;\n          align-self: flex-end !important;\n}\n\n.align-self-center {\n  -webkit-align-self: center !important;\n      -ms-flex-item-align: center !important;\n              -ms-grid-row-align: center !important;\n          align-self: center !important;\n}\n\n.align-self-baseline {\n  -webkit-align-self: baseline !important;\n      -ms-flex-item-align: baseline !important;\n          align-self: baseline !important;\n}\n\n.align-self-stretch {\n  -webkit-align-self: stretch !important;\n      -ms-flex-item-align: stretch !important;\n              -ms-grid-row-align: stretch !important;\n          align-self: stretch !important;\n}\n\n@media (min-width: 576px) {\n  .flex-sm-first {\n    -webkit-box-ordinal-group: 0;\n    -webkit-order: -1;\n        -ms-flex-order: -1;\n            order: -1;\n  }\n  .flex-sm-last {\n    -webkit-box-ordinal-group: 2;\n    -webkit-order: 1;\n        -ms-flex-order: 1;\n            order: 1;\n  }\n  .flex-sm-unordered {\n    -webkit-box-ordinal-group: 1;\n    -webkit-order: 0;\n        -ms-flex-order: 0;\n            order: 0;\n  }\n  .flex-sm-row {\n    -webkit-box-orient: horizontal !important;\n    -webkit-box-direction: normal !important;\n    -webkit-flex-direction: row !important;\n        -ms-flex-direction: row !important;\n            flex-direction: row !important;\n  }\n  .flex-sm-column {\n    -webkit-box-orient: vertical !important;\n    -webkit-box-direction: normal !important;\n    -webkit-flex-direction: column !important;\n        -ms-flex-direction: column !important;\n            flex-direction: column !important;\n  }\n  .flex-sm-row-reverse {\n    -webkit-box-orient: horizontal !important;\n    -webkit-box-direction: reverse !important;\n    -webkit-flex-direction: row-reverse !important;\n        -ms-flex-direction: row-reverse !important;\n            flex-direction: row-reverse !important;\n  }\n  .flex-sm-column-reverse {\n    -webkit-box-orient: vertical !important;\n    -webkit-box-direction: reverse !important;\n    -webkit-flex-direction: column-reverse !important;\n        -ms-flex-direction: column-reverse !important;\n            flex-direction: column-reverse !important;\n  }\n  .flex-sm-wrap {\n    -webkit-flex-wrap: wrap !important;\n        -ms-flex-wrap: wrap !important;\n            flex-wrap: wrap !important;\n  }\n  .flex-sm-nowrap {\n    -webkit-flex-wrap: nowrap !important;\n        -ms-flex-wrap: nowrap !important;\n            flex-wrap: nowrap !important;\n  }\n  .flex-sm-wrap-reverse {\n    -webkit-flex-wrap: wrap-reverse !important;\n        -ms-flex-wrap: wrap-reverse !important;\n            flex-wrap: wrap-reverse !important;\n  }\n  .justify-content-sm-start {\n    -webkit-box-pack: start !important;\n    -webkit-justify-content: flex-start !important;\n        -ms-flex-pack: start !important;\n            justify-content: flex-start !important;\n  }\n  .justify-content-sm-end {\n    -webkit-box-pack: end !important;\n    -webkit-justify-content: flex-end !important;\n        -ms-flex-pack: end !important;\n            justify-content: flex-end !important;\n  }\n  .justify-content-sm-center {\n    -webkit-box-pack: center !important;\n    -webkit-justify-content: center !important;\n        -ms-flex-pack: center !important;\n            justify-content: center !important;\n  }\n  .justify-content-sm-between {\n    -webkit-box-pack: justify !important;\n    -webkit-justify-content: space-between !important;\n        -ms-flex-pack: justify !important;\n            justify-content: space-between !important;\n  }\n  .justify-content-sm-around {\n    -webkit-justify-content: space-around !important;\n        -ms-flex-pack: distribute !important;\n            justify-content: space-around !important;\n  }\n  .align-items-sm-start {\n    -webkit-box-align: start !important;\n    -webkit-align-items: flex-start !important;\n        -ms-flex-align: start !important;\n            align-items: flex-start !important;\n  }\n  .align-items-sm-end {\n    -webkit-box-align: end !important;\n    -webkit-align-items: flex-end !important;\n        -ms-flex-align: end !important;\n            align-items: flex-end !important;\n  }\n  .align-items-sm-center {\n    -webkit-box-align: center !important;\n    -webkit-align-items: center !important;\n        -ms-flex-align: center !important;\n            align-items: center !important;\n  }\n  .align-items-sm-baseline {\n    -webkit-box-align: baseline !important;\n    -webkit-align-items: baseline !important;\n        -ms-flex-align: baseline !important;\n            align-items: baseline !important;\n  }\n  .align-items-sm-stretch {\n    -webkit-box-align: stretch !important;\n    -webkit-align-items: stretch !important;\n        -ms-flex-align: stretch !important;\n            align-items: stretch !important;\n  }\n  .align-content-sm-start {\n    -webkit-align-content: flex-start !important;\n        -ms-flex-line-pack: start !important;\n            align-content: flex-start !important;\n  }\n  .align-content-sm-end {\n    -webkit-align-content: flex-end !important;\n        -ms-flex-line-pack: end !important;\n            align-content: flex-end !important;\n  }\n  .align-content-sm-center {\n    -webkit-align-content: center !important;\n        -ms-flex-line-pack: center !important;\n            align-content: center !important;\n  }\n  .align-content-sm-between {\n    -webkit-align-content: space-between !important;\n        -ms-flex-line-pack: justify !important;\n            align-content: space-between !important;\n  }\n  .align-content-sm-around {\n    -webkit-align-content: space-around !important;\n        -ms-flex-line-pack: distribute !important;\n            align-content: space-around !important;\n  }\n  .align-content-sm-stretch {\n    -webkit-align-content: stretch !important;\n        -ms-flex-line-pack: stretch !important;\n            align-content: stretch !important;\n  }\n  .align-self-sm-auto {\n    -webkit-align-self: auto !important;\n        -ms-flex-item-align: auto !important;\n                -ms-grid-row-align: auto !important;\n            align-self: auto !important;\n  }\n  .align-self-sm-start {\n    -webkit-align-self: flex-start !important;\n        -ms-flex-item-align: start !important;\n            align-self: flex-start !important;\n  }\n  .align-self-sm-end {\n    -webkit-align-self: flex-end !important;\n        -ms-flex-item-align: end !important;\n            align-self: flex-end !important;\n  }\n  .align-self-sm-center {\n    -webkit-align-self: center !important;\n        -ms-flex-item-align: center !important;\n                -ms-grid-row-align: center !important;\n            align-self: center !important;\n  }\n  .align-self-sm-baseline {\n    -webkit-align-self: baseline !important;\n        -ms-flex-item-align: baseline !important;\n            align-self: baseline !important;\n  }\n  .align-self-sm-stretch {\n    -webkit-align-self: stretch !important;\n        -ms-flex-item-align: stretch !important;\n                -ms-grid-row-align: stretch !important;\n            align-self: stretch !important;\n  }\n}\n\n@media (min-width: 768px) {\n  .flex-md-first {\n    -webkit-box-ordinal-group: 0;\n    -webkit-order: -1;\n        -ms-flex-order: -1;\n            order: -1;\n  }\n  .flex-md-last {\n    -webkit-box-ordinal-group: 2;\n    -webkit-order: 1;\n        -ms-flex-order: 1;\n            order: 1;\n  }\n  .flex-md-unordered {\n    -webkit-box-ordinal-group: 1;\n    -webkit-order: 0;\n        -ms-flex-order: 0;\n            order: 0;\n  }\n  .flex-md-row {\n    -webkit-box-orient: horizontal !important;\n    -webkit-box-direction: normal !important;\n    -webkit-flex-direction: row !important;\n        -ms-flex-direction: row !important;\n            flex-direction: row !important;\n  }\n  .flex-md-column {\n    -webkit-box-orient: vertical !important;\n    -webkit-box-direction: normal !important;\n    -webkit-flex-direction: column !important;\n        -ms-flex-direction: column !important;\n            flex-direction: column !important;\n  }\n  .flex-md-row-reverse {\n    -webkit-box-orient: horizontal !important;\n    -webkit-box-direction: reverse !important;\n    -webkit-flex-direction: row-reverse !important;\n        -ms-flex-direction: row-reverse !important;\n            flex-direction: row-reverse !important;\n  }\n  .flex-md-column-reverse {\n    -webkit-box-orient: vertical !important;\n    -webkit-box-direction: reverse !important;\n    -webkit-flex-direction: column-reverse !important;\n        -ms-flex-direction: column-reverse !important;\n            flex-direction: column-reverse !important;\n  }\n  .flex-md-wrap {\n    -webkit-flex-wrap: wrap !important;\n        -ms-flex-wrap: wrap !important;\n            flex-wrap: wrap !important;\n  }\n  .flex-md-nowrap {\n    -webkit-flex-wrap: nowrap !important;\n        -ms-flex-wrap: nowrap !important;\n            flex-wrap: nowrap !important;\n  }\n  .flex-md-wrap-reverse {\n    -webkit-flex-wrap: wrap-reverse !important;\n        -ms-flex-wrap: wrap-reverse !important;\n            flex-wrap: wrap-reverse !important;\n  }\n  .justify-content-md-start {\n    -webkit-box-pack: start !important;\n    -webkit-justify-content: flex-start !important;\n        -ms-flex-pack: start !important;\n            justify-content: flex-start !important;\n  }\n  .justify-content-md-end {\n    -webkit-box-pack: end !important;\n    -webkit-justify-content: flex-end !important;\n        -ms-flex-pack: end !important;\n            justify-content: flex-end !important;\n  }\n  .justify-content-md-center {\n    -webkit-box-pack: center !important;\n    -webkit-justify-content: center !important;\n        -ms-flex-pack: center !important;\n            justify-content: center !important;\n  }\n  .justify-content-md-between {\n    -webkit-box-pack: justify !important;\n    -webkit-justify-content: space-between !important;\n        -ms-flex-pack: justify !important;\n            justify-content: space-between !important;\n  }\n  .justify-content-md-around {\n    -webkit-justify-content: space-around !important;\n        -ms-flex-pack: distribute !important;\n            justify-content: space-around !important;\n  }\n  .align-items-md-start {\n    -webkit-box-align: start !important;\n    -webkit-align-items: flex-start !important;\n        -ms-flex-align: start !important;\n            align-items: flex-start !important;\n  }\n  .align-items-md-end {\n    -webkit-box-align: end !important;\n    -webkit-align-items: flex-end !important;\n        -ms-flex-align: end !important;\n            align-items: flex-end !important;\n  }\n  .align-items-md-center {\n    -webkit-box-align: center !important;\n    -webkit-align-items: center !important;\n        -ms-flex-align: center !important;\n            align-items: center !important;\n  }\n  .align-items-md-baseline {\n    -webkit-box-align: baseline !important;\n    -webkit-align-items: baseline !important;\n        -ms-flex-align: baseline !important;\n            align-items: baseline !important;\n  }\n  .align-items-md-stretch {\n    -webkit-box-align: stretch !important;\n    -webkit-align-items: stretch !important;\n        -ms-flex-align: stretch !important;\n            align-items: stretch !important;\n  }\n  .align-content-md-start {\n    -webkit-align-content: flex-start !important;\n        -ms-flex-line-pack: start !important;\n            align-content: flex-start !important;\n  }\n  .align-content-md-end {\n    -webkit-align-content: flex-end !important;\n        -ms-flex-line-pack: end !important;\n            align-content: flex-end !important;\n  }\n  .align-content-md-center {\n    -webkit-align-content: center !important;\n        -ms-flex-line-pack: center !important;\n            align-content: center !important;\n  }\n  .align-content-md-between {\n    -webkit-align-content: space-between !important;\n        -ms-flex-line-pack: justify !important;\n            align-content: space-between !important;\n  }\n  .align-content-md-around {\n    -webkit-align-content: space-around !important;\n        -ms-flex-line-pack: distribute !important;\n            align-content: space-around !important;\n  }\n  .align-content-md-stretch {\n    -webkit-align-content: stretch !important;\n        -ms-flex-line-pack: stretch !important;\n            align-content: stretch !important;\n  }\n  .align-self-md-auto {\n    -webkit-align-self: auto !important;\n        -ms-flex-item-align: auto !important;\n                -ms-grid-row-align: auto !important;\n            align-self: auto !important;\n  }\n  .align-self-md-start {\n    -webkit-align-self: flex-start !important;\n        -ms-flex-item-align: start !important;\n            align-self: flex-start !important;\n  }\n  .align-self-md-end {\n    -webkit-align-self: flex-end !important;\n        -ms-flex-item-align: end !important;\n            align-self: flex-end !important;\n  }\n  .align-self-md-center {\n    -webkit-align-self: center !important;\n        -ms-flex-item-align: center !important;\n                -ms-grid-row-align: center !important;\n            align-self: center !important;\n  }\n  .align-self-md-baseline {\n    -webkit-align-self: baseline !important;\n        -ms-flex-item-align: baseline !important;\n            align-self: baseline !important;\n  }\n  .align-self-md-stretch {\n    -webkit-align-self: stretch !important;\n        -ms-flex-item-align: stretch !important;\n                -ms-grid-row-align: stretch !important;\n            align-self: stretch !important;\n  }\n}\n\n@media (min-width: 992px) {\n  .flex-lg-first {\n    -webkit-box-ordinal-group: 0;\n    -webkit-order: -1;\n        -ms-flex-order: -1;\n            order: -1;\n  }\n  .flex-lg-last {\n    -webkit-box-ordinal-group: 2;\n    -webkit-order: 1;\n        -ms-flex-order: 1;\n            order: 1;\n  }\n  .flex-lg-unordered {\n    -webkit-box-ordinal-group: 1;\n    -webkit-order: 0;\n        -ms-flex-order: 0;\n            order: 0;\n  }\n  .flex-lg-row {\n    -webkit-box-orient: horizontal !important;\n    -webkit-box-direction: normal !important;\n    -webkit-flex-direction: row !important;\n        -ms-flex-direction: row !important;\n            flex-direction: row !important;\n  }\n  .flex-lg-column {\n    -webkit-box-orient: vertical !important;\n    -webkit-box-direction: normal !important;\n    -webkit-flex-direction: column !important;\n        -ms-flex-direction: column !important;\n            flex-direction: column !important;\n  }\n  .flex-lg-row-reverse {\n    -webkit-box-orient: horizontal !important;\n    -webkit-box-direction: reverse !important;\n    -webkit-flex-direction: row-reverse !important;\n        -ms-flex-direction: row-reverse !important;\n            flex-direction: row-reverse !important;\n  }\n  .flex-lg-column-reverse {\n    -webkit-box-orient: vertical !important;\n    -webkit-box-direction: reverse !important;\n    -webkit-flex-direction: column-reverse !important;\n        -ms-flex-direction: column-reverse !important;\n            flex-direction: column-reverse !important;\n  }\n  .flex-lg-wrap {\n    -webkit-flex-wrap: wrap !important;\n        -ms-flex-wrap: wrap !important;\n            flex-wrap: wrap !important;\n  }\n  .flex-lg-nowrap {\n    -webkit-flex-wrap: nowrap !important;\n        -ms-flex-wrap: nowrap !important;\n            flex-wrap: nowrap !important;\n  }\n  .flex-lg-wrap-reverse {\n    -webkit-flex-wrap: wrap-reverse !important;\n        -ms-flex-wrap: wrap-reverse !important;\n            flex-wrap: wrap-reverse !important;\n  }\n  .justify-content-lg-start {\n    -webkit-box-pack: start !important;\n    -webkit-justify-content: flex-start !important;\n        -ms-flex-pack: start !important;\n            justify-content: flex-start !important;\n  }\n  .justify-content-lg-end {\n    -webkit-box-pack: end !important;\n    -webkit-justify-content: flex-end !important;\n        -ms-flex-pack: end !important;\n            justify-content: flex-end !important;\n  }\n  .justify-content-lg-center {\n    -webkit-box-pack: center !important;\n    -webkit-justify-content: center !important;\n        -ms-flex-pack: center !important;\n            justify-content: center !important;\n  }\n  .justify-content-lg-between {\n    -webkit-box-pack: justify !important;\n    -webkit-justify-content: space-between !important;\n        -ms-flex-pack: justify !important;\n            justify-content: space-between !important;\n  }\n  .justify-content-lg-around {\n    -webkit-justify-content: space-around !important;\n        -ms-flex-pack: distribute !important;\n            justify-content: space-around !important;\n  }\n  .align-items-lg-start {\n    -webkit-box-align: start !important;\n    -webkit-align-items: flex-start !important;\n        -ms-flex-align: start !important;\n            align-items: flex-start !important;\n  }\n  .align-items-lg-end {\n    -webkit-box-align: end !important;\n    -webkit-align-items: flex-end !important;\n        -ms-flex-align: end !important;\n            align-items: flex-end !important;\n  }\n  .align-items-lg-center {\n    -webkit-box-align: center !important;\n    -webkit-align-items: center !important;\n        -ms-flex-align: center !important;\n            align-items: center !important;\n  }\n  .align-items-lg-baseline {\n    -webkit-box-align: baseline !important;\n    -webkit-align-items: baseline !important;\n        -ms-flex-align: baseline !important;\n            align-items: baseline !important;\n  }\n  .align-items-lg-stretch {\n    -webkit-box-align: stretch !important;\n    -webkit-align-items: stretch !important;\n        -ms-flex-align: stretch !important;\n            align-items: stretch !important;\n  }\n  .align-content-lg-start {\n    -webkit-align-content: flex-start !important;\n        -ms-flex-line-pack: start !important;\n            align-content: flex-start !important;\n  }\n  .align-content-lg-end {\n    -webkit-align-content: flex-end !important;\n        -ms-flex-line-pack: end !important;\n            align-content: flex-end !important;\n  }\n  .align-content-lg-center {\n    -webkit-align-content: center !important;\n        -ms-flex-line-pack: center !important;\n            align-content: center !important;\n  }\n  .align-content-lg-between {\n    -webkit-align-content: space-between !important;\n        -ms-flex-line-pack: justify !important;\n            align-content: space-between !important;\n  }\n  .align-content-lg-around {\n    -webkit-align-content: space-around !important;\n        -ms-flex-line-pack: distribute !important;\n            align-content: space-around !important;\n  }\n  .align-content-lg-stretch {\n    -webkit-align-content: stretch !important;\n        -ms-flex-line-pack: stretch !important;\n            align-content: stretch !important;\n  }\n  .align-self-lg-auto {\n    -webkit-align-self: auto !important;\n        -ms-flex-item-align: auto !important;\n                -ms-grid-row-align: auto !important;\n            align-self: auto !important;\n  }\n  .align-self-lg-start {\n    -webkit-align-self: flex-start !important;\n        -ms-flex-item-align: start !important;\n            align-self: flex-start !important;\n  }\n  .align-self-lg-end {\n    -webkit-align-self: flex-end !important;\n        -ms-flex-item-align: end !important;\n            align-self: flex-end !important;\n  }\n  .align-self-lg-center {\n    -webkit-align-self: center !important;\n        -ms-flex-item-align: center !important;\n                -ms-grid-row-align: center !important;\n            align-self: center !important;\n  }\n  .align-self-lg-baseline {\n    -webkit-align-self: baseline !important;\n        -ms-flex-item-align: baseline !important;\n            align-self: baseline !important;\n  }\n  .align-self-lg-stretch {\n    -webkit-align-self: stretch !important;\n        -ms-flex-item-align: stretch !important;\n                -ms-grid-row-align: stretch !important;\n            align-self: stretch !important;\n  }\n}\n\n@media (min-width: 1200px) {\n  .flex-xl-first {\n    -webkit-box-ordinal-group: 0;\n    -webkit-order: -1;\n        -ms-flex-order: -1;\n            order: -1;\n  }\n  .flex-xl-last {\n    -webkit-box-ordinal-group: 2;\n    -webkit-order: 1;\n        -ms-flex-order: 1;\n            order: 1;\n  }\n  .flex-xl-unordered {\n    -webkit-box-ordinal-group: 1;\n    -webkit-order: 0;\n        -ms-flex-order: 0;\n            order: 0;\n  }\n  .flex-xl-row {\n    -webkit-box-orient: horizontal !important;\n    -webkit-box-direction: normal !important;\n    -webkit-flex-direction: row !important;\n        -ms-flex-direction: row !important;\n            flex-direction: row !important;\n  }\n  .flex-xl-column {\n    -webkit-box-orient: vertical !important;\n    -webkit-box-direction: normal !important;\n    -webkit-flex-direction: column !important;\n        -ms-flex-direction: column !important;\n            flex-direction: column !important;\n  }\n  .flex-xl-row-reverse {\n    -webkit-box-orient: horizontal !important;\n    -webkit-box-direction: reverse !important;\n    -webkit-flex-direction: row-reverse !important;\n        -ms-flex-direction: row-reverse !important;\n            flex-direction: row-reverse !important;\n  }\n  .flex-xl-column-reverse {\n    -webkit-box-orient: vertical !important;\n    -webkit-box-direction: reverse !important;\n    -webkit-flex-direction: column-reverse !important;\n        -ms-flex-direction: column-reverse !important;\n            flex-direction: column-reverse !important;\n  }\n  .flex-xl-wrap {\n    -webkit-flex-wrap: wrap !important;\n        -ms-flex-wrap: wrap !important;\n            flex-wrap: wrap !important;\n  }\n  .flex-xl-nowrap {\n    -webkit-flex-wrap: nowrap !important;\n        -ms-flex-wrap: nowrap !important;\n            flex-wrap: nowrap !important;\n  }\n  .flex-xl-wrap-reverse {\n    -webkit-flex-wrap: wrap-reverse !important;\n        -ms-flex-wrap: wrap-reverse !important;\n            flex-wrap: wrap-reverse !important;\n  }\n  .justify-content-xl-start {\n    -webkit-box-pack: start !important;\n    -webkit-justify-content: flex-start !important;\n        -ms-flex-pack: start !important;\n            justify-content: flex-start !important;\n  }\n  .justify-content-xl-end {\n    -webkit-box-pack: end !important;\n    -webkit-justify-content: flex-end !important;\n        -ms-flex-pack: end !important;\n            justify-content: flex-end !important;\n  }\n  .justify-content-xl-center {\n    -webkit-box-pack: center !important;\n    -webkit-justify-content: center !important;\n        -ms-flex-pack: center !important;\n            justify-content: center !important;\n  }\n  .justify-content-xl-between {\n    -webkit-box-pack: justify !important;\n    -webkit-justify-content: space-between !important;\n        -ms-flex-pack: justify !important;\n            justify-content: space-between !important;\n  }\n  .justify-content-xl-around {\n    -webkit-justify-content: space-around !important;\n        -ms-flex-pack: distribute !important;\n            justify-content: space-around !important;\n  }\n  .align-items-xl-start {\n    -webkit-box-align: start !important;\n    -webkit-align-items: flex-start !important;\n        -ms-flex-align: start !important;\n            align-items: flex-start !important;\n  }\n  .align-items-xl-end {\n    -webkit-box-align: end !important;\n    -webkit-align-items: flex-end !important;\n        -ms-flex-align: end !important;\n            align-items: flex-end !important;\n  }\n  .align-items-xl-center {\n    -webkit-box-align: center !important;\n    -webkit-align-items: center !important;\n        -ms-flex-align: center !important;\n            align-items: center !important;\n  }\n  .align-items-xl-baseline {\n    -webkit-box-align: baseline !important;\n    -webkit-align-items: baseline !important;\n        -ms-flex-align: baseline !important;\n            align-items: baseline !important;\n  }\n  .align-items-xl-stretch {\n    -webkit-box-align: stretch !important;\n    -webkit-align-items: stretch !important;\n        -ms-flex-align: stretch !important;\n            align-items: stretch !important;\n  }\n  .align-content-xl-start {\n    -webkit-align-content: flex-start !important;\n        -ms-flex-line-pack: start !important;\n            align-content: flex-start !important;\n  }\n  .align-content-xl-end {\n    -webkit-align-content: flex-end !important;\n        -ms-flex-line-pack: end !important;\n            align-content: flex-end !important;\n  }\n  .align-content-xl-center {\n    -webkit-align-content: center !important;\n        -ms-flex-line-pack: center !important;\n            align-content: center !important;\n  }\n  .align-content-xl-between {\n    -webkit-align-content: space-between !important;\n        -ms-flex-line-pack: justify !important;\n            align-content: space-between !important;\n  }\n  .align-content-xl-around {\n    -webkit-align-content: space-around !important;\n        -ms-flex-line-pack: distribute !important;\n            align-content: space-around !important;\n  }\n  .align-content-xl-stretch {\n    -webkit-align-content: stretch !important;\n        -ms-flex-line-pack: stretch !important;\n            align-content: stretch !important;\n  }\n  .align-self-xl-auto {\n    -webkit-align-self: auto !important;\n        -ms-flex-item-align: auto !important;\n                -ms-grid-row-align: auto !important;\n            align-self: auto !important;\n  }\n  .align-self-xl-start {\n    -webkit-align-self: flex-start !important;\n        -ms-flex-item-align: start !important;\n            align-self: flex-start !important;\n  }\n  .align-self-xl-end {\n    -webkit-align-self: flex-end !important;\n        -ms-flex-item-align: end !important;\n            align-self: flex-end !important;\n  }\n  .align-self-xl-center {\n    -webkit-align-self: center !important;\n        -ms-flex-item-align: center !important;\n                -ms-grid-row-align: center !important;\n            align-self: center !important;\n  }\n  .align-self-xl-baseline {\n    -webkit-align-self: baseline !important;\n        -ms-flex-item-align: baseline !important;\n            align-self: baseline !important;\n  }\n  .align-self-xl-stretch {\n    -webkit-align-self: stretch !important;\n        -ms-flex-item-align: stretch !important;\n                -ms-grid-row-align: stretch !important;\n            align-self: stretch !important;\n  }\n}\n\n.float-left {\n  float: left !important;\n}\n\n.float-right {\n  float: right !important;\n}\n\n.float-none {\n  float: none !important;\n}\n\n@media (min-width: 576px) {\n  .float-sm-left {\n    float: left !important;\n  }\n  .float-sm-right {\n    float: right !important;\n  }\n  .float-sm-none {\n    float: none !important;\n  }\n}\n\n@media (min-width: 768px) {\n  .float-md-left {\n    float: left !important;\n  }\n  .float-md-right {\n    float: right !important;\n  }\n  .float-md-none {\n    float: none !important;\n  }\n}\n\n@media (min-width: 992px) {\n  .float-lg-left {\n    float: left !important;\n  }\n  .float-lg-right {\n    float: right !important;\n  }\n  .float-lg-none {\n    float: none !important;\n  }\n}\n\n@media (min-width: 1200px) {\n  .float-xl-left {\n    float: left !important;\n  }\n  .float-xl-right {\n    float: right !important;\n  }\n  .float-xl-none {\n    float: none !important;\n  }\n}\n\n.fixed-top {\n  position: fixed;\n  top: 0;\n  right: 0;\n  left: 0;\n  z-index: 1030;\n}\n\n.fixed-bottom {\n  position: fixed;\n  right: 0;\n  bottom: 0;\n  left: 0;\n  z-index: 1030;\n}\n\n.sticky-top {\n  position: -webkit-sticky;\n  position: sticky;\n  top: 0;\n  z-index: 1030;\n}\n\n.sr-only {\n  position: absolute;\n  width: 1px;\n  height: 1px;\n  padding: 0;\n  margin: -1px;\n  overflow: hidden;\n  clip: rect(0, 0, 0, 0);\n  border: 0;\n}\n\n.sr-only-focusable:active, .sr-only-focusable:focus {\n  position: static;\n  width: auto;\n  height: auto;\n  margin: 0;\n  overflow: visible;\n  clip: auto;\n}\n\n.w-25 {\n  width: 25% !important;\n}\n\n.w-50 {\n  width: 50% !important;\n}\n\n.w-75 {\n  width: 75% !important;\n}\n\n.w-100 {\n  width: 100% !important;\n}\n\n.h-25 {\n  height: 25% !important;\n}\n\n.h-50 {\n  height: 50% !important;\n}\n\n.h-75 {\n  height: 75% !important;\n}\n\n.h-100 {\n  height: 100% !important;\n}\n\n.mw-100 {\n  max-width: 100% !important;\n}\n\n.mh-100 {\n  max-height: 100% !important;\n}\n\n.m-0 {\n  margin: 0 0 !important;\n}\n\n.mt-0 {\n  margin-top: 0 !important;\n}\n\n.mr-0 {\n  margin-right: 0 !important;\n}\n\n.mb-0 {\n  margin-bottom: 0 !important;\n}\n\n.ml-0 {\n  margin-left: 0 !important;\n}\n\n.mx-0 {\n  margin-right: 0 !important;\n  margin-left: 0 !important;\n}\n\n.my-0 {\n  margin-top: 0 !important;\n  margin-bottom: 0 !important;\n}\n\n.m-1 {\n  margin: 0.25rem 0.25rem !important;\n}\n\n.mt-1 {\n  margin-top: 0.25rem !important;\n}\n\n.mr-1 {\n  margin-right: 0.25rem !important;\n}\n\n.mb-1 {\n  margin-bottom: 0.25rem !important;\n}\n\n.ml-1 {\n  margin-left: 0.25rem !important;\n}\n\n.mx-1 {\n  margin-right: 0.25rem !important;\n  margin-left: 0.25rem !important;\n}\n\n.my-1 {\n  margin-top: 0.25rem !important;\n  margin-bottom: 0.25rem !important;\n}\n\n.m-2 {\n  margin: 0.5rem 0.5rem !important;\n}\n\n.mt-2 {\n  margin-top: 0.5rem !important;\n}\n\n.mr-2 {\n  margin-right: 0.5rem !important;\n}\n\n.mb-2 {\n  margin-bottom: 0.5rem !important;\n}\n\n.ml-2 {\n  margin-left: 0.5rem !important;\n}\n\n.mx-2 {\n  margin-right: 0.5rem !important;\n  margin-left: 0.5rem !important;\n}\n\n.my-2 {\n  margin-top: 0.5rem !important;\n  margin-bottom: 0.5rem !important;\n}\n\n.m-3 {\n  margin: 1rem 1rem !important;\n}\n\n.mt-3 {\n  margin-top: 1rem !important;\n}\n\n.mr-3 {\n  margin-right: 1rem !important;\n}\n\n.mb-3 {\n  margin-bottom: 1rem !important;\n}\n\n.ml-3 {\n  margin-left: 1rem !important;\n}\n\n.mx-3 {\n  margin-right: 1rem !important;\n  margin-left: 1rem !important;\n}\n\n.my-3 {\n  margin-top: 1rem !important;\n  margin-bottom: 1rem !important;\n}\n\n.m-4 {\n  margin: 1.5rem 1.5rem !important;\n}\n\n.mt-4 {\n  margin-top: 1.5rem !important;\n}\n\n.mr-4 {\n  margin-right: 1.5rem !important;\n}\n\n.mb-4 {\n  margin-bottom: 1.5rem !important;\n}\n\n.ml-4 {\n  margin-left: 1.5rem !important;\n}\n\n.mx-4 {\n  margin-right: 1.5rem !important;\n  margin-left: 1.5rem !important;\n}\n\n.my-4 {\n  margin-top: 1.5rem !important;\n  margin-bottom: 1.5rem !important;\n}\n\n.m-5 {\n  margin: 3rem 3rem !important;\n}\n\n.mt-5 {\n  margin-top: 3rem !important;\n}\n\n.mr-5 {\n  margin-right: 3rem !important;\n}\n\n.mb-5 {\n  margin-bottom: 3rem !important;\n}\n\n.ml-5 {\n  margin-left: 3rem !important;\n}\n\n.mx-5 {\n  margin-right: 3rem !important;\n  margin-left: 3rem !important;\n}\n\n.my-5 {\n  margin-top: 3rem !important;\n  margin-bottom: 3rem !important;\n}\n\n.p-0 {\n  padding: 0 0 !important;\n}\n\n.pt-0 {\n  padding-top: 0 !important;\n}\n\n.pr-0 {\n  padding-right: 0 !important;\n}\n\n.pb-0 {\n  padding-bottom: 0 !important;\n}\n\n.pl-0 {\n  padding-left: 0 !important;\n}\n\n.px-0 {\n  padding-right: 0 !important;\n  padding-left: 0 !important;\n}\n\n.py-0 {\n  padding-top: 0 !important;\n  padding-bottom: 0 !important;\n}\n\n.p-1 {\n  padding: 0.25rem 0.25rem !important;\n}\n\n.pt-1 {\n  padding-top: 0.25rem !important;\n}\n\n.pr-1 {\n  padding-right: 0.25rem !important;\n}\n\n.pb-1 {\n  padding-bottom: 0.25rem !important;\n}\n\n.pl-1 {\n  padding-left: 0.25rem !important;\n}\n\n.px-1 {\n  padding-right: 0.25rem !important;\n  padding-left: 0.25rem !important;\n}\n\n.py-1 {\n  padding-top: 0.25rem !important;\n  padding-bottom: 0.25rem !important;\n}\n\n.p-2 {\n  padding: 0.5rem 0.5rem !important;\n}\n\n.pt-2 {\n  padding-top: 0.5rem !important;\n}\n\n.pr-2 {\n  padding-right: 0.5rem !important;\n}\n\n.pb-2 {\n  padding-bottom: 0.5rem !important;\n}\n\n.pl-2 {\n  padding-left: 0.5rem !important;\n}\n\n.px-2 {\n  padding-right: 0.5rem !important;\n  padding-left: 0.5rem !important;\n}\n\n.py-2 {\n  padding-top: 0.5rem !important;\n  padding-bottom: 0.5rem !important;\n}\n\n.p-3 {\n  padding: 1rem 1rem !important;\n}\n\n.pt-3 {\n  padding-top: 1rem !important;\n}\n\n.pr-3 {\n  padding-right: 1rem !important;\n}\n\n.pb-3 {\n  padding-bottom: 1rem !important;\n}\n\n.pl-3 {\n  padding-left: 1rem !important;\n}\n\n.px-3 {\n  padding-right: 1rem !important;\n  padding-left: 1rem !important;\n}\n\n.py-3 {\n  padding-top: 1rem !important;\n  padding-bottom: 1rem !important;\n}\n\n.p-4 {\n  padding: 1.5rem 1.5rem !important;\n}\n\n.pt-4 {\n  padding-top: 1.5rem !important;\n}\n\n.pr-4 {\n  padding-right: 1.5rem !important;\n}\n\n.pb-4 {\n  padding-bottom: 1.5rem !important;\n}\n\n.pl-4 {\n  padding-left: 1.5rem !important;\n}\n\n.px-4 {\n  padding-right: 1.5rem !important;\n  padding-left: 1.5rem !important;\n}\n\n.py-4 {\n  padding-top: 1.5rem !important;\n  padding-bottom: 1.5rem !important;\n}\n\n.p-5 {\n  padding: 3rem 3rem !important;\n}\n\n.pt-5 {\n  padding-top: 3rem !important;\n}\n\n.pr-5 {\n  padding-right: 3rem !important;\n}\n\n.pb-5 {\n  padding-bottom: 3rem !important;\n}\n\n.pl-5 {\n  padding-left: 3rem !important;\n}\n\n.px-5 {\n  padding-right: 3rem !important;\n  padding-left: 3rem !important;\n}\n\n.py-5 {\n  padding-top: 3rem !important;\n  padding-bottom: 3rem !important;\n}\n\n.m-auto {\n  margin: auto !important;\n}\n\n.mt-auto {\n  margin-top: auto !important;\n}\n\n.mr-auto {\n  margin-right: auto !important;\n}\n\n.mb-auto {\n  margin-bottom: auto !important;\n}\n\n.ml-auto {\n  margin-left: auto !important;\n}\n\n.mx-auto {\n  margin-right: auto !important;\n  margin-left: auto !important;\n}\n\n.my-auto {\n  margin-top: auto !important;\n  margin-bottom: auto !important;\n}\n\n@media (min-width: 576px) {\n  .m-sm-0 {\n    margin: 0 0 !important;\n  }\n  .mt-sm-0 {\n    margin-top: 0 !important;\n  }\n  .mr-sm-0 {\n    margin-right: 0 !important;\n  }\n  .mb-sm-0 {\n    margin-bottom: 0 !important;\n  }\n  .ml-sm-0 {\n    margin-left: 0 !important;\n  }\n  .mx-sm-0 {\n    margin-right: 0 !important;\n    margin-left: 0 !important;\n  }\n  .my-sm-0 {\n    margin-top: 0 !important;\n    margin-bottom: 0 !important;\n  }\n  .m-sm-1 {\n    margin: 0.25rem 0.25rem !important;\n  }\n  .mt-sm-1 {\n    margin-top: 0.25rem !important;\n  }\n  .mr-sm-1 {\n    margin-right: 0.25rem !important;\n  }\n  .mb-sm-1 {\n    margin-bottom: 0.25rem !important;\n  }\n  .ml-sm-1 {\n    margin-left: 0.25rem !important;\n  }\n  .mx-sm-1 {\n    margin-right: 0.25rem !important;\n    margin-left: 0.25rem !important;\n  }\n  .my-sm-1 {\n    margin-top: 0.25rem !important;\n    margin-bottom: 0.25rem !important;\n  }\n  .m-sm-2 {\n    margin: 0.5rem 0.5rem !important;\n  }\n  .mt-sm-2 {\n    margin-top: 0.5rem !important;\n  }\n  .mr-sm-2 {\n    margin-right: 0.5rem !important;\n  }\n  .mb-sm-2 {\n    margin-bottom: 0.5rem !important;\n  }\n  .ml-sm-2 {\n    margin-left: 0.5rem !important;\n  }\n  .mx-sm-2 {\n    margin-right: 0.5rem !important;\n    margin-left: 0.5rem !important;\n  }\n  .my-sm-2 {\n    margin-top: 0.5rem !important;\n    margin-bottom: 0.5rem !important;\n  }\n  .m-sm-3 {\n    margin: 1rem 1rem !important;\n  }\n  .mt-sm-3 {\n    margin-top: 1rem !important;\n  }\n  .mr-sm-3 {\n    margin-right: 1rem !important;\n  }\n  .mb-sm-3 {\n    margin-bottom: 1rem !important;\n  }\n  .ml-sm-3 {\n    margin-left: 1rem !important;\n  }\n  .mx-sm-3 {\n    margin-right: 1rem !important;\n    margin-left: 1rem !important;\n  }\n  .my-sm-3 {\n    margin-top: 1rem !important;\n    margin-bottom: 1rem !important;\n  }\n  .m-sm-4 {\n    margin: 1.5rem 1.5rem !important;\n  }\n  .mt-sm-4 {\n    margin-top: 1.5rem !important;\n  }\n  .mr-sm-4 {\n    margin-right: 1.5rem !important;\n  }\n  .mb-sm-4 {\n    margin-bottom: 1.5rem !important;\n  }\n  .ml-sm-4 {\n    margin-left: 1.5rem !important;\n  }\n  .mx-sm-4 {\n    margin-right: 1.5rem !important;\n    margin-left: 1.5rem !important;\n  }\n  .my-sm-4 {\n    margin-top: 1.5rem !important;\n    margin-bottom: 1.5rem !important;\n  }\n  .m-sm-5 {\n    margin: 3rem 3rem !important;\n  }\n  .mt-sm-5 {\n    margin-top: 3rem !important;\n  }\n  .mr-sm-5 {\n    margin-right: 3rem !important;\n  }\n  .mb-sm-5 {\n    margin-bottom: 3rem !important;\n  }\n  .ml-sm-5 {\n    margin-left: 3rem !important;\n  }\n  .mx-sm-5 {\n    margin-right: 3rem !important;\n    margin-left: 3rem !important;\n  }\n  .my-sm-5 {\n    margin-top: 3rem !important;\n    margin-bottom: 3rem !important;\n  }\n  .p-sm-0 {\n    padding: 0 0 !important;\n  }\n  .pt-sm-0 {\n    padding-top: 0 !important;\n  }\n  .pr-sm-0 {\n    padding-right: 0 !important;\n  }\n  .pb-sm-0 {\n    padding-bottom: 0 !important;\n  }\n  .pl-sm-0 {\n    padding-left: 0 !important;\n  }\n  .px-sm-0 {\n    padding-right: 0 !important;\n    padding-left: 0 !important;\n  }\n  .py-sm-0 {\n    padding-top: 0 !important;\n    padding-bottom: 0 !important;\n  }\n  .p-sm-1 {\n    padding: 0.25rem 0.25rem !important;\n  }\n  .pt-sm-1 {\n    padding-top: 0.25rem !important;\n  }\n  .pr-sm-1 {\n    padding-right: 0.25rem !important;\n  }\n  .pb-sm-1 {\n    padding-bottom: 0.25rem !important;\n  }\n  .pl-sm-1 {\n    padding-left: 0.25rem !important;\n  }\n  .px-sm-1 {\n    padding-right: 0.25rem !important;\n    padding-left: 0.25rem !important;\n  }\n  .py-sm-1 {\n    padding-top: 0.25rem !important;\n    padding-bottom: 0.25rem !important;\n  }\n  .p-sm-2 {\n    padding: 0.5rem 0.5rem !important;\n  }\n  .pt-sm-2 {\n    padding-top: 0.5rem !important;\n  }\n  .pr-sm-2 {\n    padding-right: 0.5rem !important;\n  }\n  .pb-sm-2 {\n    padding-bottom: 0.5rem !important;\n  }\n  .pl-sm-2 {\n    padding-left: 0.5rem !important;\n  }\n  .px-sm-2 {\n    padding-right: 0.5rem !important;\n    padding-left: 0.5rem !important;\n  }\n  .py-sm-2 {\n    padding-top: 0.5rem !important;\n    padding-bottom: 0.5rem !important;\n  }\n  .p-sm-3 {\n    padding: 1rem 1rem !important;\n  }\n  .pt-sm-3 {\n    padding-top: 1rem !important;\n  }\n  .pr-sm-3 {\n    padding-right: 1rem !important;\n  }\n  .pb-sm-3 {\n    padding-bottom: 1rem !important;\n  }\n  .pl-sm-3 {\n    padding-left: 1rem !important;\n  }\n  .px-sm-3 {\n    padding-right: 1rem !important;\n    padding-left: 1rem !important;\n  }\n  .py-sm-3 {\n    padding-top: 1rem !important;\n    padding-bottom: 1rem !important;\n  }\n  .p-sm-4 {\n    padding: 1.5rem 1.5rem !important;\n  }\n  .pt-sm-4 {\n    padding-top: 1.5rem !important;\n  }\n  .pr-sm-4 {\n    padding-right: 1.5rem !important;\n  }\n  .pb-sm-4 {\n    padding-bottom: 1.5rem !important;\n  }\n  .pl-sm-4 {\n    padding-left: 1.5rem !important;\n  }\n  .px-sm-4 {\n    padding-right: 1.5rem !important;\n    padding-left: 1.5rem !important;\n  }\n  .py-sm-4 {\n    padding-top: 1.5rem !important;\n    padding-bottom: 1.5rem !important;\n  }\n  .p-sm-5 {\n    padding: 3rem 3rem !important;\n  }\n  .pt-sm-5 {\n    padding-top: 3rem !important;\n  }\n  .pr-sm-5 {\n    padding-right: 3rem !important;\n  }\n  .pb-sm-5 {\n    padding-bottom: 3rem !important;\n  }\n  .pl-sm-5 {\n    padding-left: 3rem !important;\n  }\n  .px-sm-5 {\n    padding-right: 3rem !important;\n    padding-left: 3rem !important;\n  }\n  .py-sm-5 {\n    padding-top: 3rem !important;\n    padding-bottom: 3rem !important;\n  }\n  .m-sm-auto {\n    margin: auto !important;\n  }\n  .mt-sm-auto {\n    margin-top: auto !important;\n  }\n  .mr-sm-auto {\n    margin-right: auto !important;\n  }\n  .mb-sm-auto {\n    margin-bottom: auto !important;\n  }\n  .ml-sm-auto {\n    margin-left: auto !important;\n  }\n  .mx-sm-auto {\n    margin-right: auto !important;\n    margin-left: auto !important;\n  }\n  .my-sm-auto {\n    margin-top: auto !important;\n    margin-bottom: auto !important;\n  }\n}\n\n@media (min-width: 768px) {\n  .m-md-0 {\n    margin: 0 0 !important;\n  }\n  .mt-md-0 {\n    margin-top: 0 !important;\n  }\n  .mr-md-0 {\n    margin-right: 0 !important;\n  }\n  .mb-md-0 {\n    margin-bottom: 0 !important;\n  }\n  .ml-md-0 {\n    margin-left: 0 !important;\n  }\n  .mx-md-0 {\n    margin-right: 0 !important;\n    margin-left: 0 !important;\n  }\n  .my-md-0 {\n    margin-top: 0 !important;\n    margin-bottom: 0 !important;\n  }\n  .m-md-1 {\n    margin: 0.25rem 0.25rem !important;\n  }\n  .mt-md-1 {\n    margin-top: 0.25rem !important;\n  }\n  .mr-md-1 {\n    margin-right: 0.25rem !important;\n  }\n  .mb-md-1 {\n    margin-bottom: 0.25rem !important;\n  }\n  .ml-md-1 {\n    margin-left: 0.25rem !important;\n  }\n  .mx-md-1 {\n    margin-right: 0.25rem !important;\n    margin-left: 0.25rem !important;\n  }\n  .my-md-1 {\n    margin-top: 0.25rem !important;\n    margin-bottom: 0.25rem !important;\n  }\n  .m-md-2 {\n    margin: 0.5rem 0.5rem !important;\n  }\n  .mt-md-2 {\n    margin-top: 0.5rem !important;\n  }\n  .mr-md-2 {\n    margin-right: 0.5rem !important;\n  }\n  .mb-md-2 {\n    margin-bottom: 0.5rem !important;\n  }\n  .ml-md-2 {\n    margin-left: 0.5rem !important;\n  }\n  .mx-md-2 {\n    margin-right: 0.5rem !important;\n    margin-left: 0.5rem !important;\n  }\n  .my-md-2 {\n    margin-top: 0.5rem !important;\n    margin-bottom: 0.5rem !important;\n  }\n  .m-md-3 {\n    margin: 1rem 1rem !important;\n  }\n  .mt-md-3 {\n    margin-top: 1rem !important;\n  }\n  .mr-md-3 {\n    margin-right: 1rem !important;\n  }\n  .mb-md-3 {\n    margin-bottom: 1rem !important;\n  }\n  .ml-md-3 {\n    margin-left: 1rem !important;\n  }\n  .mx-md-3 {\n    margin-right: 1rem !important;\n    margin-left: 1rem !important;\n  }\n  .my-md-3 {\n    margin-top: 1rem !important;\n    margin-bottom: 1rem !important;\n  }\n  .m-md-4 {\n    margin: 1.5rem 1.5rem !important;\n  }\n  .mt-md-4 {\n    margin-top: 1.5rem !important;\n  }\n  .mr-md-4 {\n    margin-right: 1.5rem !important;\n  }\n  .mb-md-4 {\n    margin-bottom: 1.5rem !important;\n  }\n  .ml-md-4 {\n    margin-left: 1.5rem !important;\n  }\n  .mx-md-4 {\n    margin-right: 1.5rem !important;\n    margin-left: 1.5rem !important;\n  }\n  .my-md-4 {\n    margin-top: 1.5rem !important;\n    margin-bottom: 1.5rem !important;\n  }\n  .m-md-5 {\n    margin: 3rem 3rem !important;\n  }\n  .mt-md-5 {\n    margin-top: 3rem !important;\n  }\n  .mr-md-5 {\n    margin-right: 3rem !important;\n  }\n  .mb-md-5 {\n    margin-bottom: 3rem !important;\n  }\n  .ml-md-5 {\n    margin-left: 3rem !important;\n  }\n  .mx-md-5 {\n    margin-right: 3rem !important;\n    margin-left: 3rem !important;\n  }\n  .my-md-5 {\n    margin-top: 3rem !important;\n    margin-bottom: 3rem !important;\n  }\n  .p-md-0 {\n    padding: 0 0 !important;\n  }\n  .pt-md-0 {\n    padding-top: 0 !important;\n  }\n  .pr-md-0 {\n    padding-right: 0 !important;\n  }\n  .pb-md-0 {\n    padding-bottom: 0 !important;\n  }\n  .pl-md-0 {\n    padding-left: 0 !important;\n  }\n  .px-md-0 {\n    padding-right: 0 !important;\n    padding-left: 0 !important;\n  }\n  .py-md-0 {\n    padding-top: 0 !important;\n    padding-bottom: 0 !important;\n  }\n  .p-md-1 {\n    padding: 0.25rem 0.25rem !important;\n  }\n  .pt-md-1 {\n    padding-top: 0.25rem !important;\n  }\n  .pr-md-1 {\n    padding-right: 0.25rem !important;\n  }\n  .pb-md-1 {\n    padding-bottom: 0.25rem !important;\n  }\n  .pl-md-1 {\n    padding-left: 0.25rem !important;\n  }\n  .px-md-1 {\n    padding-right: 0.25rem !important;\n    padding-left: 0.25rem !important;\n  }\n  .py-md-1 {\n    padding-top: 0.25rem !important;\n    padding-bottom: 0.25rem !important;\n  }\n  .p-md-2 {\n    padding: 0.5rem 0.5rem !important;\n  }\n  .pt-md-2 {\n    padding-top: 0.5rem !important;\n  }\n  .pr-md-2 {\n    padding-right: 0.5rem !important;\n  }\n  .pb-md-2 {\n    padding-bottom: 0.5rem !important;\n  }\n  .pl-md-2 {\n    padding-left: 0.5rem !important;\n  }\n  .px-md-2 {\n    padding-right: 0.5rem !important;\n    padding-left: 0.5rem !important;\n  }\n  .py-md-2 {\n    padding-top: 0.5rem !important;\n    padding-bottom: 0.5rem !important;\n  }\n  .p-md-3 {\n    padding: 1rem 1rem !important;\n  }\n  .pt-md-3 {\n    padding-top: 1rem !important;\n  }\n  .pr-md-3 {\n    padding-right: 1rem !important;\n  }\n  .pb-md-3 {\n    padding-bottom: 1rem !important;\n  }\n  .pl-md-3 {\n    padding-left: 1rem !important;\n  }\n  .px-md-3 {\n    padding-right: 1rem !important;\n    padding-left: 1rem !important;\n  }\n  .py-md-3 {\n    padding-top: 1rem !important;\n    padding-bottom: 1rem !important;\n  }\n  .p-md-4 {\n    padding: 1.5rem 1.5rem !important;\n  }\n  .pt-md-4 {\n    padding-top: 1.5rem !important;\n  }\n  .pr-md-4 {\n    padding-right: 1.5rem !important;\n  }\n  .pb-md-4 {\n    padding-bottom: 1.5rem !important;\n  }\n  .pl-md-4 {\n    padding-left: 1.5rem !important;\n  }\n  .px-md-4 {\n    padding-right: 1.5rem !important;\n    padding-left: 1.5rem !important;\n  }\n  .py-md-4 {\n    padding-top: 1.5rem !important;\n    padding-bottom: 1.5rem !important;\n  }\n  .p-md-5 {\n    padding: 3rem 3rem !important;\n  }\n  .pt-md-5 {\n    padding-top: 3rem !important;\n  }\n  .pr-md-5 {\n    padding-right: 3rem !important;\n  }\n  .pb-md-5 {\n    padding-bottom: 3rem !important;\n  }\n  .pl-md-5 {\n    padding-left: 3rem !important;\n  }\n  .px-md-5 {\n    padding-right: 3rem !important;\n    padding-left: 3rem !important;\n  }\n  .py-md-5 {\n    padding-top: 3rem !important;\n    padding-bottom: 3rem !important;\n  }\n  .m-md-auto {\n    margin: auto !important;\n  }\n  .mt-md-auto {\n    margin-top: auto !important;\n  }\n  .mr-md-auto {\n    margin-right: auto !important;\n  }\n  .mb-md-auto {\n    margin-bottom: auto !important;\n  }\n  .ml-md-auto {\n    margin-left: auto !important;\n  }\n  .mx-md-auto {\n    margin-right: auto !important;\n    margin-left: auto !important;\n  }\n  .my-md-auto {\n    margin-top: auto !important;\n    margin-bottom: auto !important;\n  }\n}\n\n@media (min-width: 992px) {\n  .m-lg-0 {\n    margin: 0 0 !important;\n  }\n  .mt-lg-0 {\n    margin-top: 0 !important;\n  }\n  .mr-lg-0 {\n    margin-right: 0 !important;\n  }\n  .mb-lg-0 {\n    margin-bottom: 0 !important;\n  }\n  .ml-lg-0 {\n    margin-left: 0 !important;\n  }\n  .mx-lg-0 {\n    margin-right: 0 !important;\n    margin-left: 0 !important;\n  }\n  .my-lg-0 {\n    margin-top: 0 !important;\n    margin-bottom: 0 !important;\n  }\n  .m-lg-1 {\n    margin: 0.25rem 0.25rem !important;\n  }\n  .mt-lg-1 {\n    margin-top: 0.25rem !important;\n  }\n  .mr-lg-1 {\n    margin-right: 0.25rem !important;\n  }\n  .mb-lg-1 {\n    margin-bottom: 0.25rem !important;\n  }\n  .ml-lg-1 {\n    margin-left: 0.25rem !important;\n  }\n  .mx-lg-1 {\n    margin-right: 0.25rem !important;\n    margin-left: 0.25rem !important;\n  }\n  .my-lg-1 {\n    margin-top: 0.25rem !important;\n    margin-bottom: 0.25rem !important;\n  }\n  .m-lg-2 {\n    margin: 0.5rem 0.5rem !important;\n  }\n  .mt-lg-2 {\n    margin-top: 0.5rem !important;\n  }\n  .mr-lg-2 {\n    margin-right: 0.5rem !important;\n  }\n  .mb-lg-2 {\n    margin-bottom: 0.5rem !important;\n  }\n  .ml-lg-2 {\n    margin-left: 0.5rem !important;\n  }\n  .mx-lg-2 {\n    margin-right: 0.5rem !important;\n    margin-left: 0.5rem !important;\n  }\n  .my-lg-2 {\n    margin-top: 0.5rem !important;\n    margin-bottom: 0.5rem !important;\n  }\n  .m-lg-3 {\n    margin: 1rem 1rem !important;\n  }\n  .mt-lg-3 {\n    margin-top: 1rem !important;\n  }\n  .mr-lg-3 {\n    margin-right: 1rem !important;\n  }\n  .mb-lg-3 {\n    margin-bottom: 1rem !important;\n  }\n  .ml-lg-3 {\n    margin-left: 1rem !important;\n  }\n  .mx-lg-3 {\n    margin-right: 1rem !important;\n    margin-left: 1rem !important;\n  }\n  .my-lg-3 {\n    margin-top: 1rem !important;\n    margin-bottom: 1rem !important;\n  }\n  .m-lg-4 {\n    margin: 1.5rem 1.5rem !important;\n  }\n  .mt-lg-4 {\n    margin-top: 1.5rem !important;\n  }\n  .mr-lg-4 {\n    margin-right: 1.5rem !important;\n  }\n  .mb-lg-4 {\n    margin-bottom: 1.5rem !important;\n  }\n  .ml-lg-4 {\n    margin-left: 1.5rem !important;\n  }\n  .mx-lg-4 {\n    margin-right: 1.5rem !important;\n    margin-left: 1.5rem !important;\n  }\n  .my-lg-4 {\n    margin-top: 1.5rem !important;\n    margin-bottom: 1.5rem !important;\n  }\n  .m-lg-5 {\n    margin: 3rem 3rem !important;\n  }\n  .mt-lg-5 {\n    margin-top: 3rem !important;\n  }\n  .mr-lg-5 {\n    margin-right: 3rem !important;\n  }\n  .mb-lg-5 {\n    margin-bottom: 3rem !important;\n  }\n  .ml-lg-5 {\n    margin-left: 3rem !important;\n  }\n  .mx-lg-5 {\n    margin-right: 3rem !important;\n    margin-left: 3rem !important;\n  }\n  .my-lg-5 {\n    margin-top: 3rem !important;\n    margin-bottom: 3rem !important;\n  }\n  .p-lg-0 {\n    padding: 0 0 !important;\n  }\n  .pt-lg-0 {\n    padding-top: 0 !important;\n  }\n  .pr-lg-0 {\n    padding-right: 0 !important;\n  }\n  .pb-lg-0 {\n    padding-bottom: 0 !important;\n  }\n  .pl-lg-0 {\n    padding-left: 0 !important;\n  }\n  .px-lg-0 {\n    padding-right: 0 !important;\n    padding-left: 0 !important;\n  }\n  .py-lg-0 {\n    padding-top: 0 !important;\n    padding-bottom: 0 !important;\n  }\n  .p-lg-1 {\n    padding: 0.25rem 0.25rem !important;\n  }\n  .pt-lg-1 {\n    padding-top: 0.25rem !important;\n  }\n  .pr-lg-1 {\n    padding-right: 0.25rem !important;\n  }\n  .pb-lg-1 {\n    padding-bottom: 0.25rem !important;\n  }\n  .pl-lg-1 {\n    padding-left: 0.25rem !important;\n  }\n  .px-lg-1 {\n    padding-right: 0.25rem !important;\n    padding-left: 0.25rem !important;\n  }\n  .py-lg-1 {\n    padding-top: 0.25rem !important;\n    padding-bottom: 0.25rem !important;\n  }\n  .p-lg-2 {\n    padding: 0.5rem 0.5rem !important;\n  }\n  .pt-lg-2 {\n    padding-top: 0.5rem !important;\n  }\n  .pr-lg-2 {\n    padding-right: 0.5rem !important;\n  }\n  .pb-lg-2 {\n    padding-bottom: 0.5rem !important;\n  }\n  .pl-lg-2 {\n    padding-left: 0.5rem !important;\n  }\n  .px-lg-2 {\n    padding-right: 0.5rem !important;\n    padding-left: 0.5rem !important;\n  }\n  .py-lg-2 {\n    padding-top: 0.5rem !important;\n    padding-bottom: 0.5rem !important;\n  }\n  .p-lg-3 {\n    padding: 1rem 1rem !important;\n  }\n  .pt-lg-3 {\n    padding-top: 1rem !important;\n  }\n  .pr-lg-3 {\n    padding-right: 1rem !important;\n  }\n  .pb-lg-3 {\n    padding-bottom: 1rem !important;\n  }\n  .pl-lg-3 {\n    padding-left: 1rem !important;\n  }\n  .px-lg-3 {\n    padding-right: 1rem !important;\n    padding-left: 1rem !important;\n  }\n  .py-lg-3 {\n    padding-top: 1rem !important;\n    padding-bottom: 1rem !important;\n  }\n  .p-lg-4 {\n    padding: 1.5rem 1.5rem !important;\n  }\n  .pt-lg-4 {\n    padding-top: 1.5rem !important;\n  }\n  .pr-lg-4 {\n    padding-right: 1.5rem !important;\n  }\n  .pb-lg-4 {\n    padding-bottom: 1.5rem !important;\n  }\n  .pl-lg-4 {\n    padding-left: 1.5rem !important;\n  }\n  .px-lg-4 {\n    padding-right: 1.5rem !important;\n    padding-left: 1.5rem !important;\n  }\n  .py-lg-4 {\n    padding-top: 1.5rem !important;\n    padding-bottom: 1.5rem !important;\n  }\n  .p-lg-5 {\n    padding: 3rem 3rem !important;\n  }\n  .pt-lg-5 {\n    padding-top: 3rem !important;\n  }\n  .pr-lg-5 {\n    padding-right: 3rem !important;\n  }\n  .pb-lg-5 {\n    padding-bottom: 3rem !important;\n  }\n  .pl-lg-5 {\n    padding-left: 3rem !important;\n  }\n  .px-lg-5 {\n    padding-right: 3rem !important;\n    padding-left: 3rem !important;\n  }\n  .py-lg-5 {\n    padding-top: 3rem !important;\n    padding-bottom: 3rem !important;\n  }\n  .m-lg-auto {\n    margin: auto !important;\n  }\n  .mt-lg-auto {\n    margin-top: auto !important;\n  }\n  .mr-lg-auto {\n    margin-right: auto !important;\n  }\n  .mb-lg-auto {\n    margin-bottom: auto !important;\n  }\n  .ml-lg-auto {\n    margin-left: auto !important;\n  }\n  .mx-lg-auto {\n    margin-right: auto !important;\n    margin-left: auto !important;\n  }\n  .my-lg-auto {\n    margin-top: auto !important;\n    margin-bottom: auto !important;\n  }\n}\n\n@media (min-width: 1200px) {\n  .m-xl-0 {\n    margin: 0 0 !important;\n  }\n  .mt-xl-0 {\n    margin-top: 0 !important;\n  }\n  .mr-xl-0 {\n    margin-right: 0 !important;\n  }\n  .mb-xl-0 {\n    margin-bottom: 0 !important;\n  }\n  .ml-xl-0 {\n    margin-left: 0 !important;\n  }\n  .mx-xl-0 {\n    margin-right: 0 !important;\n    margin-left: 0 !important;\n  }\n  .my-xl-0 {\n    margin-top: 0 !important;\n    margin-bottom: 0 !important;\n  }\n  .m-xl-1 {\n    margin: 0.25rem 0.25rem !important;\n  }\n  .mt-xl-1 {\n    margin-top: 0.25rem !important;\n  }\n  .mr-xl-1 {\n    margin-right: 0.25rem !important;\n  }\n  .mb-xl-1 {\n    margin-bottom: 0.25rem !important;\n  }\n  .ml-xl-1 {\n    margin-left: 0.25rem !important;\n  }\n  .mx-xl-1 {\n    margin-right: 0.25rem !important;\n    margin-left: 0.25rem !important;\n  }\n  .my-xl-1 {\n    margin-top: 0.25rem !important;\n    margin-bottom: 0.25rem !important;\n  }\n  .m-xl-2 {\n    margin: 0.5rem 0.5rem !important;\n  }\n  .mt-xl-2 {\n    margin-top: 0.5rem !important;\n  }\n  .mr-xl-2 {\n    margin-right: 0.5rem !important;\n  }\n  .mb-xl-2 {\n    margin-bottom: 0.5rem !important;\n  }\n  .ml-xl-2 {\n    margin-left: 0.5rem !important;\n  }\n  .mx-xl-2 {\n    margin-right: 0.5rem !important;\n    margin-left: 0.5rem !important;\n  }\n  .my-xl-2 {\n    margin-top: 0.5rem !important;\n    margin-bottom: 0.5rem !important;\n  }\n  .m-xl-3 {\n    margin: 1rem 1rem !important;\n  }\n  .mt-xl-3 {\n    margin-top: 1rem !important;\n  }\n  .mr-xl-3 {\n    margin-right: 1rem !important;\n  }\n  .mb-xl-3 {\n    margin-bottom: 1rem !important;\n  }\n  .ml-xl-3 {\n    margin-left: 1rem !important;\n  }\n  .mx-xl-3 {\n    margin-right: 1rem !important;\n    margin-left: 1rem !important;\n  }\n  .my-xl-3 {\n    margin-top: 1rem !important;\n    margin-bottom: 1rem !important;\n  }\n  .m-xl-4 {\n    margin: 1.5rem 1.5rem !important;\n  }\n  .mt-xl-4 {\n    margin-top: 1.5rem !important;\n  }\n  .mr-xl-4 {\n    margin-right: 1.5rem !important;\n  }\n  .mb-xl-4 {\n    margin-bottom: 1.5rem !important;\n  }\n  .ml-xl-4 {\n    margin-left: 1.5rem !important;\n  }\n  .mx-xl-4 {\n    margin-right: 1.5rem !important;\n    margin-left: 1.5rem !important;\n  }\n  .my-xl-4 {\n    margin-top: 1.5rem !important;\n    margin-bottom: 1.5rem !important;\n  }\n  .m-xl-5 {\n    margin: 3rem 3rem !important;\n  }\n  .mt-xl-5 {\n    margin-top: 3rem !important;\n  }\n  .mr-xl-5 {\n    margin-right: 3rem !important;\n  }\n  .mb-xl-5 {\n    margin-bottom: 3rem !important;\n  }\n  .ml-xl-5 {\n    margin-left: 3rem !important;\n  }\n  .mx-xl-5 {\n    margin-right: 3rem !important;\n    margin-left: 3rem !important;\n  }\n  .my-xl-5 {\n    margin-top: 3rem !important;\n    margin-bottom: 3rem !important;\n  }\n  .p-xl-0 {\n    padding: 0 0 !important;\n  }\n  .pt-xl-0 {\n    padding-top: 0 !important;\n  }\n  .pr-xl-0 {\n    padding-right: 0 !important;\n  }\n  .pb-xl-0 {\n    padding-bottom: 0 !important;\n  }\n  .pl-xl-0 {\n    padding-left: 0 !important;\n  }\n  .px-xl-0 {\n    padding-right: 0 !important;\n    padding-left: 0 !important;\n  }\n  .py-xl-0 {\n    padding-top: 0 !important;\n    padding-bottom: 0 !important;\n  }\n  .p-xl-1 {\n    padding: 0.25rem 0.25rem !important;\n  }\n  .pt-xl-1 {\n    padding-top: 0.25rem !important;\n  }\n  .pr-xl-1 {\n    padding-right: 0.25rem !important;\n  }\n  .pb-xl-1 {\n    padding-bottom: 0.25rem !important;\n  }\n  .pl-xl-1 {\n    padding-left: 0.25rem !important;\n  }\n  .px-xl-1 {\n    padding-right: 0.25rem !important;\n    padding-left: 0.25rem !important;\n  }\n  .py-xl-1 {\n    padding-top: 0.25rem !important;\n    padding-bottom: 0.25rem !important;\n  }\n  .p-xl-2 {\n    padding: 0.5rem 0.5rem !important;\n  }\n  .pt-xl-2 {\n    padding-top: 0.5rem !important;\n  }\n  .pr-xl-2 {\n    padding-right: 0.5rem !important;\n  }\n  .pb-xl-2 {\n    padding-bottom: 0.5rem !important;\n  }\n  .pl-xl-2 {\n    padding-left: 0.5rem !important;\n  }\n  .px-xl-2 {\n    padding-right: 0.5rem !important;\n    padding-left: 0.5rem !important;\n  }\n  .py-xl-2 {\n    padding-top: 0.5rem !important;\n    padding-bottom: 0.5rem !important;\n  }\n  .p-xl-3 {\n    padding: 1rem 1rem !important;\n  }\n  .pt-xl-3 {\n    padding-top: 1rem !important;\n  }\n  .pr-xl-3 {\n    padding-right: 1rem !important;\n  }\n  .pb-xl-3 {\n    padding-bottom: 1rem !important;\n  }\n  .pl-xl-3 {\n    padding-left: 1rem !important;\n  }\n  .px-xl-3 {\n    padding-right: 1rem !important;\n    padding-left: 1rem !important;\n  }\n  .py-xl-3 {\n    padding-top: 1rem !important;\n    padding-bottom: 1rem !important;\n  }\n  .p-xl-4 {\n    padding: 1.5rem 1.5rem !important;\n  }\n  .pt-xl-4 {\n    padding-top: 1.5rem !important;\n  }\n  .pr-xl-4 {\n    padding-right: 1.5rem !important;\n  }\n  .pb-xl-4 {\n    padding-bottom: 1.5rem !important;\n  }\n  .pl-xl-4 {\n    padding-left: 1.5rem !important;\n  }\n  .px-xl-4 {\n    padding-right: 1.5rem !important;\n    padding-left: 1.5rem !important;\n  }\n  .py-xl-4 {\n    padding-top: 1.5rem !important;\n    padding-bottom: 1.5rem !important;\n  }\n  .p-xl-5 {\n    padding: 3rem 3rem !important;\n  }\n  .pt-xl-5 {\n    padding-top: 3rem !important;\n  }\n  .pr-xl-5 {\n    padding-right: 3rem !important;\n  }\n  .pb-xl-5 {\n    padding-bottom: 3rem !important;\n  }\n  .pl-xl-5 {\n    padding-left: 3rem !important;\n  }\n  .px-xl-5 {\n    padding-right: 3rem !important;\n    padding-left: 3rem !important;\n  }\n  .py-xl-5 {\n    padding-top: 3rem !important;\n    padding-bottom: 3rem !important;\n  }\n  .m-xl-auto {\n    margin: auto !important;\n  }\n  .mt-xl-auto {\n    margin-top: auto !important;\n  }\n  .mr-xl-auto {\n    margin-right: auto !important;\n  }\n  .mb-xl-auto {\n    margin-bottom: auto !important;\n  }\n  .ml-xl-auto {\n    margin-left: auto !important;\n  }\n  .mx-xl-auto {\n    margin-right: auto !important;\n    margin-left: auto !important;\n  }\n  .my-xl-auto {\n    margin-top: auto !important;\n    margin-bottom: auto !important;\n  }\n}\n\n.text-justify {\n  text-align: justify !important;\n}\n\n.text-nowrap {\n  white-space: nowrap !important;\n}\n\n.text-truncate {\n  overflow: hidden;\n  text-overflow: ellipsis;\n  white-space: nowrap;\n}\n\n.text-left {\n  text-align: left !important;\n}\n\n.text-right {\n  text-align: right !important;\n}\n\n.text-center {\n  text-align: center !important;\n}\n\n@media (min-width: 576px) {\n  .text-sm-left {\n    text-align: left !important;\n  }\n  .text-sm-right {\n    text-align: right !important;\n  }\n  .text-sm-center {\n    text-align: center !important;\n  }\n}\n\n@media (min-width: 768px) {\n  .text-md-left {\n    text-align: left !important;\n  }\n  .text-md-right {\n    text-align: right !important;\n  }\n  .text-md-center {\n    text-align: center !important;\n  }\n}\n\n@media (min-width: 992px) {\n  .text-lg-left {\n    text-align: left !important;\n  }\n  .text-lg-right {\n    text-align: right !important;\n  }\n  .text-lg-center {\n    text-align: center !important;\n  }\n}\n\n@media (min-width: 1200px) {\n  .text-xl-left {\n    text-align: left !important;\n  }\n  .text-xl-right {\n    text-align: right !important;\n  }\n  .text-xl-center {\n    text-align: center !important;\n  }\n}\n\n.text-lowercase {\n  text-transform: lowercase !important;\n}\n\n.text-uppercase {\n  text-transform: uppercase !important;\n}\n\n.text-capitalize {\n  text-transform: capitalize !important;\n}\n\n.font-weight-normal {\n  font-weight: normal;\n}\n\n.font-weight-bold {\n  font-weight: bold;\n}\n\n.font-italic {\n  font-style: italic;\n}\n\n.text-white {\n  color: #fff !important;\n}\n\n.text-muted {\n  color: #636c72 !important;\n}\n\na.text-muted:focus, a.text-muted:hover {\n  color: #4b5257 !important;\n}\n\n.text-primary {\n  color: #0275d8 !important;\n}\n\na.text-primary:focus, a.text-primary:hover {\n  color: #025aa5 !important;\n}\n\n.text-success {\n  color: #5cb85c !important;\n}\n\na.text-success:focus, a.text-success:hover {\n  color: #449d44 !important;\n}\n\n.text-info {\n  color: #5bc0de !important;\n}\n\na.text-info:focus, a.text-info:hover {\n  color: #31b0d5 !important;\n}\n\n.text-warning {\n  color: #f0ad4e !important;\n}\n\na.text-warning:focus, a.text-warning:hover {\n  color: #ec971f !important;\n}\n\n.text-danger {\n  color: #d9534f !important;\n}\n\na.text-danger:focus, a.text-danger:hover {\n  color: #c9302c !important;\n}\n\n.text-gray-dark {\n  color: #292b2c !important;\n}\n\na.text-gray-dark:focus, a.text-gray-dark:hover {\n  color: #101112 !important;\n}\n\n.text-hide {\n  font: 0/0 a;\n  color: transparent;\n  text-shadow: none;\n  background-color: transparent;\n  border: 0;\n}\n\n.invisible {\n  visibility: hidden !important;\n}\n\n.hidden-xs-up {\n  display: none !important;\n}\n\n@media (max-width: 575px) {\n  .hidden-xs-down {\n    display: none !important;\n  }\n}\n\n@media (min-width: 576px) {\n  .hidden-sm-up {\n    display: none !important;\n  }\n}\n\n@media (max-width: 767px) {\n  .hidden-sm-down {\n    display: none !important;\n  }\n}\n\n@media (min-width: 768px) {\n  .hidden-md-up {\n    display: none !important;\n  }\n}\n\n@media (max-width: 991px) {\n  .hidden-md-down {\n    display: none !important;\n  }\n}\n\n@media (min-width: 992px) {\n  .hidden-lg-up {\n    display: none !important;\n  }\n}\n\n@media (max-width: 1199px) {\n  .hidden-lg-down {\n    display: none !important;\n  }\n}\n\n@media (min-width: 1200px) {\n  .hidden-xl-up {\n    display: none !important;\n  }\n}\n\n.hidden-xl-down {\n  display: none !important;\n}\n\n.visible-print-block {\n  display: none !important;\n}\n\n@media print {\n  .visible-print-block {\n    display: block !important;\n  }\n}\n\n.visible-print-inline {\n  display: none !important;\n}\n\n@media print {\n  .visible-print-inline {\n    display: inline !important;\n  }\n}\n\n.visible-print-inline-block {\n  display: none !important;\n}\n\n@media print {\n  .visible-print-inline-block {\n    display: inline-block !important;\n  }\n}\n\n@media print {\n  .hidden-print {\n    display: none !important;\n  }\n}\n/*# sourceMappingURL=bootstrap.css.map */", ""]);

	// exports


/***/ }),
/* 4 */
/***/ (function(module, exports) {

	/*
		MIT License http://www.opensource.org/licenses/mit-license.php
		Author Tobias Koppers @sokra
	*/
	// css base code, injected by the css-loader
	module.exports = function() {
		var list = [];

		// return the list of modules as css string
		list.toString = function toString() {
			var result = [];
			for(var i = 0; i < this.length; i++) {
				var item = this[i];
				if(item[2]) {
					result.push("@media " + item[2] + "{" + item[1] + "}");
				} else {
					result.push(item[1]);
				}
			}
			return result.join("");
		};

		// import a list of modules into the list
		list.i = function(modules, mediaQuery) {
			if(typeof modules === "string")
				modules = [[null, modules, ""]];
			var alreadyImportedModules = {};
			for(var i = 0; i < this.length; i++) {
				var id = this[i][0];
				if(typeof id === "number")
					alreadyImportedModules[id] = true;
			}
			for(i = 0; i < modules.length; i++) {
				var item = modules[i];
				// skip already imported module
				// this implementation is not 100% perfect for weird media query combinations
				//  when a module is imported multiple times with different media queries.
				//  I hope this will never occur (Hey this way we have smaller bundles)
				if(typeof item[0] !== "number" || !alreadyImportedModules[item[0]]) {
					if(mediaQuery && !item[2]) {
						item[2] = mediaQuery;
					} else if(mediaQuery) {
						item[2] = "(" + item[2] + ") and (" + mediaQuery + ")";
					}
					list.push(item);
				}
			}
		};
		return list;
	};


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

	/*
		MIT License http://www.opensource.org/licenses/mit-license.php
		Author Tobias Koppers @sokra
	*/
	var stylesInDom = {},
		memoize = function(fn) {
			var memo;
			return function () {
				if (typeof memo === "undefined") memo = fn.apply(this, arguments);
				return memo;
			};
		},
		isOldIE = memoize(function() {
			return /msie [6-9]\b/.test(self.navigator.userAgent.toLowerCase());
		}),
		getHeadElement = memoize(function () {
			return document.head || document.getElementsByTagName("head")[0];
		}),
		singletonElement = null,
		singletonCounter = 0,
		styleElementsInsertedAtTop = [];

	module.exports = function(list, options) {
		if(false) {
			if(typeof document !== "object") throw new Error("The style-loader cannot be used in a non-browser environment");
		}

		options = options || {};
		// Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
		// tags it will allow on a page
		if (typeof options.singleton === "undefined") options.singleton = isOldIE();

		// By default, add <style> tags to the bottom of <head>.
		if (typeof options.insertAt === "undefined") options.insertAt = "bottom";

		var styles = listToStyles(list);
		addStylesToDom(styles, options);

		return function update(newList) {
			var mayRemove = [];
			for(var i = 0; i < styles.length; i++) {
				var item = styles[i];
				var domStyle = stylesInDom[item.id];
				domStyle.refs--;
				mayRemove.push(domStyle);
			}
			if(newList) {
				var newStyles = listToStyles(newList);
				addStylesToDom(newStyles, options);
			}
			for(var i = 0; i < mayRemove.length; i++) {
				var domStyle = mayRemove[i];
				if(domStyle.refs === 0) {
					for(var j = 0; j < domStyle.parts.length; j++)
						domStyle.parts[j]();
					delete stylesInDom[domStyle.id];
				}
			}
		};
	}

	function addStylesToDom(styles, options) {
		for(var i = 0; i < styles.length; i++) {
			var item = styles[i];
			var domStyle = stylesInDom[item.id];
			if(domStyle) {
				domStyle.refs++;
				for(var j = 0; j < domStyle.parts.length; j++) {
					domStyle.parts[j](item.parts[j]);
				}
				for(; j < item.parts.length; j++) {
					domStyle.parts.push(addStyle(item.parts[j], options));
				}
			} else {
				var parts = [];
				for(var j = 0; j < item.parts.length; j++) {
					parts.push(addStyle(item.parts[j], options));
				}
				stylesInDom[item.id] = {id: item.id, refs: 1, parts: parts};
			}
		}
	}

	function listToStyles(list) {
		var styles = [];
		var newStyles = {};
		for(var i = 0; i < list.length; i++) {
			var item = list[i];
			var id = item[0];
			var css = item[1];
			var media = item[2];
			var sourceMap = item[3];
			var part = {css: css, media: media, sourceMap: sourceMap};
			if(!newStyles[id])
				styles.push(newStyles[id] = {id: id, parts: [part]});
			else
				newStyles[id].parts.push(part);
		}
		return styles;
	}

	function insertStyleElement(options, styleElement) {
		var head = getHeadElement();
		var lastStyleElementInsertedAtTop = styleElementsInsertedAtTop[styleElementsInsertedAtTop.length - 1];
		if (options.insertAt === "top") {
			if(!lastStyleElementInsertedAtTop) {
				head.insertBefore(styleElement, head.firstChild);
			} else if(lastStyleElementInsertedAtTop.nextSibling) {
				head.insertBefore(styleElement, lastStyleElementInsertedAtTop.nextSibling);
			} else {
				head.appendChild(styleElement);
			}
			styleElementsInsertedAtTop.push(styleElement);
		} else if (options.insertAt === "bottom") {
			head.appendChild(styleElement);
		} else {
			throw new Error("Invalid value for parameter 'insertAt'. Must be 'top' or 'bottom'.");
		}
	}

	function removeStyleElement(styleElement) {
		styleElement.parentNode.removeChild(styleElement);
		var idx = styleElementsInsertedAtTop.indexOf(styleElement);
		if(idx >= 0) {
			styleElementsInsertedAtTop.splice(idx, 1);
		}
	}

	function createStyleElement(options) {
		var styleElement = document.createElement("style");
		styleElement.type = "text/css";
		insertStyleElement(options, styleElement);
		return styleElement;
	}

	function createLinkElement(options) {
		var linkElement = document.createElement("link");
		linkElement.rel = "stylesheet";
		insertStyleElement(options, linkElement);
		return linkElement;
	}

	function addStyle(obj, options) {
		var styleElement, update, remove;

		if (options.singleton) {
			var styleIndex = singletonCounter++;
			styleElement = singletonElement || (singletonElement = createStyleElement(options));
			update = applyToSingletonTag.bind(null, styleElement, styleIndex, false);
			remove = applyToSingletonTag.bind(null, styleElement, styleIndex, true);
		} else if(obj.sourceMap &&
			typeof URL === "function" &&
			typeof URL.createObjectURL === "function" &&
			typeof URL.revokeObjectURL === "function" &&
			typeof Blob === "function" &&
			typeof btoa === "function") {
			styleElement = createLinkElement(options);
			update = updateLink.bind(null, styleElement);
			remove = function() {
				removeStyleElement(styleElement);
				if(styleElement.href)
					URL.revokeObjectURL(styleElement.href);
			};
		} else {
			styleElement = createStyleElement(options);
			update = applyToTag.bind(null, styleElement);
			remove = function() {
				removeStyleElement(styleElement);
			};
		}

		update(obj);

		return function updateStyle(newObj) {
			if(newObj) {
				if(newObj.css === obj.css && newObj.media === obj.media && newObj.sourceMap === obj.sourceMap)
					return;
				update(obj = newObj);
			} else {
				remove();
			}
		};
	}

	var replaceText = (function () {
		var textStore = [];

		return function (index, replacement) {
			textStore[index] = replacement;
			return textStore.filter(Boolean).join('\n');
		};
	})();

	function applyToSingletonTag(styleElement, index, remove, obj) {
		var css = remove ? "" : obj.css;

		if (styleElement.styleSheet) {
			styleElement.styleSheet.cssText = replaceText(index, css);
		} else {
			var cssNode = document.createTextNode(css);
			var childNodes = styleElement.childNodes;
			if (childNodes[index]) styleElement.removeChild(childNodes[index]);
			if (childNodes.length) {
				styleElement.insertBefore(cssNode, childNodes[index]);
			} else {
				styleElement.appendChild(cssNode);
			}
		}
	}

	function applyToTag(styleElement, obj) {
		var css = obj.css;
		var media = obj.media;

		if(media) {
			styleElement.setAttribute("media", media)
		}

		if(styleElement.styleSheet) {
			styleElement.styleSheet.cssText = css;
		} else {
			while(styleElement.firstChild) {
				styleElement.removeChild(styleElement.firstChild);
			}
			styleElement.appendChild(document.createTextNode(css));
		}
	}

	function updateLink(linkElement, obj) {
		var css = obj.css;
		var sourceMap = obj.sourceMap;

		if(sourceMap) {
			// http://stackoverflow.com/a/26603875
			css += "\n/*# sourceMappingURL=data:application/json;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))) + " */";
		}

		var blob = new Blob([css], { type: "text/css" });

		var oldSrc = linkElement.href;

		linkElement.href = URL.createObjectURL(blob);

		if(oldSrc)
			URL.revokeObjectURL(oldSrc);
	}


/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

	// style-loader: Adds some css to the DOM by adding a <style> tag

	// load the styles
	var content = __webpack_require__(7);
	if(typeof content === 'string') content = [[module.id, content, '']];
	// add the styles to the DOM
	var update = __webpack_require__(5)(content, {});
	if(content.locals) module.exports = content.locals;
	// Hot Module Replacement
	if(false) {
		// When the styles change, update the <style> tags
		if(!content.locals) {
			module.hot.accept("!!../../css-loader/index.js!./font-awesome.css", function() {
				var newContent = require("!!../../css-loader/index.js!./font-awesome.css");
				if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];
				update(newContent);
			});
		}
		// When the module is disposed, remove the <style> tags
		module.hot.dispose(function() { update(); });
	}

/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

	exports = module.exports = __webpack_require__(4)();
	// imports


	// module
	exports.push([module.id, "/*!\n *  Font Awesome 4.7.0 by @davegandy - http://fontawesome.io - @fontawesome\n *  License - http://fontawesome.io/license (Font: SIL OFL 1.1, CSS: MIT License)\n */\n/* FONT PATH\n * -------------------------- */\n@font-face {\n  font-family: 'FontAwesome';\n  src: url(" + __webpack_require__(8) + ");\n  src: url(" + __webpack_require__(9) + "?#iefix&v=4.7.0) format('embedded-opentype'), url(" + __webpack_require__(10) + ") format('woff2'), url(" + __webpack_require__(11) + ") format('woff'), url(" + __webpack_require__(12) + ") format('truetype'), url(" + __webpack_require__(13) + "#fontawesomeregular) format('svg');\n  font-weight: normal;\n  font-style: normal;\n}\n.fa {\n  display: inline-block;\n  font: normal normal normal 14px/1 FontAwesome;\n  font-size: inherit;\n  text-rendering: auto;\n  -webkit-font-smoothing: antialiased;\n  -moz-osx-font-smoothing: grayscale;\n}\n/* makes the font 33% larger relative to the icon container */\n.fa-lg {\n  font-size: 1.33333333em;\n  line-height: 0.75em;\n  vertical-align: -15%;\n}\n.fa-2x {\n  font-size: 2em;\n}\n.fa-3x {\n  font-size: 3em;\n}\n.fa-4x {\n  font-size: 4em;\n}\n.fa-5x {\n  font-size: 5em;\n}\n.fa-fw {\n  width: 1.28571429em;\n  text-align: center;\n}\n.fa-ul {\n  padding-left: 0;\n  margin-left: 2.14285714em;\n  list-style-type: none;\n}\n.fa-ul > li {\n  position: relative;\n}\n.fa-li {\n  position: absolute;\n  left: -2.14285714em;\n  width: 2.14285714em;\n  top: 0.14285714em;\n  text-align: center;\n}\n.fa-li.fa-lg {\n  left: -1.85714286em;\n}\n.fa-border {\n  padding: .2em .25em .15em;\n  border: solid 0.08em #eeeeee;\n  border-radius: .1em;\n}\n.fa-pull-left {\n  float: left;\n}\n.fa-pull-right {\n  float: right;\n}\n.fa.fa-pull-left {\n  margin-right: .3em;\n}\n.fa.fa-pull-right {\n  margin-left: .3em;\n}\n/* Deprecated as of 4.4.0 */\n.pull-right {\n  float: right;\n}\n.pull-left {\n  float: left;\n}\n.fa.pull-left {\n  margin-right: .3em;\n}\n.fa.pull-right {\n  margin-left: .3em;\n}\n.fa-spin {\n  -webkit-animation: fa-spin 2s infinite linear;\n  animation: fa-spin 2s infinite linear;\n}\n.fa-pulse {\n  -webkit-animation: fa-spin 1s infinite steps(8);\n  animation: fa-spin 1s infinite steps(8);\n}\n@-webkit-keyframes fa-spin {\n  0% {\n    -webkit-transform: rotate(0deg);\n    transform: rotate(0deg);\n  }\n  100% {\n    -webkit-transform: rotate(359deg);\n    transform: rotate(359deg);\n  }\n}\n@keyframes fa-spin {\n  0% {\n    -webkit-transform: rotate(0deg);\n    transform: rotate(0deg);\n  }\n  100% {\n    -webkit-transform: rotate(359deg);\n    transform: rotate(359deg);\n  }\n}\n.fa-rotate-90 {\n  -ms-filter: \"progid:DXImageTransform.Microsoft.BasicImage(rotation=1)\";\n  -webkit-transform: rotate(90deg);\n  -ms-transform: rotate(90deg);\n  transform: rotate(90deg);\n}\n.fa-rotate-180 {\n  -ms-filter: \"progid:DXImageTransform.Microsoft.BasicImage(rotation=2)\";\n  -webkit-transform: rotate(180deg);\n  -ms-transform: rotate(180deg);\n  transform: rotate(180deg);\n}\n.fa-rotate-270 {\n  -ms-filter: \"progid:DXImageTransform.Microsoft.BasicImage(rotation=3)\";\n  -webkit-transform: rotate(270deg);\n  -ms-transform: rotate(270deg);\n  transform: rotate(270deg);\n}\n.fa-flip-horizontal {\n  -ms-filter: \"progid:DXImageTransform.Microsoft.BasicImage(rotation=0, mirror=1)\";\n  -webkit-transform: scale(-1, 1);\n  -ms-transform: scale(-1, 1);\n  transform: scale(-1, 1);\n}\n.fa-flip-vertical {\n  -ms-filter: \"progid:DXImageTransform.Microsoft.BasicImage(rotation=2, mirror=1)\";\n  -webkit-transform: scale(1, -1);\n  -ms-transform: scale(1, -1);\n  transform: scale(1, -1);\n}\n:root .fa-rotate-90,\n:root .fa-rotate-180,\n:root .fa-rotate-270,\n:root .fa-flip-horizontal,\n:root .fa-flip-vertical {\n  filter: none;\n}\n.fa-stack {\n  position: relative;\n  display: inline-block;\n  width: 2em;\n  height: 2em;\n  line-height: 2em;\n  vertical-align: middle;\n}\n.fa-stack-1x,\n.fa-stack-2x {\n  position: absolute;\n  left: 0;\n  width: 100%;\n  text-align: center;\n}\n.fa-stack-1x {\n  line-height: inherit;\n}\n.fa-stack-2x {\n  font-size: 2em;\n}\n.fa-inverse {\n  color: #ffffff;\n}\n/* Font Awesome uses the Unicode Private Use Area (PUA) to ensure screen\n   readers do not read off random characters that represent icons */\n.fa-glass:before {\n  content: \"\\F000\";\n}\n.fa-music:before {\n  content: \"\\F001\";\n}\n.fa-search:before {\n  content: \"\\F002\";\n}\n.fa-envelope-o:before {\n  content: \"\\F003\";\n}\n.fa-heart:before {\n  content: \"\\F004\";\n}\n.fa-star:before {\n  content: \"\\F005\";\n}\n.fa-star-o:before {\n  content: \"\\F006\";\n}\n.fa-user:before {\n  content: \"\\F007\";\n}\n.fa-film:before {\n  content: \"\\F008\";\n}\n.fa-th-large:before {\n  content: \"\\F009\";\n}\n.fa-th:before {\n  content: \"\\F00A\";\n}\n.fa-th-list:before {\n  content: \"\\F00B\";\n}\n.fa-check:before {\n  content: \"\\F00C\";\n}\n.fa-remove:before,\n.fa-close:before,\n.fa-times:before {\n  content: \"\\F00D\";\n}\n.fa-search-plus:before {\n  content: \"\\F00E\";\n}\n.fa-search-minus:before {\n  content: \"\\F010\";\n}\n.fa-power-off:before {\n  content: \"\\F011\";\n}\n.fa-signal:before {\n  content: \"\\F012\";\n}\n.fa-gear:before,\n.fa-cog:before {\n  content: \"\\F013\";\n}\n.fa-trash-o:before {\n  content: \"\\F014\";\n}\n.fa-home:before {\n  content: \"\\F015\";\n}\n.fa-file-o:before {\n  content: \"\\F016\";\n}\n.fa-clock-o:before {\n  content: \"\\F017\";\n}\n.fa-road:before {\n  content: \"\\F018\";\n}\n.fa-download:before {\n  content: \"\\F019\";\n}\n.fa-arrow-circle-o-down:before {\n  content: \"\\F01A\";\n}\n.fa-arrow-circle-o-up:before {\n  content: \"\\F01B\";\n}\n.fa-inbox:before {\n  content: \"\\F01C\";\n}\n.fa-play-circle-o:before {\n  content: \"\\F01D\";\n}\n.fa-rotate-right:before,\n.fa-repeat:before {\n  content: \"\\F01E\";\n}\n.fa-refresh:before {\n  content: \"\\F021\";\n}\n.fa-list-alt:before {\n  content: \"\\F022\";\n}\n.fa-lock:before {\n  content: \"\\F023\";\n}\n.fa-flag:before {\n  content: \"\\F024\";\n}\n.fa-headphones:before {\n  content: \"\\F025\";\n}\n.fa-volume-off:before {\n  content: \"\\F026\";\n}\n.fa-volume-down:before {\n  content: \"\\F027\";\n}\n.fa-volume-up:before {\n  content: \"\\F028\";\n}\n.fa-qrcode:before {\n  content: \"\\F029\";\n}\n.fa-barcode:before {\n  content: \"\\F02A\";\n}\n.fa-tag:before {\n  content: \"\\F02B\";\n}\n.fa-tags:before {\n  content: \"\\F02C\";\n}\n.fa-book:before {\n  content: \"\\F02D\";\n}\n.fa-bookmark:before {\n  content: \"\\F02E\";\n}\n.fa-print:before {\n  content: \"\\F02F\";\n}\n.fa-camera:before {\n  content: \"\\F030\";\n}\n.fa-font:before {\n  content: \"\\F031\";\n}\n.fa-bold:before {\n  content: \"\\F032\";\n}\n.fa-italic:before {\n  content: \"\\F033\";\n}\n.fa-text-height:before {\n  content: \"\\F034\";\n}\n.fa-text-width:before {\n  content: \"\\F035\";\n}\n.fa-align-left:before {\n  content: \"\\F036\";\n}\n.fa-align-center:before {\n  content: \"\\F037\";\n}\n.fa-align-right:before {\n  content: \"\\F038\";\n}\n.fa-align-justify:before {\n  content: \"\\F039\";\n}\n.fa-list:before {\n  content: \"\\F03A\";\n}\n.fa-dedent:before,\n.fa-outdent:before {\n  content: \"\\F03B\";\n}\n.fa-indent:before {\n  content: \"\\F03C\";\n}\n.fa-video-camera:before {\n  content: \"\\F03D\";\n}\n.fa-photo:before,\n.fa-image:before,\n.fa-picture-o:before {\n  content: \"\\F03E\";\n}\n.fa-pencil:before {\n  content: \"\\F040\";\n}\n.fa-map-marker:before {\n  content: \"\\F041\";\n}\n.fa-adjust:before {\n  content: \"\\F042\";\n}\n.fa-tint:before {\n  content: \"\\F043\";\n}\n.fa-edit:before,\n.fa-pencil-square-o:before {\n  content: \"\\F044\";\n}\n.fa-share-square-o:before {\n  content: \"\\F045\";\n}\n.fa-check-square-o:before {\n  content: \"\\F046\";\n}\n.fa-arrows:before {\n  content: \"\\F047\";\n}\n.fa-step-backward:before {\n  content: \"\\F048\";\n}\n.fa-fast-backward:before {\n  content: \"\\F049\";\n}\n.fa-backward:before {\n  content: \"\\F04A\";\n}\n.fa-play:before {\n  content: \"\\F04B\";\n}\n.fa-pause:before {\n  content: \"\\F04C\";\n}\n.fa-stop:before {\n  content: \"\\F04D\";\n}\n.fa-forward:before {\n  content: \"\\F04E\";\n}\n.fa-fast-forward:before {\n  content: \"\\F050\";\n}\n.fa-step-forward:before {\n  content: \"\\F051\";\n}\n.fa-eject:before {\n  content: \"\\F052\";\n}\n.fa-chevron-left:before {\n  content: \"\\F053\";\n}\n.fa-chevron-right:before {\n  content: \"\\F054\";\n}\n.fa-plus-circle:before {\n  content: \"\\F055\";\n}\n.fa-minus-circle:before {\n  content: \"\\F056\";\n}\n.fa-times-circle:before {\n  content: \"\\F057\";\n}\n.fa-check-circle:before {\n  content: \"\\F058\";\n}\n.fa-question-circle:before {\n  content: \"\\F059\";\n}\n.fa-info-circle:before {\n  content: \"\\F05A\";\n}\n.fa-crosshairs:before {\n  content: \"\\F05B\";\n}\n.fa-times-circle-o:before {\n  content: \"\\F05C\";\n}\n.fa-check-circle-o:before {\n  content: \"\\F05D\";\n}\n.fa-ban:before {\n  content: \"\\F05E\";\n}\n.fa-arrow-left:before {\n  content: \"\\F060\";\n}\n.fa-arrow-right:before {\n  content: \"\\F061\";\n}\n.fa-arrow-up:before {\n  content: \"\\F062\";\n}\n.fa-arrow-down:before {\n  content: \"\\F063\";\n}\n.fa-mail-forward:before,\n.fa-share:before {\n  content: \"\\F064\";\n}\n.fa-expand:before {\n  content: \"\\F065\";\n}\n.fa-compress:before {\n  content: \"\\F066\";\n}\n.fa-plus:before {\n  content: \"\\F067\";\n}\n.fa-minus:before {\n  content: \"\\F068\";\n}\n.fa-asterisk:before {\n  content: \"\\F069\";\n}\n.fa-exclamation-circle:before {\n  content: \"\\F06A\";\n}\n.fa-gift:before {\n  content: \"\\F06B\";\n}\n.fa-leaf:before {\n  content: \"\\F06C\";\n}\n.fa-fire:before {\n  content: \"\\F06D\";\n}\n.fa-eye:before {\n  content: \"\\F06E\";\n}\n.fa-eye-slash:before {\n  content: \"\\F070\";\n}\n.fa-warning:before,\n.fa-exclamation-triangle:before {\n  content: \"\\F071\";\n}\n.fa-plane:before {\n  content: \"\\F072\";\n}\n.fa-calendar:before {\n  content: \"\\F073\";\n}\n.fa-random:before {\n  content: \"\\F074\";\n}\n.fa-comment:before {\n  content: \"\\F075\";\n}\n.fa-magnet:before {\n  content: \"\\F076\";\n}\n.fa-chevron-up:before {\n  content: \"\\F077\";\n}\n.fa-chevron-down:before {\n  content: \"\\F078\";\n}\n.fa-retweet:before {\n  content: \"\\F079\";\n}\n.fa-shopping-cart:before {\n  content: \"\\F07A\";\n}\n.fa-folder:before {\n  content: \"\\F07B\";\n}\n.fa-folder-open:before {\n  content: \"\\F07C\";\n}\n.fa-arrows-v:before {\n  content: \"\\F07D\";\n}\n.fa-arrows-h:before {\n  content: \"\\F07E\";\n}\n.fa-bar-chart-o:before,\n.fa-bar-chart:before {\n  content: \"\\F080\";\n}\n.fa-twitter-square:before {\n  content: \"\\F081\";\n}\n.fa-facebook-square:before {\n  content: \"\\F082\";\n}\n.fa-camera-retro:before {\n  content: \"\\F083\";\n}\n.fa-key:before {\n  content: \"\\F084\";\n}\n.fa-gears:before,\n.fa-cogs:before {\n  content: \"\\F085\";\n}\n.fa-comments:before {\n  content: \"\\F086\";\n}\n.fa-thumbs-o-up:before {\n  content: \"\\F087\";\n}\n.fa-thumbs-o-down:before {\n  content: \"\\F088\";\n}\n.fa-star-half:before {\n  content: \"\\F089\";\n}\n.fa-heart-o:before {\n  content: \"\\F08A\";\n}\n.fa-sign-out:before {\n  content: \"\\F08B\";\n}\n.fa-linkedin-square:before {\n  content: \"\\F08C\";\n}\n.fa-thumb-tack:before {\n  content: \"\\F08D\";\n}\n.fa-external-link:before {\n  content: \"\\F08E\";\n}\n.fa-sign-in:before {\n  content: \"\\F090\";\n}\n.fa-trophy:before {\n  content: \"\\F091\";\n}\n.fa-github-square:before {\n  content: \"\\F092\";\n}\n.fa-upload:before {\n  content: \"\\F093\";\n}\n.fa-lemon-o:before {\n  content: \"\\F094\";\n}\n.fa-phone:before {\n  content: \"\\F095\";\n}\n.fa-square-o:before {\n  content: \"\\F096\";\n}\n.fa-bookmark-o:before {\n  content: \"\\F097\";\n}\n.fa-phone-square:before {\n  content: \"\\F098\";\n}\n.fa-twitter:before {\n  content: \"\\F099\";\n}\n.fa-facebook-f:before,\n.fa-facebook:before {\n  content: \"\\F09A\";\n}\n.fa-github:before {\n  content: \"\\F09B\";\n}\n.fa-unlock:before {\n  content: \"\\F09C\";\n}\n.fa-credit-card:before {\n  content: \"\\F09D\";\n}\n.fa-feed:before,\n.fa-rss:before {\n  content: \"\\F09E\";\n}\n.fa-hdd-o:before {\n  content: \"\\F0A0\";\n}\n.fa-bullhorn:before {\n  content: \"\\F0A1\";\n}\n.fa-bell:before {\n  content: \"\\F0F3\";\n}\n.fa-certificate:before {\n  content: \"\\F0A3\";\n}\n.fa-hand-o-right:before {\n  content: \"\\F0A4\";\n}\n.fa-hand-o-left:before {\n  content: \"\\F0A5\";\n}\n.fa-hand-o-up:before {\n  content: \"\\F0A6\";\n}\n.fa-hand-o-down:before {\n  content: \"\\F0A7\";\n}\n.fa-arrow-circle-left:before {\n  content: \"\\F0A8\";\n}\n.fa-arrow-circle-right:before {\n  content: \"\\F0A9\";\n}\n.fa-arrow-circle-up:before {\n  content: \"\\F0AA\";\n}\n.fa-arrow-circle-down:before {\n  content: \"\\F0AB\";\n}\n.fa-globe:before {\n  content: \"\\F0AC\";\n}\n.fa-wrench:before {\n  content: \"\\F0AD\";\n}\n.fa-tasks:before {\n  content: \"\\F0AE\";\n}\n.fa-filter:before {\n  content: \"\\F0B0\";\n}\n.fa-briefcase:before {\n  content: \"\\F0B1\";\n}\n.fa-arrows-alt:before {\n  content: \"\\F0B2\";\n}\n.fa-group:before,\n.fa-users:before {\n  content: \"\\F0C0\";\n}\n.fa-chain:before,\n.fa-link:before {\n  content: \"\\F0C1\";\n}\n.fa-cloud:before {\n  content: \"\\F0C2\";\n}\n.fa-flask:before {\n  content: \"\\F0C3\";\n}\n.fa-cut:before,\n.fa-scissors:before {\n  content: \"\\F0C4\";\n}\n.fa-copy:before,\n.fa-files-o:before {\n  content: \"\\F0C5\";\n}\n.fa-paperclip:before {\n  content: \"\\F0C6\";\n}\n.fa-save:before,\n.fa-floppy-o:before {\n  content: \"\\F0C7\";\n}\n.fa-square:before {\n  content: \"\\F0C8\";\n}\n.fa-navicon:before,\n.fa-reorder:before,\n.fa-bars:before {\n  content: \"\\F0C9\";\n}\n.fa-list-ul:before {\n  content: \"\\F0CA\";\n}\n.fa-list-ol:before {\n  content: \"\\F0CB\";\n}\n.fa-strikethrough:before {\n  content: \"\\F0CC\";\n}\n.fa-underline:before {\n  content: \"\\F0CD\";\n}\n.fa-table:before {\n  content: \"\\F0CE\";\n}\n.fa-magic:before {\n  content: \"\\F0D0\";\n}\n.fa-truck:before {\n  content: \"\\F0D1\";\n}\n.fa-pinterest:before {\n  content: \"\\F0D2\";\n}\n.fa-pinterest-square:before {\n  content: \"\\F0D3\";\n}\n.fa-google-plus-square:before {\n  content: \"\\F0D4\";\n}\n.fa-google-plus:before {\n  content: \"\\F0D5\";\n}\n.fa-money:before {\n  content: \"\\F0D6\";\n}\n.fa-caret-down:before {\n  content: \"\\F0D7\";\n}\n.fa-caret-up:before {\n  content: \"\\F0D8\";\n}\n.fa-caret-left:before {\n  content: \"\\F0D9\";\n}\n.fa-caret-right:before {\n  content: \"\\F0DA\";\n}\n.fa-columns:before {\n  content: \"\\F0DB\";\n}\n.fa-unsorted:before,\n.fa-sort:before {\n  content: \"\\F0DC\";\n}\n.fa-sort-down:before,\n.fa-sort-desc:before {\n  content: \"\\F0DD\";\n}\n.fa-sort-up:before,\n.fa-sort-asc:before {\n  content: \"\\F0DE\";\n}\n.fa-envelope:before {\n  content: \"\\F0E0\";\n}\n.fa-linkedin:before {\n  content: \"\\F0E1\";\n}\n.fa-rotate-left:before,\n.fa-undo:before {\n  content: \"\\F0E2\";\n}\n.fa-legal:before,\n.fa-gavel:before {\n  content: \"\\F0E3\";\n}\n.fa-dashboard:before,\n.fa-tachometer:before {\n  content: \"\\F0E4\";\n}\n.fa-comment-o:before {\n  content: \"\\F0E5\";\n}\n.fa-comments-o:before {\n  content: \"\\F0E6\";\n}\n.fa-flash:before,\n.fa-bolt:before {\n  content: \"\\F0E7\";\n}\n.fa-sitemap:before {\n  content: \"\\F0E8\";\n}\n.fa-umbrella:before {\n  content: \"\\F0E9\";\n}\n.fa-paste:before,\n.fa-clipboard:before {\n  content: \"\\F0EA\";\n}\n.fa-lightbulb-o:before {\n  content: \"\\F0EB\";\n}\n.fa-exchange:before {\n  content: \"\\F0EC\";\n}\n.fa-cloud-download:before {\n  content: \"\\F0ED\";\n}\n.fa-cloud-upload:before {\n  content: \"\\F0EE\";\n}\n.fa-user-md:before {\n  content: \"\\F0F0\";\n}\n.fa-stethoscope:before {\n  content: \"\\F0F1\";\n}\n.fa-suitcase:before {\n  content: \"\\F0F2\";\n}\n.fa-bell-o:before {\n  content: \"\\F0A2\";\n}\n.fa-coffee:before {\n  content: \"\\F0F4\";\n}\n.fa-cutlery:before {\n  content: \"\\F0F5\";\n}\n.fa-file-text-o:before {\n  content: \"\\F0F6\";\n}\n.fa-building-o:before {\n  content: \"\\F0F7\";\n}\n.fa-hospital-o:before {\n  content: \"\\F0F8\";\n}\n.fa-ambulance:before {\n  content: \"\\F0F9\";\n}\n.fa-medkit:before {\n  content: \"\\F0FA\";\n}\n.fa-fighter-jet:before {\n  content: \"\\F0FB\";\n}\n.fa-beer:before {\n  content: \"\\F0FC\";\n}\n.fa-h-square:before {\n  content: \"\\F0FD\";\n}\n.fa-plus-square:before {\n  content: \"\\F0FE\";\n}\n.fa-angle-double-left:before {\n  content: \"\\F100\";\n}\n.fa-angle-double-right:before {\n  content: \"\\F101\";\n}\n.fa-angle-double-up:before {\n  content: \"\\F102\";\n}\n.fa-angle-double-down:before {\n  content: \"\\F103\";\n}\n.fa-angle-left:before {\n  content: \"\\F104\";\n}\n.fa-angle-right:before {\n  content: \"\\F105\";\n}\n.fa-angle-up:before {\n  content: \"\\F106\";\n}\n.fa-angle-down:before {\n  content: \"\\F107\";\n}\n.fa-desktop:before {\n  content: \"\\F108\";\n}\n.fa-laptop:before {\n  content: \"\\F109\";\n}\n.fa-tablet:before {\n  content: \"\\F10A\";\n}\n.fa-mobile-phone:before,\n.fa-mobile:before {\n  content: \"\\F10B\";\n}\n.fa-circle-o:before {\n  content: \"\\F10C\";\n}\n.fa-quote-left:before {\n  content: \"\\F10D\";\n}\n.fa-quote-right:before {\n  content: \"\\F10E\";\n}\n.fa-spinner:before {\n  content: \"\\F110\";\n}\n.fa-circle:before {\n  content: \"\\F111\";\n}\n.fa-mail-reply:before,\n.fa-reply:before {\n  content: \"\\F112\";\n}\n.fa-github-alt:before {\n  content: \"\\F113\";\n}\n.fa-folder-o:before {\n  content: \"\\F114\";\n}\n.fa-folder-open-o:before {\n  content: \"\\F115\";\n}\n.fa-smile-o:before {\n  content: \"\\F118\";\n}\n.fa-frown-o:before {\n  content: \"\\F119\";\n}\n.fa-meh-o:before {\n  content: \"\\F11A\";\n}\n.fa-gamepad:before {\n  content: \"\\F11B\";\n}\n.fa-keyboard-o:before {\n  content: \"\\F11C\";\n}\n.fa-flag-o:before {\n  content: \"\\F11D\";\n}\n.fa-flag-checkered:before {\n  content: \"\\F11E\";\n}\n.fa-terminal:before {\n  content: \"\\F120\";\n}\n.fa-code:before {\n  content: \"\\F121\";\n}\n.fa-mail-reply-all:before,\n.fa-reply-all:before {\n  content: \"\\F122\";\n}\n.fa-star-half-empty:before,\n.fa-star-half-full:before,\n.fa-star-half-o:before {\n  content: \"\\F123\";\n}\n.fa-location-arrow:before {\n  content: \"\\F124\";\n}\n.fa-crop:before {\n  content: \"\\F125\";\n}\n.fa-code-fork:before {\n  content: \"\\F126\";\n}\n.fa-unlink:before,\n.fa-chain-broken:before {\n  content: \"\\F127\";\n}\n.fa-question:before {\n  content: \"\\F128\";\n}\n.fa-info:before {\n  content: \"\\F129\";\n}\n.fa-exclamation:before {\n  content: \"\\F12A\";\n}\n.fa-superscript:before {\n  content: \"\\F12B\";\n}\n.fa-subscript:before {\n  content: \"\\F12C\";\n}\n.fa-eraser:before {\n  content: \"\\F12D\";\n}\n.fa-puzzle-piece:before {\n  content: \"\\F12E\";\n}\n.fa-microphone:before {\n  content: \"\\F130\";\n}\n.fa-microphone-slash:before {\n  content: \"\\F131\";\n}\n.fa-shield:before {\n  content: \"\\F132\";\n}\n.fa-calendar-o:before {\n  content: \"\\F133\";\n}\n.fa-fire-extinguisher:before {\n  content: \"\\F134\";\n}\n.fa-rocket:before {\n  content: \"\\F135\";\n}\n.fa-maxcdn:before {\n  content: \"\\F136\";\n}\n.fa-chevron-circle-left:before {\n  content: \"\\F137\";\n}\n.fa-chevron-circle-right:before {\n  content: \"\\F138\";\n}\n.fa-chevron-circle-up:before {\n  content: \"\\F139\";\n}\n.fa-chevron-circle-down:before {\n  content: \"\\F13A\";\n}\n.fa-html5:before {\n  content: \"\\F13B\";\n}\n.fa-css3:before {\n  content: \"\\F13C\";\n}\n.fa-anchor:before {\n  content: \"\\F13D\";\n}\n.fa-unlock-alt:before {\n  content: \"\\F13E\";\n}\n.fa-bullseye:before {\n  content: \"\\F140\";\n}\n.fa-ellipsis-h:before {\n  content: \"\\F141\";\n}\n.fa-ellipsis-v:before {\n  content: \"\\F142\";\n}\n.fa-rss-square:before {\n  content: \"\\F143\";\n}\n.fa-play-circle:before {\n  content: \"\\F144\";\n}\n.fa-ticket:before {\n  content: \"\\F145\";\n}\n.fa-minus-square:before {\n  content: \"\\F146\";\n}\n.fa-minus-square-o:before {\n  content: \"\\F147\";\n}\n.fa-level-up:before {\n  content: \"\\F148\";\n}\n.fa-level-down:before {\n  content: \"\\F149\";\n}\n.fa-check-square:before {\n  content: \"\\F14A\";\n}\n.fa-pencil-square:before {\n  content: \"\\F14B\";\n}\n.fa-external-link-square:before {\n  content: \"\\F14C\";\n}\n.fa-share-square:before {\n  content: \"\\F14D\";\n}\n.fa-compass:before {\n  content: \"\\F14E\";\n}\n.fa-toggle-down:before,\n.fa-caret-square-o-down:before {\n  content: \"\\F150\";\n}\n.fa-toggle-up:before,\n.fa-caret-square-o-up:before {\n  content: \"\\F151\";\n}\n.fa-toggle-right:before,\n.fa-caret-square-o-right:before {\n  content: \"\\F152\";\n}\n.fa-euro:before,\n.fa-eur:before {\n  content: \"\\F153\";\n}\n.fa-gbp:before {\n  content: \"\\F154\";\n}\n.fa-dollar:before,\n.fa-usd:before {\n  content: \"\\F155\";\n}\n.fa-rupee:before,\n.fa-inr:before {\n  content: \"\\F156\";\n}\n.fa-cny:before,\n.fa-rmb:before,\n.fa-yen:before,\n.fa-jpy:before {\n  content: \"\\F157\";\n}\n.fa-ruble:before,\n.fa-rouble:before,\n.fa-rub:before {\n  content: \"\\F158\";\n}\n.fa-won:before,\n.fa-krw:before {\n  content: \"\\F159\";\n}\n.fa-bitcoin:before,\n.fa-btc:before {\n  content: \"\\F15A\";\n}\n.fa-file:before {\n  content: \"\\F15B\";\n}\n.fa-file-text:before {\n  content: \"\\F15C\";\n}\n.fa-sort-alpha-asc:before {\n  content: \"\\F15D\";\n}\n.fa-sort-alpha-desc:before {\n  content: \"\\F15E\";\n}\n.fa-sort-amount-asc:before {\n  content: \"\\F160\";\n}\n.fa-sort-amount-desc:before {\n  content: \"\\F161\";\n}\n.fa-sort-numeric-asc:before {\n  content: \"\\F162\";\n}\n.fa-sort-numeric-desc:before {\n  content: \"\\F163\";\n}\n.fa-thumbs-up:before {\n  content: \"\\F164\";\n}\n.fa-thumbs-down:before {\n  content: \"\\F165\";\n}\n.fa-youtube-square:before {\n  content: \"\\F166\";\n}\n.fa-youtube:before {\n  content: \"\\F167\";\n}\n.fa-xing:before {\n  content: \"\\F168\";\n}\n.fa-xing-square:before {\n  content: \"\\F169\";\n}\n.fa-youtube-play:before {\n  content: \"\\F16A\";\n}\n.fa-dropbox:before {\n  content: \"\\F16B\";\n}\n.fa-stack-overflow:before {\n  content: \"\\F16C\";\n}\n.fa-instagram:before {\n  content: \"\\F16D\";\n}\n.fa-flickr:before {\n  content: \"\\F16E\";\n}\n.fa-adn:before {\n  content: \"\\F170\";\n}\n.fa-bitbucket:before {\n  content: \"\\F171\";\n}\n.fa-bitbucket-square:before {\n  content: \"\\F172\";\n}\n.fa-tumblr:before {\n  content: \"\\F173\";\n}\n.fa-tumblr-square:before {\n  content: \"\\F174\";\n}\n.fa-long-arrow-down:before {\n  content: \"\\F175\";\n}\n.fa-long-arrow-up:before {\n  content: \"\\F176\";\n}\n.fa-long-arrow-left:before {\n  content: \"\\F177\";\n}\n.fa-long-arrow-right:before {\n  content: \"\\F178\";\n}\n.fa-apple:before {\n  content: \"\\F179\";\n}\n.fa-windows:before {\n  content: \"\\F17A\";\n}\n.fa-android:before {\n  content: \"\\F17B\";\n}\n.fa-linux:before {\n  content: \"\\F17C\";\n}\n.fa-dribbble:before {\n  content: \"\\F17D\";\n}\n.fa-skype:before {\n  content: \"\\F17E\";\n}\n.fa-foursquare:before {\n  content: \"\\F180\";\n}\n.fa-trello:before {\n  content: \"\\F181\";\n}\n.fa-female:before {\n  content: \"\\F182\";\n}\n.fa-male:before {\n  content: \"\\F183\";\n}\n.fa-gittip:before,\n.fa-gratipay:before {\n  content: \"\\F184\";\n}\n.fa-sun-o:before {\n  content: \"\\F185\";\n}\n.fa-moon-o:before {\n  content: \"\\F186\";\n}\n.fa-archive:before {\n  content: \"\\F187\";\n}\n.fa-bug:before {\n  content: \"\\F188\";\n}\n.fa-vk:before {\n  content: \"\\F189\";\n}\n.fa-weibo:before {\n  content: \"\\F18A\";\n}\n.fa-renren:before {\n  content: \"\\F18B\";\n}\n.fa-pagelines:before {\n  content: \"\\F18C\";\n}\n.fa-stack-exchange:before {\n  content: \"\\F18D\";\n}\n.fa-arrow-circle-o-right:before {\n  content: \"\\F18E\";\n}\n.fa-arrow-circle-o-left:before {\n  content: \"\\F190\";\n}\n.fa-toggle-left:before,\n.fa-caret-square-o-left:before {\n  content: \"\\F191\";\n}\n.fa-dot-circle-o:before {\n  content: \"\\F192\";\n}\n.fa-wheelchair:before {\n  content: \"\\F193\";\n}\n.fa-vimeo-square:before {\n  content: \"\\F194\";\n}\n.fa-turkish-lira:before,\n.fa-try:before {\n  content: \"\\F195\";\n}\n.fa-plus-square-o:before {\n  content: \"\\F196\";\n}\n.fa-space-shuttle:before {\n  content: \"\\F197\";\n}\n.fa-slack:before {\n  content: \"\\F198\";\n}\n.fa-envelope-square:before {\n  content: \"\\F199\";\n}\n.fa-wordpress:before {\n  content: \"\\F19A\";\n}\n.fa-openid:before {\n  content: \"\\F19B\";\n}\n.fa-institution:before,\n.fa-bank:before,\n.fa-university:before {\n  content: \"\\F19C\";\n}\n.fa-mortar-board:before,\n.fa-graduation-cap:before {\n  content: \"\\F19D\";\n}\n.fa-yahoo:before {\n  content: \"\\F19E\";\n}\n.fa-google:before {\n  content: \"\\F1A0\";\n}\n.fa-reddit:before {\n  content: \"\\F1A1\";\n}\n.fa-reddit-square:before {\n  content: \"\\F1A2\";\n}\n.fa-stumbleupon-circle:before {\n  content: \"\\F1A3\";\n}\n.fa-stumbleupon:before {\n  content: \"\\F1A4\";\n}\n.fa-delicious:before {\n  content: \"\\F1A5\";\n}\n.fa-digg:before {\n  content: \"\\F1A6\";\n}\n.fa-pied-piper-pp:before {\n  content: \"\\F1A7\";\n}\n.fa-pied-piper-alt:before {\n  content: \"\\F1A8\";\n}\n.fa-drupal:before {\n  content: \"\\F1A9\";\n}\n.fa-joomla:before {\n  content: \"\\F1AA\";\n}\n.fa-language:before {\n  content: \"\\F1AB\";\n}\n.fa-fax:before {\n  content: \"\\F1AC\";\n}\n.fa-building:before {\n  content: \"\\F1AD\";\n}\n.fa-child:before {\n  content: \"\\F1AE\";\n}\n.fa-paw:before {\n  content: \"\\F1B0\";\n}\n.fa-spoon:before {\n  content: \"\\F1B1\";\n}\n.fa-cube:before {\n  content: \"\\F1B2\";\n}\n.fa-cubes:before {\n  content: \"\\F1B3\";\n}\n.fa-behance:before {\n  content: \"\\F1B4\";\n}\n.fa-behance-square:before {\n  content: \"\\F1B5\";\n}\n.fa-steam:before {\n  content: \"\\F1B6\";\n}\n.fa-steam-square:before {\n  content: \"\\F1B7\";\n}\n.fa-recycle:before {\n  content: \"\\F1B8\";\n}\n.fa-automobile:before,\n.fa-car:before {\n  content: \"\\F1B9\";\n}\n.fa-cab:before,\n.fa-taxi:before {\n  content: \"\\F1BA\";\n}\n.fa-tree:before {\n  content: \"\\F1BB\";\n}\n.fa-spotify:before {\n  content: \"\\F1BC\";\n}\n.fa-deviantart:before {\n  content: \"\\F1BD\";\n}\n.fa-soundcloud:before {\n  content: \"\\F1BE\";\n}\n.fa-database:before {\n  content: \"\\F1C0\";\n}\n.fa-file-pdf-o:before {\n  content: \"\\F1C1\";\n}\n.fa-file-word-o:before {\n  content: \"\\F1C2\";\n}\n.fa-file-excel-o:before {\n  content: \"\\F1C3\";\n}\n.fa-file-powerpoint-o:before {\n  content: \"\\F1C4\";\n}\n.fa-file-photo-o:before,\n.fa-file-picture-o:before,\n.fa-file-image-o:before {\n  content: \"\\F1C5\";\n}\n.fa-file-zip-o:before,\n.fa-file-archive-o:before {\n  content: \"\\F1C6\";\n}\n.fa-file-sound-o:before,\n.fa-file-audio-o:before {\n  content: \"\\F1C7\";\n}\n.fa-file-movie-o:before,\n.fa-file-video-o:before {\n  content: \"\\F1C8\";\n}\n.fa-file-code-o:before {\n  content: \"\\F1C9\";\n}\n.fa-vine:before {\n  content: \"\\F1CA\";\n}\n.fa-codepen:before {\n  content: \"\\F1CB\";\n}\n.fa-jsfiddle:before {\n  content: \"\\F1CC\";\n}\n.fa-life-bouy:before,\n.fa-life-buoy:before,\n.fa-life-saver:before,\n.fa-support:before,\n.fa-life-ring:before {\n  content: \"\\F1CD\";\n}\n.fa-circle-o-notch:before {\n  content: \"\\F1CE\";\n}\n.fa-ra:before,\n.fa-resistance:before,\n.fa-rebel:before {\n  content: \"\\F1D0\";\n}\n.fa-ge:before,\n.fa-empire:before {\n  content: \"\\F1D1\";\n}\n.fa-git-square:before {\n  content: \"\\F1D2\";\n}\n.fa-git:before {\n  content: \"\\F1D3\";\n}\n.fa-y-combinator-square:before,\n.fa-yc-square:before,\n.fa-hacker-news:before {\n  content: \"\\F1D4\";\n}\n.fa-tencent-weibo:before {\n  content: \"\\F1D5\";\n}\n.fa-qq:before {\n  content: \"\\F1D6\";\n}\n.fa-wechat:before,\n.fa-weixin:before {\n  content: \"\\F1D7\";\n}\n.fa-send:before,\n.fa-paper-plane:before {\n  content: \"\\F1D8\";\n}\n.fa-send-o:before,\n.fa-paper-plane-o:before {\n  content: \"\\F1D9\";\n}\n.fa-history:before {\n  content: \"\\F1DA\";\n}\n.fa-circle-thin:before {\n  content: \"\\F1DB\";\n}\n.fa-header:before {\n  content: \"\\F1DC\";\n}\n.fa-paragraph:before {\n  content: \"\\F1DD\";\n}\n.fa-sliders:before {\n  content: \"\\F1DE\";\n}\n.fa-share-alt:before {\n  content: \"\\F1E0\";\n}\n.fa-share-alt-square:before {\n  content: \"\\F1E1\";\n}\n.fa-bomb:before {\n  content: \"\\F1E2\";\n}\n.fa-soccer-ball-o:before,\n.fa-futbol-o:before {\n  content: \"\\F1E3\";\n}\n.fa-tty:before {\n  content: \"\\F1E4\";\n}\n.fa-binoculars:before {\n  content: \"\\F1E5\";\n}\n.fa-plug:before {\n  content: \"\\F1E6\";\n}\n.fa-slideshare:before {\n  content: \"\\F1E7\";\n}\n.fa-twitch:before {\n  content: \"\\F1E8\";\n}\n.fa-yelp:before {\n  content: \"\\F1E9\";\n}\n.fa-newspaper-o:before {\n  content: \"\\F1EA\";\n}\n.fa-wifi:before {\n  content: \"\\F1EB\";\n}\n.fa-calculator:before {\n  content: \"\\F1EC\";\n}\n.fa-paypal:before {\n  content: \"\\F1ED\";\n}\n.fa-google-wallet:before {\n  content: \"\\F1EE\";\n}\n.fa-cc-visa:before {\n  content: \"\\F1F0\";\n}\n.fa-cc-mastercard:before {\n  content: \"\\F1F1\";\n}\n.fa-cc-discover:before {\n  content: \"\\F1F2\";\n}\n.fa-cc-amex:before {\n  content: \"\\F1F3\";\n}\n.fa-cc-paypal:before {\n  content: \"\\F1F4\";\n}\n.fa-cc-stripe:before {\n  content: \"\\F1F5\";\n}\n.fa-bell-slash:before {\n  content: \"\\F1F6\";\n}\n.fa-bell-slash-o:before {\n  content: \"\\F1F7\";\n}\n.fa-trash:before {\n  content: \"\\F1F8\";\n}\n.fa-copyright:before {\n  content: \"\\F1F9\";\n}\n.fa-at:before {\n  content: \"\\F1FA\";\n}\n.fa-eyedropper:before {\n  content: \"\\F1FB\";\n}\n.fa-paint-brush:before {\n  content: \"\\F1FC\";\n}\n.fa-birthday-cake:before {\n  content: \"\\F1FD\";\n}\n.fa-area-chart:before {\n  content: \"\\F1FE\";\n}\n.fa-pie-chart:before {\n  content: \"\\F200\";\n}\n.fa-line-chart:before {\n  content: \"\\F201\";\n}\n.fa-lastfm:before {\n  content: \"\\F202\";\n}\n.fa-lastfm-square:before {\n  content: \"\\F203\";\n}\n.fa-toggle-off:before {\n  content: \"\\F204\";\n}\n.fa-toggle-on:before {\n  content: \"\\F205\";\n}\n.fa-bicycle:before {\n  content: \"\\F206\";\n}\n.fa-bus:before {\n  content: \"\\F207\";\n}\n.fa-ioxhost:before {\n  content: \"\\F208\";\n}\n.fa-angellist:before {\n  content: \"\\F209\";\n}\n.fa-cc:before {\n  content: \"\\F20A\";\n}\n.fa-shekel:before,\n.fa-sheqel:before,\n.fa-ils:before {\n  content: \"\\F20B\";\n}\n.fa-meanpath:before {\n  content: \"\\F20C\";\n}\n.fa-buysellads:before {\n  content: \"\\F20D\";\n}\n.fa-connectdevelop:before {\n  content: \"\\F20E\";\n}\n.fa-dashcube:before {\n  content: \"\\F210\";\n}\n.fa-forumbee:before {\n  content: \"\\F211\";\n}\n.fa-leanpub:before {\n  content: \"\\F212\";\n}\n.fa-sellsy:before {\n  content: \"\\F213\";\n}\n.fa-shirtsinbulk:before {\n  content: \"\\F214\";\n}\n.fa-simplybuilt:before {\n  content: \"\\F215\";\n}\n.fa-skyatlas:before {\n  content: \"\\F216\";\n}\n.fa-cart-plus:before {\n  content: \"\\F217\";\n}\n.fa-cart-arrow-down:before {\n  content: \"\\F218\";\n}\n.fa-diamond:before {\n  content: \"\\F219\";\n}\n.fa-ship:before {\n  content: \"\\F21A\";\n}\n.fa-user-secret:before {\n  content: \"\\F21B\";\n}\n.fa-motorcycle:before {\n  content: \"\\F21C\";\n}\n.fa-street-view:before {\n  content: \"\\F21D\";\n}\n.fa-heartbeat:before {\n  content: \"\\F21E\";\n}\n.fa-venus:before {\n  content: \"\\F221\";\n}\n.fa-mars:before {\n  content: \"\\F222\";\n}\n.fa-mercury:before {\n  content: \"\\F223\";\n}\n.fa-intersex:before,\n.fa-transgender:before {\n  content: \"\\F224\";\n}\n.fa-transgender-alt:before {\n  content: \"\\F225\";\n}\n.fa-venus-double:before {\n  content: \"\\F226\";\n}\n.fa-mars-double:before {\n  content: \"\\F227\";\n}\n.fa-venus-mars:before {\n  content: \"\\F228\";\n}\n.fa-mars-stroke:before {\n  content: \"\\F229\";\n}\n.fa-mars-stroke-v:before {\n  content: \"\\F22A\";\n}\n.fa-mars-stroke-h:before {\n  content: \"\\F22B\";\n}\n.fa-neuter:before {\n  content: \"\\F22C\";\n}\n.fa-genderless:before {\n  content: \"\\F22D\";\n}\n.fa-facebook-official:before {\n  content: \"\\F230\";\n}\n.fa-pinterest-p:before {\n  content: \"\\F231\";\n}\n.fa-whatsapp:before {\n  content: \"\\F232\";\n}\n.fa-server:before {\n  content: \"\\F233\";\n}\n.fa-user-plus:before {\n  content: \"\\F234\";\n}\n.fa-user-times:before {\n  content: \"\\F235\";\n}\n.fa-hotel:before,\n.fa-bed:before {\n  content: \"\\F236\";\n}\n.fa-viacoin:before {\n  content: \"\\F237\";\n}\n.fa-train:before {\n  content: \"\\F238\";\n}\n.fa-subway:before {\n  content: \"\\F239\";\n}\n.fa-medium:before {\n  content: \"\\F23A\";\n}\n.fa-yc:before,\n.fa-y-combinator:before {\n  content: \"\\F23B\";\n}\n.fa-optin-monster:before {\n  content: \"\\F23C\";\n}\n.fa-opencart:before {\n  content: \"\\F23D\";\n}\n.fa-expeditedssl:before {\n  content: \"\\F23E\";\n}\n.fa-battery-4:before,\n.fa-battery:before,\n.fa-battery-full:before {\n  content: \"\\F240\";\n}\n.fa-battery-3:before,\n.fa-battery-three-quarters:before {\n  content: \"\\F241\";\n}\n.fa-battery-2:before,\n.fa-battery-half:before {\n  content: \"\\F242\";\n}\n.fa-battery-1:before,\n.fa-battery-quarter:before {\n  content: \"\\F243\";\n}\n.fa-battery-0:before,\n.fa-battery-empty:before {\n  content: \"\\F244\";\n}\n.fa-mouse-pointer:before {\n  content: \"\\F245\";\n}\n.fa-i-cursor:before {\n  content: \"\\F246\";\n}\n.fa-object-group:before {\n  content: \"\\F247\";\n}\n.fa-object-ungroup:before {\n  content: \"\\F248\";\n}\n.fa-sticky-note:before {\n  content: \"\\F249\";\n}\n.fa-sticky-note-o:before {\n  content: \"\\F24A\";\n}\n.fa-cc-jcb:before {\n  content: \"\\F24B\";\n}\n.fa-cc-diners-club:before {\n  content: \"\\F24C\";\n}\n.fa-clone:before {\n  content: \"\\F24D\";\n}\n.fa-balance-scale:before {\n  content: \"\\F24E\";\n}\n.fa-hourglass-o:before {\n  content: \"\\F250\";\n}\n.fa-hourglass-1:before,\n.fa-hourglass-start:before {\n  content: \"\\F251\";\n}\n.fa-hourglass-2:before,\n.fa-hourglass-half:before {\n  content: \"\\F252\";\n}\n.fa-hourglass-3:before,\n.fa-hourglass-end:before {\n  content: \"\\F253\";\n}\n.fa-hourglass:before {\n  content: \"\\F254\";\n}\n.fa-hand-grab-o:before,\n.fa-hand-rock-o:before {\n  content: \"\\F255\";\n}\n.fa-hand-stop-o:before,\n.fa-hand-paper-o:before {\n  content: \"\\F256\";\n}\n.fa-hand-scissors-o:before {\n  content: \"\\F257\";\n}\n.fa-hand-lizard-o:before {\n  content: \"\\F258\";\n}\n.fa-hand-spock-o:before {\n  content: \"\\F259\";\n}\n.fa-hand-pointer-o:before {\n  content: \"\\F25A\";\n}\n.fa-hand-peace-o:before {\n  content: \"\\F25B\";\n}\n.fa-trademark:before {\n  content: \"\\F25C\";\n}\n.fa-registered:before {\n  content: \"\\F25D\";\n}\n.fa-creative-commons:before {\n  content: \"\\F25E\";\n}\n.fa-gg:before {\n  content: \"\\F260\";\n}\n.fa-gg-circle:before {\n  content: \"\\F261\";\n}\n.fa-tripadvisor:before {\n  content: \"\\F262\";\n}\n.fa-odnoklassniki:before {\n  content: \"\\F263\";\n}\n.fa-odnoklassniki-square:before {\n  content: \"\\F264\";\n}\n.fa-get-pocket:before {\n  content: \"\\F265\";\n}\n.fa-wikipedia-w:before {\n  content: \"\\F266\";\n}\n.fa-safari:before {\n  content: \"\\F267\";\n}\n.fa-chrome:before {\n  content: \"\\F268\";\n}\n.fa-firefox:before {\n  content: \"\\F269\";\n}\n.fa-opera:before {\n  content: \"\\F26A\";\n}\n.fa-internet-explorer:before {\n  content: \"\\F26B\";\n}\n.fa-tv:before,\n.fa-television:before {\n  content: \"\\F26C\";\n}\n.fa-contao:before {\n  content: \"\\F26D\";\n}\n.fa-500px:before {\n  content: \"\\F26E\";\n}\n.fa-amazon:before {\n  content: \"\\F270\";\n}\n.fa-calendar-plus-o:before {\n  content: \"\\F271\";\n}\n.fa-calendar-minus-o:before {\n  content: \"\\F272\";\n}\n.fa-calendar-times-o:before {\n  content: \"\\F273\";\n}\n.fa-calendar-check-o:before {\n  content: \"\\F274\";\n}\n.fa-industry:before {\n  content: \"\\F275\";\n}\n.fa-map-pin:before {\n  content: \"\\F276\";\n}\n.fa-map-signs:before {\n  content: \"\\F277\";\n}\n.fa-map-o:before {\n  content: \"\\F278\";\n}\n.fa-map:before {\n  content: \"\\F279\";\n}\n.fa-commenting:before {\n  content: \"\\F27A\";\n}\n.fa-commenting-o:before {\n  content: \"\\F27B\";\n}\n.fa-houzz:before {\n  content: \"\\F27C\";\n}\n.fa-vimeo:before {\n  content: \"\\F27D\";\n}\n.fa-black-tie:before {\n  content: \"\\F27E\";\n}\n.fa-fonticons:before {\n  content: \"\\F280\";\n}\n.fa-reddit-alien:before {\n  content: \"\\F281\";\n}\n.fa-edge:before {\n  content: \"\\F282\";\n}\n.fa-credit-card-alt:before {\n  content: \"\\F283\";\n}\n.fa-codiepie:before {\n  content: \"\\F284\";\n}\n.fa-modx:before {\n  content: \"\\F285\";\n}\n.fa-fort-awesome:before {\n  content: \"\\F286\";\n}\n.fa-usb:before {\n  content: \"\\F287\";\n}\n.fa-product-hunt:before {\n  content: \"\\F288\";\n}\n.fa-mixcloud:before {\n  content: \"\\F289\";\n}\n.fa-scribd:before {\n  content: \"\\F28A\";\n}\n.fa-pause-circle:before {\n  content: \"\\F28B\";\n}\n.fa-pause-circle-o:before {\n  content: \"\\F28C\";\n}\n.fa-stop-circle:before {\n  content: \"\\F28D\";\n}\n.fa-stop-circle-o:before {\n  content: \"\\F28E\";\n}\n.fa-shopping-bag:before {\n  content: \"\\F290\";\n}\n.fa-shopping-basket:before {\n  content: \"\\F291\";\n}\n.fa-hashtag:before {\n  content: \"\\F292\";\n}\n.fa-bluetooth:before {\n  content: \"\\F293\";\n}\n.fa-bluetooth-b:before {\n  content: \"\\F294\";\n}\n.fa-percent:before {\n  content: \"\\F295\";\n}\n.fa-gitlab:before {\n  content: \"\\F296\";\n}\n.fa-wpbeginner:before {\n  content: \"\\F297\";\n}\n.fa-wpforms:before {\n  content: \"\\F298\";\n}\n.fa-envira:before {\n  content: \"\\F299\";\n}\n.fa-universal-access:before {\n  content: \"\\F29A\";\n}\n.fa-wheelchair-alt:before {\n  content: \"\\F29B\";\n}\n.fa-question-circle-o:before {\n  content: \"\\F29C\";\n}\n.fa-blind:before {\n  content: \"\\F29D\";\n}\n.fa-audio-description:before {\n  content: \"\\F29E\";\n}\n.fa-volume-control-phone:before {\n  content: \"\\F2A0\";\n}\n.fa-braille:before {\n  content: \"\\F2A1\";\n}\n.fa-assistive-listening-systems:before {\n  content: \"\\F2A2\";\n}\n.fa-asl-interpreting:before,\n.fa-american-sign-language-interpreting:before {\n  content: \"\\F2A3\";\n}\n.fa-deafness:before,\n.fa-hard-of-hearing:before,\n.fa-deaf:before {\n  content: \"\\F2A4\";\n}\n.fa-glide:before {\n  content: \"\\F2A5\";\n}\n.fa-glide-g:before {\n  content: \"\\F2A6\";\n}\n.fa-signing:before,\n.fa-sign-language:before {\n  content: \"\\F2A7\";\n}\n.fa-low-vision:before {\n  content: \"\\F2A8\";\n}\n.fa-viadeo:before {\n  content: \"\\F2A9\";\n}\n.fa-viadeo-square:before {\n  content: \"\\F2AA\";\n}\n.fa-snapchat:before {\n  content: \"\\F2AB\";\n}\n.fa-snapchat-ghost:before {\n  content: \"\\F2AC\";\n}\n.fa-snapchat-square:before {\n  content: \"\\F2AD\";\n}\n.fa-pied-piper:before {\n  content: \"\\F2AE\";\n}\n.fa-first-order:before {\n  content: \"\\F2B0\";\n}\n.fa-yoast:before {\n  content: \"\\F2B1\";\n}\n.fa-themeisle:before {\n  content: \"\\F2B2\";\n}\n.fa-google-plus-circle:before,\n.fa-google-plus-official:before {\n  content: \"\\F2B3\";\n}\n.fa-fa:before,\n.fa-font-awesome:before {\n  content: \"\\F2B4\";\n}\n.fa-handshake-o:before {\n  content: \"\\F2B5\";\n}\n.fa-envelope-open:before {\n  content: \"\\F2B6\";\n}\n.fa-envelope-open-o:before {\n  content: \"\\F2B7\";\n}\n.fa-linode:before {\n  content: \"\\F2B8\";\n}\n.fa-address-book:before {\n  content: \"\\F2B9\";\n}\n.fa-address-book-o:before {\n  content: \"\\F2BA\";\n}\n.fa-vcard:before,\n.fa-address-card:before {\n  content: \"\\F2BB\";\n}\n.fa-vcard-o:before,\n.fa-address-card-o:before {\n  content: \"\\F2BC\";\n}\n.fa-user-circle:before {\n  content: \"\\F2BD\";\n}\n.fa-user-circle-o:before {\n  content: \"\\F2BE\";\n}\n.fa-user-o:before {\n  content: \"\\F2C0\";\n}\n.fa-id-badge:before {\n  content: \"\\F2C1\";\n}\n.fa-drivers-license:before,\n.fa-id-card:before {\n  content: \"\\F2C2\";\n}\n.fa-drivers-license-o:before,\n.fa-id-card-o:before {\n  content: \"\\F2C3\";\n}\n.fa-quora:before {\n  content: \"\\F2C4\";\n}\n.fa-free-code-camp:before {\n  content: \"\\F2C5\";\n}\n.fa-telegram:before {\n  content: \"\\F2C6\";\n}\n.fa-thermometer-4:before,\n.fa-thermometer:before,\n.fa-thermometer-full:before {\n  content: \"\\F2C7\";\n}\n.fa-thermometer-3:before,\n.fa-thermometer-three-quarters:before {\n  content: \"\\F2C8\";\n}\n.fa-thermometer-2:before,\n.fa-thermometer-half:before {\n  content: \"\\F2C9\";\n}\n.fa-thermometer-1:before,\n.fa-thermometer-quarter:before {\n  content: \"\\F2CA\";\n}\n.fa-thermometer-0:before,\n.fa-thermometer-empty:before {\n  content: \"\\F2CB\";\n}\n.fa-shower:before {\n  content: \"\\F2CC\";\n}\n.fa-bathtub:before,\n.fa-s15:before,\n.fa-bath:before {\n  content: \"\\F2CD\";\n}\n.fa-podcast:before {\n  content: \"\\F2CE\";\n}\n.fa-window-maximize:before {\n  content: \"\\F2D0\";\n}\n.fa-window-minimize:before {\n  content: \"\\F2D1\";\n}\n.fa-window-restore:before {\n  content: \"\\F2D2\";\n}\n.fa-times-rectangle:before,\n.fa-window-close:before {\n  content: \"\\F2D3\";\n}\n.fa-times-rectangle-o:before,\n.fa-window-close-o:before {\n  content: \"\\F2D4\";\n}\n.fa-bandcamp:before {\n  content: \"\\F2D5\";\n}\n.fa-grav:before {\n  content: \"\\F2D6\";\n}\n.fa-etsy:before {\n  content: \"\\F2D7\";\n}\n.fa-imdb:before {\n  content: \"\\F2D8\";\n}\n.fa-ravelry:before {\n  content: \"\\F2D9\";\n}\n.fa-eercast:before {\n  content: \"\\F2DA\";\n}\n.fa-microchip:before {\n  content: \"\\F2DB\";\n}\n.fa-snowflake-o:before {\n  content: \"\\F2DC\";\n}\n.fa-superpowers:before {\n  content: \"\\F2DD\";\n}\n.fa-wpexplorer:before {\n  content: \"\\F2DE\";\n}\n.fa-meetup:before {\n  content: \"\\F2E0\";\n}\n.sr-only {\n  position: absolute;\n  width: 1px;\n  height: 1px;\n  padding: 0;\n  margin: -1px;\n  overflow: hidden;\n  clip: rect(0, 0, 0, 0);\n  border: 0;\n}\n.sr-only-focusable:active,\n.sr-only-focusable:focus {\n  position: static;\n  width: auto;\n  height: auto;\n  margin: 0;\n  overflow: visible;\n  clip: auto;\n}\n", ""]);

	// exports


/***/ }),
/* 8 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__.p + "674f50d287a8c48dc19ba404d20fe713.eot";

/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__.p + "674f50d287a8c48dc19ba404d20fe713.eot";

/***/ }),
/* 10 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__.p + "af7ae505a9eed503f8b8e6982036873e.woff2";

/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__.p + "fee66e712a8a08eef5805a46892932ad.woff";

/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__.p + "b06871f281fee6b241d60582ae9369b9.ttf";

/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__.p + "912ec66d7572ff821749319396470bde.svg";

/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

	// style-loader: Adds some css to the DOM by adding a <style> tag

	// load the styles
	var content = __webpack_require__(15);
	if(typeof content === 'string') content = [[module.id, content, '']];
	// add the styles to the DOM
	var update = __webpack_require__(5)(content, {});
	if(content.locals) module.exports = content.locals;
	// Hot Module Replacement
	if(false) {
		// When the styles change, update the <style> tags
		if(!content.locals) {
			module.hot.accept("!!../../node_modules/css-loader/index.js!./playground.css", function() {
				var newContent = require("!!../../node_modules/css-loader/index.js!./playground.css");
				if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];
				update(newContent);
			});
		}
		// When the module is disposed, remove the <style> tags
		module.hot.dispose(function() { update(); });
	}

/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

	exports = module.exports = __webpack_require__(4)();
	// imports


	// module
	exports.push([module.id, "body {\n\n}\n\n.navbar {\n    margin-bottom: 0;\n}\n\n.jumbotron {\n    padding-top: 6rem;\n    padding-bottom: 6rem;\n    margin-bottom: 0;\n    background-color: #fff;\n}\n\n.jumbotron p:last-child {\n    margin-bottom: 0;\n}\n\n.jumbotron-heading {\n    font-weight: 300;\n}\n\n.jumbotron .container {\n    max-width: 80rem;\n}\n\n.card {\n    padding: 0.75rem;\n    margin-bottom: 2rem;\n    border: 0;\n    background-color: #f5f5f5;\n}\n\n.card-text {\n    font-size: 85%;\n}\n\nfooter {\n    padding-top: 3rem;\n    padding-bottom: 3rem;\n}\n\nfooter p {\n    margin-bottom: .25rem;\n}\n\n.iconic {\n    width: 140px;\n    height: 140px;\n    background-color: #eceeef;\n    border-radius: 100%;\n    text-align: center;\n    vertical-align: middle;\n    display: table-cell;\n}", ""]);

	// exports


/***/ }),
/* 16 */
/***/ (function(module, exports, __webpack_require__) {

	module.exports = __webpack_require__.p + "index.html";

/***/ }),
/* 17 */
/***/ (function(module, exports) {

	
	(function() {
	'use strict';

	function F2(fun)
	{
	  function wrapper(a) { return function(b) { return fun(a,b); }; }
	  wrapper.arity = 2;
	  wrapper.func = fun;
	  return wrapper;
	}

	function F3(fun)
	{
	  function wrapper(a) {
	    return function(b) { return function(c) { return fun(a, b, c); }; };
	  }
	  wrapper.arity = 3;
	  wrapper.func = fun;
	  return wrapper;
	}

	function F4(fun)
	{
	  function wrapper(a) { return function(b) { return function(c) {
	    return function(d) { return fun(a, b, c, d); }; }; };
	  }
	  wrapper.arity = 4;
	  wrapper.func = fun;
	  return wrapper;
	}

	function F5(fun)
	{
	  function wrapper(a) { return function(b) { return function(c) {
	    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
	  }
	  wrapper.arity = 5;
	  wrapper.func = fun;
	  return wrapper;
	}

	function F6(fun)
	{
	  function wrapper(a) { return function(b) { return function(c) {
	    return function(d) { return function(e) { return function(f) {
	    return fun(a, b, c, d, e, f); }; }; }; }; };
	  }
	  wrapper.arity = 6;
	  wrapper.func = fun;
	  return wrapper;
	}

	function F7(fun)
	{
	  function wrapper(a) { return function(b) { return function(c) {
	    return function(d) { return function(e) { return function(f) {
	    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
	  }
	  wrapper.arity = 7;
	  wrapper.func = fun;
	  return wrapper;
	}

	function F8(fun)
	{
	  function wrapper(a) { return function(b) { return function(c) {
	    return function(d) { return function(e) { return function(f) {
	    return function(g) { return function(h) {
	    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
	  }
	  wrapper.arity = 8;
	  wrapper.func = fun;
	  return wrapper;
	}

	function F9(fun)
	{
	  function wrapper(a) { return function(b) { return function(c) {
	    return function(d) { return function(e) { return function(f) {
	    return function(g) { return function(h) { return function(i) {
	    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
	  }
	  wrapper.arity = 9;
	  wrapper.func = fun;
	  return wrapper;
	}

	function A2(fun, a, b)
	{
	  return fun.arity === 2
	    ? fun.func(a, b)
	    : fun(a)(b);
	}
	function A3(fun, a, b, c)
	{
	  return fun.arity === 3
	    ? fun.func(a, b, c)
	    : fun(a)(b)(c);
	}
	function A4(fun, a, b, c, d)
	{
	  return fun.arity === 4
	    ? fun.func(a, b, c, d)
	    : fun(a)(b)(c)(d);
	}
	function A5(fun, a, b, c, d, e)
	{
	  return fun.arity === 5
	    ? fun.func(a, b, c, d, e)
	    : fun(a)(b)(c)(d)(e);
	}
	function A6(fun, a, b, c, d, e, f)
	{
	  return fun.arity === 6
	    ? fun.func(a, b, c, d, e, f)
	    : fun(a)(b)(c)(d)(e)(f);
	}
	function A7(fun, a, b, c, d, e, f, g)
	{
	  return fun.arity === 7
	    ? fun.func(a, b, c, d, e, f, g)
	    : fun(a)(b)(c)(d)(e)(f)(g);
	}
	function A8(fun, a, b, c, d, e, f, g, h)
	{
	  return fun.arity === 8
	    ? fun.func(a, b, c, d, e, f, g, h)
	    : fun(a)(b)(c)(d)(e)(f)(g)(h);
	}
	function A9(fun, a, b, c, d, e, f, g, h, i)
	{
	  return fun.arity === 9
	    ? fun.func(a, b, c, d, e, f, g, h, i)
	    : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
	}

	//import Native.List //

	var _elm_lang$core$Native_Array = function() {

	// A RRB-Tree has two distinct data types.
	// Leaf -> "height"  is always 0
	//         "table"   is an array of elements
	// Node -> "height"  is always greater than 0
	//         "table"   is an array of child nodes
	//         "lengths" is an array of accumulated lengths of the child nodes

	// M is the maximal table size. 32 seems fast. E is the allowed increase
	// of search steps when concatting to find an index. Lower values will
	// decrease balancing, but will increase search steps.
	var M = 32;
	var E = 2;

	// An empty array.
	var empty = {
		ctor: '_Array',
		height: 0,
		table: []
	};


	function get(i, array)
	{
		if (i < 0 || i >= length(array))
		{
			throw new Error(
				'Index ' + i + ' is out of range. Check the length of ' +
				'your array first or use getMaybe or getWithDefault.');
		}
		return unsafeGet(i, array);
	}


	function unsafeGet(i, array)
	{
		for (var x = array.height; x > 0; x--)
		{
			var slot = i >> (x * 5);
			while (array.lengths[slot] <= i)
			{
				slot++;
			}
			if (slot > 0)
			{
				i -= array.lengths[slot - 1];
			}
			array = array.table[slot];
		}
		return array.table[i];
	}


	// Sets the value at the index i. Only the nodes leading to i will get
	// copied and updated.
	function set(i, item, array)
	{
		if (i < 0 || length(array) <= i)
		{
			return array;
		}
		return unsafeSet(i, item, array);
	}


	function unsafeSet(i, item, array)
	{
		array = nodeCopy(array);

		if (array.height === 0)
		{
			array.table[i] = item;
		}
		else
		{
			var slot = getSlot(i, array);
			if (slot > 0)
			{
				i -= array.lengths[slot - 1];
			}
			array.table[slot] = unsafeSet(i, item, array.table[slot]);
		}
		return array;
	}


	function initialize(len, f)
	{
		if (len <= 0)
		{
			return empty;
		}
		var h = Math.floor( Math.log(len) / Math.log(M) );
		return initialize_(f, h, 0, len);
	}

	function initialize_(f, h, from, to)
	{
		if (h === 0)
		{
			var table = new Array((to - from) % (M + 1));
			for (var i = 0; i < table.length; i++)
			{
			  table[i] = f(from + i);
			}
			return {
				ctor: '_Array',
				height: 0,
				table: table
			};
		}

		var step = Math.pow(M, h);
		var table = new Array(Math.ceil((to - from) / step));
		var lengths = new Array(table.length);
		for (var i = 0; i < table.length; i++)
		{
			table[i] = initialize_(f, h - 1, from + (i * step), Math.min(from + ((i + 1) * step), to));
			lengths[i] = length(table[i]) + (i > 0 ? lengths[i-1] : 0);
		}
		return {
			ctor: '_Array',
			height: h,
			table: table,
			lengths: lengths
		};
	}

	function fromList(list)
	{
		if (list.ctor === '[]')
		{
			return empty;
		}

		// Allocate M sized blocks (table) and write list elements to it.
		var table = new Array(M);
		var nodes = [];
		var i = 0;

		while (list.ctor !== '[]')
		{
			table[i] = list._0;
			list = list._1;
			i++;

			// table is full, so we can push a leaf containing it into the
			// next node.
			if (i === M)
			{
				var leaf = {
					ctor: '_Array',
					height: 0,
					table: table
				};
				fromListPush(leaf, nodes);
				table = new Array(M);
				i = 0;
			}
		}

		// Maybe there is something left on the table.
		if (i > 0)
		{
			var leaf = {
				ctor: '_Array',
				height: 0,
				table: table.splice(0, i)
			};
			fromListPush(leaf, nodes);
		}

		// Go through all of the nodes and eventually push them into higher nodes.
		for (var h = 0; h < nodes.length - 1; h++)
		{
			if (nodes[h].table.length > 0)
			{
				fromListPush(nodes[h], nodes);
			}
		}

		var head = nodes[nodes.length - 1];
		if (head.height > 0 && head.table.length === 1)
		{
			return head.table[0];
		}
		else
		{
			return head;
		}
	}

	// Push a node into a higher node as a child.
	function fromListPush(toPush, nodes)
	{
		var h = toPush.height;

		// Maybe the node on this height does not exist.
		if (nodes.length === h)
		{
			var node = {
				ctor: '_Array',
				height: h + 1,
				table: [],
				lengths: []
			};
			nodes.push(node);
		}

		nodes[h].table.push(toPush);
		var len = length(toPush);
		if (nodes[h].lengths.length > 0)
		{
			len += nodes[h].lengths[nodes[h].lengths.length - 1];
		}
		nodes[h].lengths.push(len);

		if (nodes[h].table.length === M)
		{
			fromListPush(nodes[h], nodes);
			nodes[h] = {
				ctor: '_Array',
				height: h + 1,
				table: [],
				lengths: []
			};
		}
	}

	// Pushes an item via push_ to the bottom right of a tree.
	function push(item, a)
	{
		var pushed = push_(item, a);
		if (pushed !== null)
		{
			return pushed;
		}

		var newTree = create(item, a.height);
		return siblise(a, newTree);
	}

	// Recursively tries to push an item to the bottom-right most
	// tree possible. If there is no space left for the item,
	// null will be returned.
	function push_(item, a)
	{
		// Handle resursion stop at leaf level.
		if (a.height === 0)
		{
			if (a.table.length < M)
			{
				var newA = {
					ctor: '_Array',
					height: 0,
					table: a.table.slice()
				};
				newA.table.push(item);
				return newA;
			}
			else
			{
			  return null;
			}
		}

		// Recursively push
		var pushed = push_(item, botRight(a));

		// There was space in the bottom right tree, so the slot will
		// be updated.
		if (pushed !== null)
		{
			var newA = nodeCopy(a);
			newA.table[newA.table.length - 1] = pushed;
			newA.lengths[newA.lengths.length - 1]++;
			return newA;
		}

		// When there was no space left, check if there is space left
		// for a new slot with a tree which contains only the item
		// at the bottom.
		if (a.table.length < M)
		{
			var newSlot = create(item, a.height - 1);
			var newA = nodeCopy(a);
			newA.table.push(newSlot);
			newA.lengths.push(newA.lengths[newA.lengths.length - 1] + length(newSlot));
			return newA;
		}
		else
		{
			return null;
		}
	}

	// Converts an array into a list of elements.
	function toList(a)
	{
		return toList_(_elm_lang$core$Native_List.Nil, a);
	}

	function toList_(list, a)
	{
		for (var i = a.table.length - 1; i >= 0; i--)
		{
			list =
				a.height === 0
					? _elm_lang$core$Native_List.Cons(a.table[i], list)
					: toList_(list, a.table[i]);
		}
		return list;
	}

	// Maps a function over the elements of an array.
	function map(f, a)
	{
		var newA = {
			ctor: '_Array',
			height: a.height,
			table: new Array(a.table.length)
		};
		if (a.height > 0)
		{
			newA.lengths = a.lengths;
		}
		for (var i = 0; i < a.table.length; i++)
		{
			newA.table[i] =
				a.height === 0
					? f(a.table[i])
					: map(f, a.table[i]);
		}
		return newA;
	}

	// Maps a function over the elements with their index as first argument.
	function indexedMap(f, a)
	{
		return indexedMap_(f, a, 0);
	}

	function indexedMap_(f, a, from)
	{
		var newA = {
			ctor: '_Array',
			height: a.height,
			table: new Array(a.table.length)
		};
		if (a.height > 0)
		{
			newA.lengths = a.lengths;
		}
		for (var i = 0; i < a.table.length; i++)
		{
			newA.table[i] =
				a.height === 0
					? A2(f, from + i, a.table[i])
					: indexedMap_(f, a.table[i], i == 0 ? from : from + a.lengths[i - 1]);
		}
		return newA;
	}

	function foldl(f, b, a)
	{
		if (a.height === 0)
		{
			for (var i = 0; i < a.table.length; i++)
			{
				b = A2(f, a.table[i], b);
			}
		}
		else
		{
			for (var i = 0; i < a.table.length; i++)
			{
				b = foldl(f, b, a.table[i]);
			}
		}
		return b;
	}

	function foldr(f, b, a)
	{
		if (a.height === 0)
		{
			for (var i = a.table.length; i--; )
			{
				b = A2(f, a.table[i], b);
			}
		}
		else
		{
			for (var i = a.table.length; i--; )
			{
				b = foldr(f, b, a.table[i]);
			}
		}
		return b;
	}

	// TODO: currently, it slices the right, then the left. This can be
	// optimized.
	function slice(from, to, a)
	{
		if (from < 0)
		{
			from += length(a);
		}
		if (to < 0)
		{
			to += length(a);
		}
		return sliceLeft(from, sliceRight(to, a));
	}

	function sliceRight(to, a)
	{
		if (to === length(a))
		{
			return a;
		}

		// Handle leaf level.
		if (a.height === 0)
		{
			var newA = { ctor:'_Array', height:0 };
			newA.table = a.table.slice(0, to);
			return newA;
		}

		// Slice the right recursively.
		var right = getSlot(to, a);
		var sliced = sliceRight(to - (right > 0 ? a.lengths[right - 1] : 0), a.table[right]);

		// Maybe the a node is not even needed, as sliced contains the whole slice.
		if (right === 0)
		{
			return sliced;
		}

		// Create new node.
		var newA = {
			ctor: '_Array',
			height: a.height,
			table: a.table.slice(0, right),
			lengths: a.lengths.slice(0, right)
		};
		if (sliced.table.length > 0)
		{
			newA.table[right] = sliced;
			newA.lengths[right] = length(sliced) + (right > 0 ? newA.lengths[right - 1] : 0);
		}
		return newA;
	}

	function sliceLeft(from, a)
	{
		if (from === 0)
		{
			return a;
		}

		// Handle leaf level.
		if (a.height === 0)
		{
			var newA = { ctor:'_Array', height:0 };
			newA.table = a.table.slice(from, a.table.length + 1);
			return newA;
		}

		// Slice the left recursively.
		var left = getSlot(from, a);
		var sliced = sliceLeft(from - (left > 0 ? a.lengths[left - 1] : 0), a.table[left]);

		// Maybe the a node is not even needed, as sliced contains the whole slice.
		if (left === a.table.length - 1)
		{
			return sliced;
		}

		// Create new node.
		var newA = {
			ctor: '_Array',
			height: a.height,
			table: a.table.slice(left, a.table.length + 1),
			lengths: new Array(a.table.length - left)
		};
		newA.table[0] = sliced;
		var len = 0;
		for (var i = 0; i < newA.table.length; i++)
		{
			len += length(newA.table[i]);
			newA.lengths[i] = len;
		}

		return newA;
	}

	// Appends two trees.
	function append(a,b)
	{
		if (a.table.length === 0)
		{
			return b;
		}
		if (b.table.length === 0)
		{
			return a;
		}

		var c = append_(a, b);

		// Check if both nodes can be crunshed together.
		if (c[0].table.length + c[1].table.length <= M)
		{
			if (c[0].table.length === 0)
			{
				return c[1];
			}
			if (c[1].table.length === 0)
			{
				return c[0];
			}

			// Adjust .table and .lengths
			c[0].table = c[0].table.concat(c[1].table);
			if (c[0].height > 0)
			{
				var len = length(c[0]);
				for (var i = 0; i < c[1].lengths.length; i++)
				{
					c[1].lengths[i] += len;
				}
				c[0].lengths = c[0].lengths.concat(c[1].lengths);
			}

			return c[0];
		}

		if (c[0].height > 0)
		{
			var toRemove = calcToRemove(a, b);
			if (toRemove > E)
			{
				c = shuffle(c[0], c[1], toRemove);
			}
		}

		return siblise(c[0], c[1]);
	}

	// Returns an array of two nodes; right and left. One node _may_ be empty.
	function append_(a, b)
	{
		if (a.height === 0 && b.height === 0)
		{
			return [a, b];
		}

		if (a.height !== 1 || b.height !== 1)
		{
			if (a.height === b.height)
			{
				a = nodeCopy(a);
				b = nodeCopy(b);
				var appended = append_(botRight(a), botLeft(b));

				insertRight(a, appended[1]);
				insertLeft(b, appended[0]);
			}
			else if (a.height > b.height)
			{
				a = nodeCopy(a);
				var appended = append_(botRight(a), b);

				insertRight(a, appended[0]);
				b = parentise(appended[1], appended[1].height + 1);
			}
			else
			{
				b = nodeCopy(b);
				var appended = append_(a, botLeft(b));

				var left = appended[0].table.length === 0 ? 0 : 1;
				var right = left === 0 ? 1 : 0;
				insertLeft(b, appended[left]);
				a = parentise(appended[right], appended[right].height + 1);
			}
		}

		// Check if balancing is needed and return based on that.
		if (a.table.length === 0 || b.table.length === 0)
		{
			return [a, b];
		}

		var toRemove = calcToRemove(a, b);
		if (toRemove <= E)
		{
			return [a, b];
		}
		return shuffle(a, b, toRemove);
	}

	// Helperfunctions for append_. Replaces a child node at the side of the parent.
	function insertRight(parent, node)
	{
		var index = parent.table.length - 1;
		parent.table[index] = node;
		parent.lengths[index] = length(node);
		parent.lengths[index] += index > 0 ? parent.lengths[index - 1] : 0;
	}

	function insertLeft(parent, node)
	{
		if (node.table.length > 0)
		{
			parent.table[0] = node;
			parent.lengths[0] = length(node);

			var len = length(parent.table[0]);
			for (var i = 1; i < parent.lengths.length; i++)
			{
				len += length(parent.table[i]);
				parent.lengths[i] = len;
			}
		}
		else
		{
			parent.table.shift();
			for (var i = 1; i < parent.lengths.length; i++)
			{
				parent.lengths[i] = parent.lengths[i] - parent.lengths[0];
			}
			parent.lengths.shift();
		}
	}

	// Returns the extra search steps for E. Refer to the paper.
	function calcToRemove(a, b)
	{
		var subLengths = 0;
		for (var i = 0; i < a.table.length; i++)
		{
			subLengths += a.table[i].table.length;
		}
		for (var i = 0; i < b.table.length; i++)
		{
			subLengths += b.table[i].table.length;
		}

		var toRemove = a.table.length + b.table.length;
		return toRemove - (Math.floor((subLengths - 1) / M) + 1);
	}

	// get2, set2 and saveSlot are helpers for accessing elements over two arrays.
	function get2(a, b, index)
	{
		return index < a.length
			? a[index]
			: b[index - a.length];
	}

	function set2(a, b, index, value)
	{
		if (index < a.length)
		{
			a[index] = value;
		}
		else
		{
			b[index - a.length] = value;
		}
	}

	function saveSlot(a, b, index, slot)
	{
		set2(a.table, b.table, index, slot);

		var l = (index === 0 || index === a.lengths.length)
			? 0
			: get2(a.lengths, a.lengths, index - 1);

		set2(a.lengths, b.lengths, index, l + length(slot));
	}

	// Creates a node or leaf with a given length at their arrays for perfomance.
	// Is only used by shuffle.
	function createNode(h, length)
	{
		if (length < 0)
		{
			length = 0;
		}
		var a = {
			ctor: '_Array',
			height: h,
			table: new Array(length)
		};
		if (h > 0)
		{
			a.lengths = new Array(length);
		}
		return a;
	}

	// Returns an array of two balanced nodes.
	function shuffle(a, b, toRemove)
	{
		var newA = createNode(a.height, Math.min(M, a.table.length + b.table.length - toRemove));
		var newB = createNode(a.height, newA.table.length - (a.table.length + b.table.length - toRemove));

		// Skip the slots with size M. More precise: copy the slot references
		// to the new node
		var read = 0;
		while (get2(a.table, b.table, read).table.length % M === 0)
		{
			set2(newA.table, newB.table, read, get2(a.table, b.table, read));
			set2(newA.lengths, newB.lengths, read, get2(a.lengths, b.lengths, read));
			read++;
		}

		// Pulling items from left to right, caching in a slot before writing
		// it into the new nodes.
		var write = read;
		var slot = new createNode(a.height - 1, 0);
		var from = 0;

		// If the current slot is still containing data, then there will be at
		// least one more write, so we do not break this loop yet.
		while (read - write - (slot.table.length > 0 ? 1 : 0) < toRemove)
		{
			// Find out the max possible items for copying.
			var source = get2(a.table, b.table, read);
			var to = Math.min(M - slot.table.length, source.table.length);

			// Copy and adjust size table.
			slot.table = slot.table.concat(source.table.slice(from, to));
			if (slot.height > 0)
			{
				var len = slot.lengths.length;
				for (var i = len; i < len + to - from; i++)
				{
					slot.lengths[i] = length(slot.table[i]);
					slot.lengths[i] += (i > 0 ? slot.lengths[i - 1] : 0);
				}
			}

			from += to;

			// Only proceed to next slots[i] if the current one was
			// fully copied.
			if (source.table.length <= to)
			{
				read++; from = 0;
			}

			// Only create a new slot if the current one is filled up.
			if (slot.table.length === M)
			{
				saveSlot(newA, newB, write, slot);
				slot = createNode(a.height - 1, 0);
				write++;
			}
		}

		// Cleanup after the loop. Copy the last slot into the new nodes.
		if (slot.table.length > 0)
		{
			saveSlot(newA, newB, write, slot);
			write++;
		}

		// Shift the untouched slots to the left
		while (read < a.table.length + b.table.length )
		{
			saveSlot(newA, newB, write, get2(a.table, b.table, read));
			read++;
			write++;
		}

		return [newA, newB];
	}

	// Navigation functions
	function botRight(a)
	{
		return a.table[a.table.length - 1];
	}
	function botLeft(a)
	{
		return a.table[0];
	}

	// Copies a node for updating. Note that you should not use this if
	// only updating only one of "table" or "lengths" for performance reasons.
	function nodeCopy(a)
	{
		var newA = {
			ctor: '_Array',
			height: a.height,
			table: a.table.slice()
		};
		if (a.height > 0)
		{
			newA.lengths = a.lengths.slice();
		}
		return newA;
	}

	// Returns how many items are in the tree.
	function length(array)
	{
		if (array.height === 0)
		{
			return array.table.length;
		}
		else
		{
			return array.lengths[array.lengths.length - 1];
		}
	}

	// Calculates in which slot of "table" the item probably is, then
	// find the exact slot via forward searching in  "lengths". Returns the index.
	function getSlot(i, a)
	{
		var slot = i >> (5 * a.height);
		while (a.lengths[slot] <= i)
		{
			slot++;
		}
		return slot;
	}

	// Recursively creates a tree with a given height containing
	// only the given item.
	function create(item, h)
	{
		if (h === 0)
		{
			return {
				ctor: '_Array',
				height: 0,
				table: [item]
			};
		}
		return {
			ctor: '_Array',
			height: h,
			table: [create(item, h - 1)],
			lengths: [1]
		};
	}

	// Recursively creates a tree that contains the given tree.
	function parentise(tree, h)
	{
		if (h === tree.height)
		{
			return tree;
		}

		return {
			ctor: '_Array',
			height: h,
			table: [parentise(tree, h - 1)],
			lengths: [length(tree)]
		};
	}

	// Emphasizes blood brotherhood beneath two trees.
	function siblise(a, b)
	{
		return {
			ctor: '_Array',
			height: a.height + 1,
			table: [a, b],
			lengths: [length(a), length(a) + length(b)]
		};
	}

	function toJSArray(a)
	{
		var jsArray = new Array(length(a));
		toJSArray_(jsArray, 0, a);
		return jsArray;
	}

	function toJSArray_(jsArray, i, a)
	{
		for (var t = 0; t < a.table.length; t++)
		{
			if (a.height === 0)
			{
				jsArray[i + t] = a.table[t];
			}
			else
			{
				var inc = t === 0 ? 0 : a.lengths[t - 1];
				toJSArray_(jsArray, i + inc, a.table[t]);
			}
		}
	}

	function fromJSArray(jsArray)
	{
		if (jsArray.length === 0)
		{
			return empty;
		}
		var h = Math.floor(Math.log(jsArray.length) / Math.log(M));
		return fromJSArray_(jsArray, h, 0, jsArray.length);
	}

	function fromJSArray_(jsArray, h, from, to)
	{
		if (h === 0)
		{
			return {
				ctor: '_Array',
				height: 0,
				table: jsArray.slice(from, to)
			};
		}

		var step = Math.pow(M, h);
		var table = new Array(Math.ceil((to - from) / step));
		var lengths = new Array(table.length);
		for (var i = 0; i < table.length; i++)
		{
			table[i] = fromJSArray_(jsArray, h - 1, from + (i * step), Math.min(from + ((i + 1) * step), to));
			lengths[i] = length(table[i]) + (i > 0 ? lengths[i - 1] : 0);
		}
		return {
			ctor: '_Array',
			height: h,
			table: table,
			lengths: lengths
		};
	}

	return {
		empty: empty,
		fromList: fromList,
		toList: toList,
		initialize: F2(initialize),
		append: F2(append),
		push: F2(push),
		slice: F3(slice),
		get: F2(get),
		set: F3(set),
		map: F2(map),
		indexedMap: F2(indexedMap),
		foldl: F3(foldl),
		foldr: F3(foldr),
		length: length,

		toJSArray: toJSArray,
		fromJSArray: fromJSArray
	};

	}();
	//import Native.Utils //

	var _elm_lang$core$Native_Basics = function() {

	function div(a, b)
	{
		return (a / b) | 0;
	}
	function rem(a, b)
	{
		return a % b;
	}
	function mod(a, b)
	{
		if (b === 0)
		{
			throw new Error('Cannot perform mod 0. Division by zero error.');
		}
		var r = a % b;
		var m = a === 0 ? 0 : (b > 0 ? (a >= 0 ? r : r + b) : -mod(-a, -b));

		return m === b ? 0 : m;
	}
	function logBase(base, n)
	{
		return Math.log(n) / Math.log(base);
	}
	function negate(n)
	{
		return -n;
	}
	function abs(n)
	{
		return n < 0 ? -n : n;
	}

	function min(a, b)
	{
		return _elm_lang$core$Native_Utils.cmp(a, b) < 0 ? a : b;
	}
	function max(a, b)
	{
		return _elm_lang$core$Native_Utils.cmp(a, b) > 0 ? a : b;
	}
	function clamp(lo, hi, n)
	{
		return _elm_lang$core$Native_Utils.cmp(n, lo) < 0
			? lo
			: _elm_lang$core$Native_Utils.cmp(n, hi) > 0
				? hi
				: n;
	}

	var ord = ['LT', 'EQ', 'GT'];

	function compare(x, y)
	{
		return { ctor: ord[_elm_lang$core$Native_Utils.cmp(x, y) + 1] };
	}

	function xor(a, b)
	{
		return a !== b;
	}
	function not(b)
	{
		return !b;
	}
	function isInfinite(n)
	{
		return n === Infinity || n === -Infinity;
	}

	function truncate(n)
	{
		return n | 0;
	}

	function degrees(d)
	{
		return d * Math.PI / 180;
	}
	function turns(t)
	{
		return 2 * Math.PI * t;
	}
	function fromPolar(point)
	{
		var r = point._0;
		var t = point._1;
		return _elm_lang$core$Native_Utils.Tuple2(r * Math.cos(t), r * Math.sin(t));
	}
	function toPolar(point)
	{
		var x = point._0;
		var y = point._1;
		return _elm_lang$core$Native_Utils.Tuple2(Math.sqrt(x * x + y * y), Math.atan2(y, x));
	}

	return {
		div: F2(div),
		rem: F2(rem),
		mod: F2(mod),

		pi: Math.PI,
		e: Math.E,
		cos: Math.cos,
		sin: Math.sin,
		tan: Math.tan,
		acos: Math.acos,
		asin: Math.asin,
		atan: Math.atan,
		atan2: F2(Math.atan2),

		degrees: degrees,
		turns: turns,
		fromPolar: fromPolar,
		toPolar: toPolar,

		sqrt: Math.sqrt,
		logBase: F2(logBase),
		negate: negate,
		abs: abs,
		min: F2(min),
		max: F2(max),
		clamp: F3(clamp),
		compare: F2(compare),

		xor: F2(xor),
		not: not,

		truncate: truncate,
		ceiling: Math.ceil,
		floor: Math.floor,
		round: Math.round,
		toFloat: function(x) { return x; },
		isNaN: isNaN,
		isInfinite: isInfinite
	};

	}();
	//import //

	var _elm_lang$core$Native_Utils = function() {

	// COMPARISONS

	function eq(x, y)
	{
		var stack = [];
		var isEqual = eqHelp(x, y, 0, stack);
		var pair;
		while (isEqual && (pair = stack.pop()))
		{
			isEqual = eqHelp(pair.x, pair.y, 0, stack);
		}
		return isEqual;
	}


	function eqHelp(x, y, depth, stack)
	{
		if (depth > 100)
		{
			stack.push({ x: x, y: y });
			return true;
		}

		if (x === y)
		{
			return true;
		}

		if (typeof x !== 'object')
		{
			if (typeof x === 'function')
			{
				throw new Error(
					'Trying to use `(==)` on functions. There is no way to know if functions are "the same" in the Elm sense.'
					+ ' Read more about this at http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#=='
					+ ' which describes why it is this way and what the better version will look like.'
				);
			}
			return false;
		}

		if (x === null || y === null)
		{
			return false
		}

		if (x instanceof Date)
		{
			return x.getTime() === y.getTime();
		}

		if (!('ctor' in x))
		{
			for (var key in x)
			{
				if (!eqHelp(x[key], y[key], depth + 1, stack))
				{
					return false;
				}
			}
			return true;
		}

		// convert Dicts and Sets to lists
		if (x.ctor === 'RBNode_elm_builtin' || x.ctor === 'RBEmpty_elm_builtin')
		{
			x = _elm_lang$core$Dict$toList(x);
			y = _elm_lang$core$Dict$toList(y);
		}
		if (x.ctor === 'Set_elm_builtin')
		{
			x = _elm_lang$core$Set$toList(x);
			y = _elm_lang$core$Set$toList(y);
		}

		// check if lists are equal without recursion
		if (x.ctor === '::')
		{
			var a = x;
			var b = y;
			while (a.ctor === '::' && b.ctor === '::')
			{
				if (!eqHelp(a._0, b._0, depth + 1, stack))
				{
					return false;
				}
				a = a._1;
				b = b._1;
			}
			return a.ctor === b.ctor;
		}

		// check if Arrays are equal
		if (x.ctor === '_Array')
		{
			var xs = _elm_lang$core$Native_Array.toJSArray(x);
			var ys = _elm_lang$core$Native_Array.toJSArray(y);
			if (xs.length !== ys.length)
			{
				return false;
			}
			for (var i = 0; i < xs.length; i++)
			{
				if (!eqHelp(xs[i], ys[i], depth + 1, stack))
				{
					return false;
				}
			}
			return true;
		}

		if (!eqHelp(x.ctor, y.ctor, depth + 1, stack))
		{
			return false;
		}

		for (var key in x)
		{
			if (!eqHelp(x[key], y[key], depth + 1, stack))
			{
				return false;
			}
		}
		return true;
	}

	// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
	// the particular integer values assigned to LT, EQ, and GT.

	var LT = -1, EQ = 0, GT = 1;

	function cmp(x, y)
	{
		if (typeof x !== 'object')
		{
			return x === y ? EQ : x < y ? LT : GT;
		}

		if (x instanceof String)
		{
			var a = x.valueOf();
			var b = y.valueOf();
			return a === b ? EQ : a < b ? LT : GT;
		}

		if (x.ctor === '::' || x.ctor === '[]')
		{
			while (x.ctor === '::' && y.ctor === '::')
			{
				var ord = cmp(x._0, y._0);
				if (ord !== EQ)
				{
					return ord;
				}
				x = x._1;
				y = y._1;
			}
			return x.ctor === y.ctor ? EQ : x.ctor === '[]' ? LT : GT;
		}

		if (x.ctor.slice(0, 6) === '_Tuple')
		{
			var ord;
			var n = x.ctor.slice(6) - 0;
			var err = 'cannot compare tuples with more than 6 elements.';
			if (n === 0) return EQ;
			if (n >= 1) { ord = cmp(x._0, y._0); if (ord !== EQ) return ord;
			if (n >= 2) { ord = cmp(x._1, y._1); if (ord !== EQ) return ord;
			if (n >= 3) { ord = cmp(x._2, y._2); if (ord !== EQ) return ord;
			if (n >= 4) { ord = cmp(x._3, y._3); if (ord !== EQ) return ord;
			if (n >= 5) { ord = cmp(x._4, y._4); if (ord !== EQ) return ord;
			if (n >= 6) { ord = cmp(x._5, y._5); if (ord !== EQ) return ord;
			if (n >= 7) throw new Error('Comparison error: ' + err); } } } } } }
			return EQ;
		}

		throw new Error(
			'Comparison error: comparison is only defined on ints, '
			+ 'floats, times, chars, strings, lists of comparable values, '
			+ 'and tuples of comparable values.'
		);
	}


	// COMMON VALUES

	var Tuple0 = {
		ctor: '_Tuple0'
	};

	function Tuple2(x, y)
	{
		return {
			ctor: '_Tuple2',
			_0: x,
			_1: y
		};
	}

	function chr(c)
	{
		return new String(c);
	}


	// GUID

	var count = 0;
	function guid(_)
	{
		return count++;
	}


	// RECORDS

	function update(oldRecord, updatedFields)
	{
		var newRecord = {};

		for (var key in oldRecord)
		{
			newRecord[key] = oldRecord[key];
		}

		for (var key in updatedFields)
		{
			newRecord[key] = updatedFields[key];
		}

		return newRecord;
	}


	//// LIST STUFF ////

	var Nil = { ctor: '[]' };

	function Cons(hd, tl)
	{
		return {
			ctor: '::',
			_0: hd,
			_1: tl
		};
	}

	function append(xs, ys)
	{
		// append Strings
		if (typeof xs === 'string')
		{
			return xs + ys;
		}

		// append Lists
		if (xs.ctor === '[]')
		{
			return ys;
		}
		var root = Cons(xs._0, Nil);
		var curr = root;
		xs = xs._1;
		while (xs.ctor !== '[]')
		{
			curr._1 = Cons(xs._0, Nil);
			xs = xs._1;
			curr = curr._1;
		}
		curr._1 = ys;
		return root;
	}


	// CRASHES

	function crash(moduleName, region)
	{
		return function(message) {
			throw new Error(
				'Ran into a `Debug.crash` in module `' + moduleName + '` ' + regionToString(region) + '\n'
				+ 'The message provided by the code author is:\n\n    '
				+ message
			);
		};
	}

	function crashCase(moduleName, region, value)
	{
		return function(message) {
			throw new Error(
				'Ran into a `Debug.crash` in module `' + moduleName + '`\n\n'
				+ 'This was caused by the `case` expression ' + regionToString(region) + '.\n'
				+ 'One of the branches ended with a crash and the following value got through:\n\n    ' + toString(value) + '\n\n'
				+ 'The message provided by the code author is:\n\n    '
				+ message
			);
		};
	}

	function regionToString(region)
	{
		if (region.start.line == region.end.line)
		{
			return 'on line ' + region.start.line;
		}
		return 'between lines ' + region.start.line + ' and ' + region.end.line;
	}


	// TO STRING

	function toString(v)
	{
		var type = typeof v;
		if (type === 'function')
		{
			return '<function>';
		}

		if (type === 'boolean')
		{
			return v ? 'True' : 'False';
		}

		if (type === 'number')
		{
			return v + '';
		}

		if (v instanceof String)
		{
			return '\'' + addSlashes(v, true) + '\'';
		}

		if (type === 'string')
		{
			return '"' + addSlashes(v, false) + '"';
		}

		if (v === null)
		{
			return 'null';
		}

		if (type === 'object' && 'ctor' in v)
		{
			var ctorStarter = v.ctor.substring(0, 5);

			if (ctorStarter === '_Tupl')
			{
				var output = [];
				for (var k in v)
				{
					if (k === 'ctor') continue;
					output.push(toString(v[k]));
				}
				return '(' + output.join(',') + ')';
			}

			if (ctorStarter === '_Task')
			{
				return '<task>'
			}

			if (v.ctor === '_Array')
			{
				var list = _elm_lang$core$Array$toList(v);
				return 'Array.fromList ' + toString(list);
			}

			if (v.ctor === '<decoder>')
			{
				return '<decoder>';
			}

			if (v.ctor === '_Process')
			{
				return '<process:' + v.id + '>';
			}

			if (v.ctor === '::')
			{
				var output = '[' + toString(v._0);
				v = v._1;
				while (v.ctor === '::')
				{
					output += ',' + toString(v._0);
					v = v._1;
				}
				return output + ']';
			}

			if (v.ctor === '[]')
			{
				return '[]';
			}

			if (v.ctor === 'Set_elm_builtin')
			{
				return 'Set.fromList ' + toString(_elm_lang$core$Set$toList(v));
			}

			if (v.ctor === 'RBNode_elm_builtin' || v.ctor === 'RBEmpty_elm_builtin')
			{
				return 'Dict.fromList ' + toString(_elm_lang$core$Dict$toList(v));
			}

			var output = '';
			for (var i in v)
			{
				if (i === 'ctor') continue;
				var str = toString(v[i]);
				var c0 = str[0];
				var parenless = c0 === '{' || c0 === '(' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
				output += ' ' + (parenless ? str : '(' + str + ')');
			}
			return v.ctor + output;
		}

		if (type === 'object')
		{
			if (v instanceof Date)
			{
				return '<' + v.toString() + '>';
			}

			if (v.elm_web_socket)
			{
				return '<websocket>';
			}

			var output = [];
			for (var k in v)
			{
				output.push(k + ' = ' + toString(v[k]));
			}
			if (output.length === 0)
			{
				return '{}';
			}
			return '{ ' + output.join(', ') + ' }';
		}

		return '<internal structure>';
	}

	function addSlashes(str, isChar)
	{
		var s = str.replace(/\\/g, '\\\\')
				  .replace(/\n/g, '\\n')
				  .replace(/\t/g, '\\t')
				  .replace(/\r/g, '\\r')
				  .replace(/\v/g, '\\v')
				  .replace(/\0/g, '\\0');
		if (isChar)
		{
			return s.replace(/\'/g, '\\\'');
		}
		else
		{
			return s.replace(/\"/g, '\\"');
		}
	}


	return {
		eq: eq,
		cmp: cmp,
		Tuple0: Tuple0,
		Tuple2: Tuple2,
		chr: chr,
		update: update,
		guid: guid,

		append: F2(append),

		crash: crash,
		crashCase: crashCase,

		toString: toString
	};

	}();
	var _elm_lang$core$Basics$never = function (_p0) {
		never:
		while (true) {
			var _p1 = _p0;
			var _v1 = _p1._0;
			_p0 = _v1;
			continue never;
		}
	};
	var _elm_lang$core$Basics$uncurry = F2(
		function (f, _p2) {
			var _p3 = _p2;
			return A2(f, _p3._0, _p3._1);
		});
	var _elm_lang$core$Basics$curry = F3(
		function (f, a, b) {
			return f(
				{ctor: '_Tuple2', _0: a, _1: b});
		});
	var _elm_lang$core$Basics$flip = F3(
		function (f, b, a) {
			return A2(f, a, b);
		});
	var _elm_lang$core$Basics$always = F2(
		function (a, _p4) {
			return a;
		});
	var _elm_lang$core$Basics$identity = function (x) {
		return x;
	};
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['<|'] = F2(
		function (f, x) {
			return f(x);
		});
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['|>'] = F2(
		function (x, f) {
			return f(x);
		});
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['>>'] = F3(
		function (f, g, x) {
			return g(
				f(x));
		});
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['<<'] = F3(
		function (g, f, x) {
			return g(
				f(x));
		});
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['++'] = _elm_lang$core$Native_Utils.append;
	var _elm_lang$core$Basics$toString = _elm_lang$core$Native_Utils.toString;
	var _elm_lang$core$Basics$isInfinite = _elm_lang$core$Native_Basics.isInfinite;
	var _elm_lang$core$Basics$isNaN = _elm_lang$core$Native_Basics.isNaN;
	var _elm_lang$core$Basics$toFloat = _elm_lang$core$Native_Basics.toFloat;
	var _elm_lang$core$Basics$ceiling = _elm_lang$core$Native_Basics.ceiling;
	var _elm_lang$core$Basics$floor = _elm_lang$core$Native_Basics.floor;
	var _elm_lang$core$Basics$truncate = _elm_lang$core$Native_Basics.truncate;
	var _elm_lang$core$Basics$round = _elm_lang$core$Native_Basics.round;
	var _elm_lang$core$Basics$not = _elm_lang$core$Native_Basics.not;
	var _elm_lang$core$Basics$xor = _elm_lang$core$Native_Basics.xor;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['||'] = _elm_lang$core$Native_Basics.or;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['&&'] = _elm_lang$core$Native_Basics.and;
	var _elm_lang$core$Basics$max = _elm_lang$core$Native_Basics.max;
	var _elm_lang$core$Basics$min = _elm_lang$core$Native_Basics.min;
	var _elm_lang$core$Basics$compare = _elm_lang$core$Native_Basics.compare;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['>='] = _elm_lang$core$Native_Basics.ge;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['<='] = _elm_lang$core$Native_Basics.le;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['>'] = _elm_lang$core$Native_Basics.gt;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['<'] = _elm_lang$core$Native_Basics.lt;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['/='] = _elm_lang$core$Native_Basics.neq;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['=='] = _elm_lang$core$Native_Basics.eq;
	var _elm_lang$core$Basics$e = _elm_lang$core$Native_Basics.e;
	var _elm_lang$core$Basics$pi = _elm_lang$core$Native_Basics.pi;
	var _elm_lang$core$Basics$clamp = _elm_lang$core$Native_Basics.clamp;
	var _elm_lang$core$Basics$logBase = _elm_lang$core$Native_Basics.logBase;
	var _elm_lang$core$Basics$abs = _elm_lang$core$Native_Basics.abs;
	var _elm_lang$core$Basics$negate = _elm_lang$core$Native_Basics.negate;
	var _elm_lang$core$Basics$sqrt = _elm_lang$core$Native_Basics.sqrt;
	var _elm_lang$core$Basics$atan2 = _elm_lang$core$Native_Basics.atan2;
	var _elm_lang$core$Basics$atan = _elm_lang$core$Native_Basics.atan;
	var _elm_lang$core$Basics$asin = _elm_lang$core$Native_Basics.asin;
	var _elm_lang$core$Basics$acos = _elm_lang$core$Native_Basics.acos;
	var _elm_lang$core$Basics$tan = _elm_lang$core$Native_Basics.tan;
	var _elm_lang$core$Basics$sin = _elm_lang$core$Native_Basics.sin;
	var _elm_lang$core$Basics$cos = _elm_lang$core$Native_Basics.cos;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['^'] = _elm_lang$core$Native_Basics.exp;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['%'] = _elm_lang$core$Native_Basics.mod;
	var _elm_lang$core$Basics$rem = _elm_lang$core$Native_Basics.rem;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['//'] = _elm_lang$core$Native_Basics.div;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['/'] = _elm_lang$core$Native_Basics.floatDiv;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['*'] = _elm_lang$core$Native_Basics.mul;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['-'] = _elm_lang$core$Native_Basics.sub;
	var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
	_elm_lang$core$Basics_ops['+'] = _elm_lang$core$Native_Basics.add;
	var _elm_lang$core$Basics$toPolar = _elm_lang$core$Native_Basics.toPolar;
	var _elm_lang$core$Basics$fromPolar = _elm_lang$core$Native_Basics.fromPolar;
	var _elm_lang$core$Basics$turns = _elm_lang$core$Native_Basics.turns;
	var _elm_lang$core$Basics$degrees = _elm_lang$core$Native_Basics.degrees;
	var _elm_lang$core$Basics$radians = function (t) {
		return t;
	};
	var _elm_lang$core$Basics$GT = {ctor: 'GT'};
	var _elm_lang$core$Basics$EQ = {ctor: 'EQ'};
	var _elm_lang$core$Basics$LT = {ctor: 'LT'};
	var _elm_lang$core$Basics$JustOneMore = function (a) {
		return {ctor: 'JustOneMore', _0: a};
	};

	var _elm_lang$core$Maybe$withDefault = F2(
		function ($default, maybe) {
			var _p0 = maybe;
			if (_p0.ctor === 'Just') {
				return _p0._0;
			} else {
				return $default;
			}
		});
	var _elm_lang$core$Maybe$Nothing = {ctor: 'Nothing'};
	var _elm_lang$core$Maybe$andThen = F2(
		function (callback, maybeValue) {
			var _p1 = maybeValue;
			if (_p1.ctor === 'Just') {
				return callback(_p1._0);
			} else {
				return _elm_lang$core$Maybe$Nothing;
			}
		});
	var _elm_lang$core$Maybe$Just = function (a) {
		return {ctor: 'Just', _0: a};
	};
	var _elm_lang$core$Maybe$map = F2(
		function (f, maybe) {
			var _p2 = maybe;
			if (_p2.ctor === 'Just') {
				return _elm_lang$core$Maybe$Just(
					f(_p2._0));
			} else {
				return _elm_lang$core$Maybe$Nothing;
			}
		});
	var _elm_lang$core$Maybe$map2 = F3(
		function (func, ma, mb) {
			var _p3 = {ctor: '_Tuple2', _0: ma, _1: mb};
			if (((_p3.ctor === '_Tuple2') && (_p3._0.ctor === 'Just')) && (_p3._1.ctor === 'Just')) {
				return _elm_lang$core$Maybe$Just(
					A2(func, _p3._0._0, _p3._1._0));
			} else {
				return _elm_lang$core$Maybe$Nothing;
			}
		});
	var _elm_lang$core$Maybe$map3 = F4(
		function (func, ma, mb, mc) {
			var _p4 = {ctor: '_Tuple3', _0: ma, _1: mb, _2: mc};
			if ((((_p4.ctor === '_Tuple3') && (_p4._0.ctor === 'Just')) && (_p4._1.ctor === 'Just')) && (_p4._2.ctor === 'Just')) {
				return _elm_lang$core$Maybe$Just(
					A3(func, _p4._0._0, _p4._1._0, _p4._2._0));
			} else {
				return _elm_lang$core$Maybe$Nothing;
			}
		});
	var _elm_lang$core$Maybe$map4 = F5(
		function (func, ma, mb, mc, md) {
			var _p5 = {ctor: '_Tuple4', _0: ma, _1: mb, _2: mc, _3: md};
			if (((((_p5.ctor === '_Tuple4') && (_p5._0.ctor === 'Just')) && (_p5._1.ctor === 'Just')) && (_p5._2.ctor === 'Just')) && (_p5._3.ctor === 'Just')) {
				return _elm_lang$core$Maybe$Just(
					A4(func, _p5._0._0, _p5._1._0, _p5._2._0, _p5._3._0));
			} else {
				return _elm_lang$core$Maybe$Nothing;
			}
		});
	var _elm_lang$core$Maybe$map5 = F6(
		function (func, ma, mb, mc, md, me) {
			var _p6 = {ctor: '_Tuple5', _0: ma, _1: mb, _2: mc, _3: md, _4: me};
			if ((((((_p6.ctor === '_Tuple5') && (_p6._0.ctor === 'Just')) && (_p6._1.ctor === 'Just')) && (_p6._2.ctor === 'Just')) && (_p6._3.ctor === 'Just')) && (_p6._4.ctor === 'Just')) {
				return _elm_lang$core$Maybe$Just(
					A5(func, _p6._0._0, _p6._1._0, _p6._2._0, _p6._3._0, _p6._4._0));
			} else {
				return _elm_lang$core$Maybe$Nothing;
			}
		});

	//import Native.Utils //

	var _elm_lang$core$Native_List = function() {

	var Nil = { ctor: '[]' };

	function Cons(hd, tl)
	{
		return { ctor: '::', _0: hd, _1: tl };
	}

	function fromArray(arr)
	{
		var out = Nil;
		for (var i = arr.length; i--; )
		{
			out = Cons(arr[i], out);
		}
		return out;
	}

	function toArray(xs)
	{
		var out = [];
		while (xs.ctor !== '[]')
		{
			out.push(xs._0);
			xs = xs._1;
		}
		return out;
	}

	function foldr(f, b, xs)
	{
		var arr = toArray(xs);
		var acc = b;
		for (var i = arr.length; i--; )
		{
			acc = A2(f, arr[i], acc);
		}
		return acc;
	}

	function map2(f, xs, ys)
	{
		var arr = [];
		while (xs.ctor !== '[]' && ys.ctor !== '[]')
		{
			arr.push(A2(f, xs._0, ys._0));
			xs = xs._1;
			ys = ys._1;
		}
		return fromArray(arr);
	}

	function map3(f, xs, ys, zs)
	{
		var arr = [];
		while (xs.ctor !== '[]' && ys.ctor !== '[]' && zs.ctor !== '[]')
		{
			arr.push(A3(f, xs._0, ys._0, zs._0));
			xs = xs._1;
			ys = ys._1;
			zs = zs._1;
		}
		return fromArray(arr);
	}

	function map4(f, ws, xs, ys, zs)
	{
		var arr = [];
		while (   ws.ctor !== '[]'
			   && xs.ctor !== '[]'
			   && ys.ctor !== '[]'
			   && zs.ctor !== '[]')
		{
			arr.push(A4(f, ws._0, xs._0, ys._0, zs._0));
			ws = ws._1;
			xs = xs._1;
			ys = ys._1;
			zs = zs._1;
		}
		return fromArray(arr);
	}

	function map5(f, vs, ws, xs, ys, zs)
	{
		var arr = [];
		while (   vs.ctor !== '[]'
			   && ws.ctor !== '[]'
			   && xs.ctor !== '[]'
			   && ys.ctor !== '[]'
			   && zs.ctor !== '[]')
		{
			arr.push(A5(f, vs._0, ws._0, xs._0, ys._0, zs._0));
			vs = vs._1;
			ws = ws._1;
			xs = xs._1;
			ys = ys._1;
			zs = zs._1;
		}
		return fromArray(arr);
	}

	function sortBy(f, xs)
	{
		return fromArray(toArray(xs).sort(function(a, b) {
			return _elm_lang$core$Native_Utils.cmp(f(a), f(b));
		}));
	}

	function sortWith(f, xs)
	{
		return fromArray(toArray(xs).sort(function(a, b) {
			var ord = f(a)(b).ctor;
			return ord === 'EQ' ? 0 : ord === 'LT' ? -1 : 1;
		}));
	}

	return {
		Nil: Nil,
		Cons: Cons,
		cons: F2(Cons),
		toArray: toArray,
		fromArray: fromArray,

		foldr: F3(foldr),

		map2: F3(map2),
		map3: F4(map3),
		map4: F5(map4),
		map5: F6(map5),
		sortBy: F2(sortBy),
		sortWith: F2(sortWith)
	};

	}();
	var _elm_lang$core$List$sortWith = _elm_lang$core$Native_List.sortWith;
	var _elm_lang$core$List$sortBy = _elm_lang$core$Native_List.sortBy;
	var _elm_lang$core$List$sort = function (xs) {
		return A2(_elm_lang$core$List$sortBy, _elm_lang$core$Basics$identity, xs);
	};
	var _elm_lang$core$List$singleton = function (value) {
		return {
			ctor: '::',
			_0: value,
			_1: {ctor: '[]'}
		};
	};
	var _elm_lang$core$List$drop = F2(
		function (n, list) {
			drop:
			while (true) {
				if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
					return list;
				} else {
					var _p0 = list;
					if (_p0.ctor === '[]') {
						return list;
					} else {
						var _v1 = n - 1,
							_v2 = _p0._1;
						n = _v1;
						list = _v2;
						continue drop;
					}
				}
			}
		});
	var _elm_lang$core$List$map5 = _elm_lang$core$Native_List.map5;
	var _elm_lang$core$List$map4 = _elm_lang$core$Native_List.map4;
	var _elm_lang$core$List$map3 = _elm_lang$core$Native_List.map3;
	var _elm_lang$core$List$map2 = _elm_lang$core$Native_List.map2;
	var _elm_lang$core$List$any = F2(
		function (isOkay, list) {
			any:
			while (true) {
				var _p1 = list;
				if (_p1.ctor === '[]') {
					return false;
				} else {
					if (isOkay(_p1._0)) {
						return true;
					} else {
						var _v4 = isOkay,
							_v5 = _p1._1;
						isOkay = _v4;
						list = _v5;
						continue any;
					}
				}
			}
		});
	var _elm_lang$core$List$all = F2(
		function (isOkay, list) {
			return !A2(
				_elm_lang$core$List$any,
				function (_p2) {
					return !isOkay(_p2);
				},
				list);
		});
	var _elm_lang$core$List$foldr = _elm_lang$core$Native_List.foldr;
	var _elm_lang$core$List$foldl = F3(
		function (func, acc, list) {
			foldl:
			while (true) {
				var _p3 = list;
				if (_p3.ctor === '[]') {
					return acc;
				} else {
					var _v7 = func,
						_v8 = A2(func, _p3._0, acc),
						_v9 = _p3._1;
					func = _v7;
					acc = _v8;
					list = _v9;
					continue foldl;
				}
			}
		});
	var _elm_lang$core$List$length = function (xs) {
		return A3(
			_elm_lang$core$List$foldl,
			F2(
				function (_p4, i) {
					return i + 1;
				}),
			0,
			xs);
	};
	var _elm_lang$core$List$sum = function (numbers) {
		return A3(
			_elm_lang$core$List$foldl,
			F2(
				function (x, y) {
					return x + y;
				}),
			0,
			numbers);
	};
	var _elm_lang$core$List$product = function (numbers) {
		return A3(
			_elm_lang$core$List$foldl,
			F2(
				function (x, y) {
					return x * y;
				}),
			1,
			numbers);
	};
	var _elm_lang$core$List$maximum = function (list) {
		var _p5 = list;
		if (_p5.ctor === '::') {
			return _elm_lang$core$Maybe$Just(
				A3(_elm_lang$core$List$foldl, _elm_lang$core$Basics$max, _p5._0, _p5._1));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	};
	var _elm_lang$core$List$minimum = function (list) {
		var _p6 = list;
		if (_p6.ctor === '::') {
			return _elm_lang$core$Maybe$Just(
				A3(_elm_lang$core$List$foldl, _elm_lang$core$Basics$min, _p6._0, _p6._1));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	};
	var _elm_lang$core$List$member = F2(
		function (x, xs) {
			return A2(
				_elm_lang$core$List$any,
				function (a) {
					return _elm_lang$core$Native_Utils.eq(a, x);
				},
				xs);
		});
	var _elm_lang$core$List$isEmpty = function (xs) {
		var _p7 = xs;
		if (_p7.ctor === '[]') {
			return true;
		} else {
			return false;
		}
	};
	var _elm_lang$core$List$tail = function (list) {
		var _p8 = list;
		if (_p8.ctor === '::') {
			return _elm_lang$core$Maybe$Just(_p8._1);
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	};
	var _elm_lang$core$List$head = function (list) {
		var _p9 = list;
		if (_p9.ctor === '::') {
			return _elm_lang$core$Maybe$Just(_p9._0);
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	};
	var _elm_lang$core$List_ops = _elm_lang$core$List_ops || {};
	_elm_lang$core$List_ops['::'] = _elm_lang$core$Native_List.cons;
	var _elm_lang$core$List$map = F2(
		function (f, xs) {
			return A3(
				_elm_lang$core$List$foldr,
				F2(
					function (x, acc) {
						return {
							ctor: '::',
							_0: f(x),
							_1: acc
						};
					}),
				{ctor: '[]'},
				xs);
		});
	var _elm_lang$core$List$filter = F2(
		function (pred, xs) {
			var conditionalCons = F2(
				function (front, back) {
					return pred(front) ? {ctor: '::', _0: front, _1: back} : back;
				});
			return A3(
				_elm_lang$core$List$foldr,
				conditionalCons,
				{ctor: '[]'},
				xs);
		});
	var _elm_lang$core$List$maybeCons = F3(
		function (f, mx, xs) {
			var _p10 = f(mx);
			if (_p10.ctor === 'Just') {
				return {ctor: '::', _0: _p10._0, _1: xs};
			} else {
				return xs;
			}
		});
	var _elm_lang$core$List$filterMap = F2(
		function (f, xs) {
			return A3(
				_elm_lang$core$List$foldr,
				_elm_lang$core$List$maybeCons(f),
				{ctor: '[]'},
				xs);
		});
	var _elm_lang$core$List$reverse = function (list) {
		return A3(
			_elm_lang$core$List$foldl,
			F2(
				function (x, y) {
					return {ctor: '::', _0: x, _1: y};
				}),
			{ctor: '[]'},
			list);
	};
	var _elm_lang$core$List$scanl = F3(
		function (f, b, xs) {
			var scan1 = F2(
				function (x, accAcc) {
					var _p11 = accAcc;
					if (_p11.ctor === '::') {
						return {
							ctor: '::',
							_0: A2(f, x, _p11._0),
							_1: accAcc
						};
					} else {
						return {ctor: '[]'};
					}
				});
			return _elm_lang$core$List$reverse(
				A3(
					_elm_lang$core$List$foldl,
					scan1,
					{
						ctor: '::',
						_0: b,
						_1: {ctor: '[]'}
					},
					xs));
		});
	var _elm_lang$core$List$append = F2(
		function (xs, ys) {
			var _p12 = ys;
			if (_p12.ctor === '[]') {
				return xs;
			} else {
				return A3(
					_elm_lang$core$List$foldr,
					F2(
						function (x, y) {
							return {ctor: '::', _0: x, _1: y};
						}),
					ys,
					xs);
			}
		});
	var _elm_lang$core$List$concat = function (lists) {
		return A3(
			_elm_lang$core$List$foldr,
			_elm_lang$core$List$append,
			{ctor: '[]'},
			lists);
	};
	var _elm_lang$core$List$concatMap = F2(
		function (f, list) {
			return _elm_lang$core$List$concat(
				A2(_elm_lang$core$List$map, f, list));
		});
	var _elm_lang$core$List$partition = F2(
		function (pred, list) {
			var step = F2(
				function (x, _p13) {
					var _p14 = _p13;
					var _p16 = _p14._0;
					var _p15 = _p14._1;
					return pred(x) ? {
						ctor: '_Tuple2',
						_0: {ctor: '::', _0: x, _1: _p16},
						_1: _p15
					} : {
						ctor: '_Tuple2',
						_0: _p16,
						_1: {ctor: '::', _0: x, _1: _p15}
					};
				});
			return A3(
				_elm_lang$core$List$foldr,
				step,
				{
					ctor: '_Tuple2',
					_0: {ctor: '[]'},
					_1: {ctor: '[]'}
				},
				list);
		});
	var _elm_lang$core$List$unzip = function (pairs) {
		var step = F2(
			function (_p18, _p17) {
				var _p19 = _p18;
				var _p20 = _p17;
				return {
					ctor: '_Tuple2',
					_0: {ctor: '::', _0: _p19._0, _1: _p20._0},
					_1: {ctor: '::', _0: _p19._1, _1: _p20._1}
				};
			});
		return A3(
			_elm_lang$core$List$foldr,
			step,
			{
				ctor: '_Tuple2',
				_0: {ctor: '[]'},
				_1: {ctor: '[]'}
			},
			pairs);
	};
	var _elm_lang$core$List$intersperse = F2(
		function (sep, xs) {
			var _p21 = xs;
			if (_p21.ctor === '[]') {
				return {ctor: '[]'};
			} else {
				var step = F2(
					function (x, rest) {
						return {
							ctor: '::',
							_0: sep,
							_1: {ctor: '::', _0: x, _1: rest}
						};
					});
				var spersed = A3(
					_elm_lang$core$List$foldr,
					step,
					{ctor: '[]'},
					_p21._1);
				return {ctor: '::', _0: _p21._0, _1: spersed};
			}
		});
	var _elm_lang$core$List$takeReverse = F3(
		function (n, list, taken) {
			takeReverse:
			while (true) {
				if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
					return taken;
				} else {
					var _p22 = list;
					if (_p22.ctor === '[]') {
						return taken;
					} else {
						var _v23 = n - 1,
							_v24 = _p22._1,
							_v25 = {ctor: '::', _0: _p22._0, _1: taken};
						n = _v23;
						list = _v24;
						taken = _v25;
						continue takeReverse;
					}
				}
			}
		});
	var _elm_lang$core$List$takeTailRec = F2(
		function (n, list) {
			return _elm_lang$core$List$reverse(
				A3(
					_elm_lang$core$List$takeReverse,
					n,
					list,
					{ctor: '[]'}));
		});
	var _elm_lang$core$List$takeFast = F3(
		function (ctr, n, list) {
			if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
				return {ctor: '[]'};
			} else {
				var _p23 = {ctor: '_Tuple2', _0: n, _1: list};
				_v26_5:
				do {
					_v26_1:
					do {
						if (_p23.ctor === '_Tuple2') {
							if (_p23._1.ctor === '[]') {
								return list;
							} else {
								if (_p23._1._1.ctor === '::') {
									switch (_p23._0) {
										case 1:
											break _v26_1;
										case 2:
											return {
												ctor: '::',
												_0: _p23._1._0,
												_1: {
													ctor: '::',
													_0: _p23._1._1._0,
													_1: {ctor: '[]'}
												}
											};
										case 3:
											if (_p23._1._1._1.ctor === '::') {
												return {
													ctor: '::',
													_0: _p23._1._0,
													_1: {
														ctor: '::',
														_0: _p23._1._1._0,
														_1: {
															ctor: '::',
															_0: _p23._1._1._1._0,
															_1: {ctor: '[]'}
														}
													}
												};
											} else {
												break _v26_5;
											}
										default:
											if ((_p23._1._1._1.ctor === '::') && (_p23._1._1._1._1.ctor === '::')) {
												var _p28 = _p23._1._1._1._0;
												var _p27 = _p23._1._1._0;
												var _p26 = _p23._1._0;
												var _p25 = _p23._1._1._1._1._0;
												var _p24 = _p23._1._1._1._1._1;
												return (_elm_lang$core$Native_Utils.cmp(ctr, 1000) > 0) ? {
													ctor: '::',
													_0: _p26,
													_1: {
														ctor: '::',
														_0: _p27,
														_1: {
															ctor: '::',
															_0: _p28,
															_1: {
																ctor: '::',
																_0: _p25,
																_1: A2(_elm_lang$core$List$takeTailRec, n - 4, _p24)
															}
														}
													}
												} : {
													ctor: '::',
													_0: _p26,
													_1: {
														ctor: '::',
														_0: _p27,
														_1: {
															ctor: '::',
															_0: _p28,
															_1: {
																ctor: '::',
																_0: _p25,
																_1: A3(_elm_lang$core$List$takeFast, ctr + 1, n - 4, _p24)
															}
														}
													}
												};
											} else {
												break _v26_5;
											}
									}
								} else {
									if (_p23._0 === 1) {
										break _v26_1;
									} else {
										break _v26_5;
									}
								}
							}
						} else {
							break _v26_5;
						}
					} while(false);
					return {
						ctor: '::',
						_0: _p23._1._0,
						_1: {ctor: '[]'}
					};
				} while(false);
				return list;
			}
		});
	var _elm_lang$core$List$take = F2(
		function (n, list) {
			return A3(_elm_lang$core$List$takeFast, 0, n, list);
		});
	var _elm_lang$core$List$repeatHelp = F3(
		function (result, n, value) {
			repeatHelp:
			while (true) {
				if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
					return result;
				} else {
					var _v27 = {ctor: '::', _0: value, _1: result},
						_v28 = n - 1,
						_v29 = value;
					result = _v27;
					n = _v28;
					value = _v29;
					continue repeatHelp;
				}
			}
		});
	var _elm_lang$core$List$repeat = F2(
		function (n, value) {
			return A3(
				_elm_lang$core$List$repeatHelp,
				{ctor: '[]'},
				n,
				value);
		});
	var _elm_lang$core$List$rangeHelp = F3(
		function (lo, hi, list) {
			rangeHelp:
			while (true) {
				if (_elm_lang$core$Native_Utils.cmp(lo, hi) < 1) {
					var _v30 = lo,
						_v31 = hi - 1,
						_v32 = {ctor: '::', _0: hi, _1: list};
					lo = _v30;
					hi = _v31;
					list = _v32;
					continue rangeHelp;
				} else {
					return list;
				}
			}
		});
	var _elm_lang$core$List$range = F2(
		function (lo, hi) {
			return A3(
				_elm_lang$core$List$rangeHelp,
				lo,
				hi,
				{ctor: '[]'});
		});
	var _elm_lang$core$List$indexedMap = F2(
		function (f, xs) {
			return A3(
				_elm_lang$core$List$map2,
				f,
				A2(
					_elm_lang$core$List$range,
					0,
					_elm_lang$core$List$length(xs) - 1),
				xs);
		});

	var _elm_lang$core$Array$append = _elm_lang$core$Native_Array.append;
	var _elm_lang$core$Array$length = _elm_lang$core$Native_Array.length;
	var _elm_lang$core$Array$isEmpty = function (array) {
		return _elm_lang$core$Native_Utils.eq(
			_elm_lang$core$Array$length(array),
			0);
	};
	var _elm_lang$core$Array$slice = _elm_lang$core$Native_Array.slice;
	var _elm_lang$core$Array$set = _elm_lang$core$Native_Array.set;
	var _elm_lang$core$Array$get = F2(
		function (i, array) {
			return ((_elm_lang$core$Native_Utils.cmp(0, i) < 1) && (_elm_lang$core$Native_Utils.cmp(
				i,
				_elm_lang$core$Native_Array.length(array)) < 0)) ? _elm_lang$core$Maybe$Just(
				A2(_elm_lang$core$Native_Array.get, i, array)) : _elm_lang$core$Maybe$Nothing;
		});
	var _elm_lang$core$Array$push = _elm_lang$core$Native_Array.push;
	var _elm_lang$core$Array$empty = _elm_lang$core$Native_Array.empty;
	var _elm_lang$core$Array$filter = F2(
		function (isOkay, arr) {
			var update = F2(
				function (x, xs) {
					return isOkay(x) ? A2(_elm_lang$core$Native_Array.push, x, xs) : xs;
				});
			return A3(_elm_lang$core$Native_Array.foldl, update, _elm_lang$core$Native_Array.empty, arr);
		});
	var _elm_lang$core$Array$foldr = _elm_lang$core$Native_Array.foldr;
	var _elm_lang$core$Array$foldl = _elm_lang$core$Native_Array.foldl;
	var _elm_lang$core$Array$indexedMap = _elm_lang$core$Native_Array.indexedMap;
	var _elm_lang$core$Array$map = _elm_lang$core$Native_Array.map;
	var _elm_lang$core$Array$toIndexedList = function (array) {
		return A3(
			_elm_lang$core$List$map2,
			F2(
				function (v0, v1) {
					return {ctor: '_Tuple2', _0: v0, _1: v1};
				}),
			A2(
				_elm_lang$core$List$range,
				0,
				_elm_lang$core$Native_Array.length(array) - 1),
			_elm_lang$core$Native_Array.toList(array));
	};
	var _elm_lang$core$Array$toList = _elm_lang$core$Native_Array.toList;
	var _elm_lang$core$Array$fromList = _elm_lang$core$Native_Array.fromList;
	var _elm_lang$core$Array$initialize = _elm_lang$core$Native_Array.initialize;
	var _elm_lang$core$Array$repeat = F2(
		function (n, e) {
			return A2(
				_elm_lang$core$Array$initialize,
				n,
				_elm_lang$core$Basics$always(e));
		});
	var _elm_lang$core$Array$Array = {ctor: 'Array'};

	//import Native.Utils //

	var _elm_lang$core$Native_Debug = function() {

	function log(tag, value)
	{
		var msg = tag + ': ' + _elm_lang$core$Native_Utils.toString(value);
		var process = process || {};
		if (process.stdout)
		{
			process.stdout.write(msg);
		}
		else
		{
			console.log(msg);
		}
		return value;
	}

	function crash(message)
	{
		throw new Error(message);
	}

	return {
		crash: crash,
		log: F2(log)
	};

	}();
	//import Maybe, Native.List, Native.Utils, Result //

	var _elm_lang$core$Native_String = function() {

	function isEmpty(str)
	{
		return str.length === 0;
	}
	function cons(chr, str)
	{
		return chr + str;
	}
	function uncons(str)
	{
		var hd = str[0];
		if (hd)
		{
			return _elm_lang$core$Maybe$Just(_elm_lang$core$Native_Utils.Tuple2(_elm_lang$core$Native_Utils.chr(hd), str.slice(1)));
		}
		return _elm_lang$core$Maybe$Nothing;
	}
	function append(a, b)
	{
		return a + b;
	}
	function concat(strs)
	{
		return _elm_lang$core$Native_List.toArray(strs).join('');
	}
	function length(str)
	{
		return str.length;
	}
	function map(f, str)
	{
		var out = str.split('');
		for (var i = out.length; i--; )
		{
			out[i] = f(_elm_lang$core$Native_Utils.chr(out[i]));
		}
		return out.join('');
	}
	function filter(pred, str)
	{
		return str.split('').map(_elm_lang$core$Native_Utils.chr).filter(pred).join('');
	}
	function reverse(str)
	{
		return str.split('').reverse().join('');
	}
	function foldl(f, b, str)
	{
		var len = str.length;
		for (var i = 0; i < len; ++i)
		{
			b = A2(f, _elm_lang$core$Native_Utils.chr(str[i]), b);
		}
		return b;
	}
	function foldr(f, b, str)
	{
		for (var i = str.length; i--; )
		{
			b = A2(f, _elm_lang$core$Native_Utils.chr(str[i]), b);
		}
		return b;
	}
	function split(sep, str)
	{
		return _elm_lang$core$Native_List.fromArray(str.split(sep));
	}
	function join(sep, strs)
	{
		return _elm_lang$core$Native_List.toArray(strs).join(sep);
	}
	function repeat(n, str)
	{
		var result = '';
		while (n > 0)
		{
			if (n & 1)
			{
				result += str;
			}
			n >>= 1, str += str;
		}
		return result;
	}
	function slice(start, end, str)
	{
		return str.slice(start, end);
	}
	function left(n, str)
	{
		return n < 1 ? '' : str.slice(0, n);
	}
	function right(n, str)
	{
		return n < 1 ? '' : str.slice(-n);
	}
	function dropLeft(n, str)
	{
		return n < 1 ? str : str.slice(n);
	}
	function dropRight(n, str)
	{
		return n < 1 ? str : str.slice(0, -n);
	}
	function pad(n, chr, str)
	{
		var half = (n - str.length) / 2;
		return repeat(Math.ceil(half), chr) + str + repeat(half | 0, chr);
	}
	function padRight(n, chr, str)
	{
		return str + repeat(n - str.length, chr);
	}
	function padLeft(n, chr, str)
	{
		return repeat(n - str.length, chr) + str;
	}

	function trim(str)
	{
		return str.trim();
	}
	function trimLeft(str)
	{
		return str.replace(/^\s+/, '');
	}
	function trimRight(str)
	{
		return str.replace(/\s+$/, '');
	}

	function words(str)
	{
		return _elm_lang$core$Native_List.fromArray(str.trim().split(/\s+/g));
	}
	function lines(str)
	{
		return _elm_lang$core$Native_List.fromArray(str.split(/\r\n|\r|\n/g));
	}

	function toUpper(str)
	{
		return str.toUpperCase();
	}
	function toLower(str)
	{
		return str.toLowerCase();
	}

	function any(pred, str)
	{
		for (var i = str.length; i--; )
		{
			if (pred(_elm_lang$core$Native_Utils.chr(str[i])))
			{
				return true;
			}
		}
		return false;
	}
	function all(pred, str)
	{
		for (var i = str.length; i--; )
		{
			if (!pred(_elm_lang$core$Native_Utils.chr(str[i])))
			{
				return false;
			}
		}
		return true;
	}

	function contains(sub, str)
	{
		return str.indexOf(sub) > -1;
	}
	function startsWith(sub, str)
	{
		return str.indexOf(sub) === 0;
	}
	function endsWith(sub, str)
	{
		return str.length >= sub.length &&
			str.lastIndexOf(sub) === str.length - sub.length;
	}
	function indexes(sub, str)
	{
		var subLen = sub.length;

		if (subLen < 1)
		{
			return _elm_lang$core$Native_List.Nil;
		}

		var i = 0;
		var is = [];

		while ((i = str.indexOf(sub, i)) > -1)
		{
			is.push(i);
			i = i + subLen;
		}

		return _elm_lang$core$Native_List.fromArray(is);
	}


	function toInt(s)
	{
		var len = s.length;

		// if empty
		if (len === 0)
		{
			return intErr(s);
		}

		// if hex
		var c = s[0];
		if (c === '0' && s[1] === 'x')
		{
			for (var i = 2; i < len; ++i)
			{
				var c = s[i];
				if (('0' <= c && c <= '9') || ('A' <= c && c <= 'F') || ('a' <= c && c <= 'f'))
				{
					continue;
				}
				return intErr(s);
			}
			return _elm_lang$core$Result$Ok(parseInt(s, 16));
		}

		// is decimal
		if (c > '9' || (c < '0' && c !== '-' && c !== '+'))
		{
			return intErr(s);
		}
		for (var i = 1; i < len; ++i)
		{
			var c = s[i];
			if (c < '0' || '9' < c)
			{
				return intErr(s);
			}
		}

		return _elm_lang$core$Result$Ok(parseInt(s, 10));
	}

	function intErr(s)
	{
		return _elm_lang$core$Result$Err("could not convert string '" + s + "' to an Int");
	}


	function toFloat(s)
	{
		// check if it is a hex, octal, or binary number
		if (s.length === 0 || /[\sxbo]/.test(s))
		{
			return floatErr(s);
		}
		var n = +s;
		// faster isNaN check
		return n === n ? _elm_lang$core$Result$Ok(n) : floatErr(s);
	}

	function floatErr(s)
	{
		return _elm_lang$core$Result$Err("could not convert string '" + s + "' to a Float");
	}


	function toList(str)
	{
		return _elm_lang$core$Native_List.fromArray(str.split('').map(_elm_lang$core$Native_Utils.chr));
	}
	function fromList(chars)
	{
		return _elm_lang$core$Native_List.toArray(chars).join('');
	}

	return {
		isEmpty: isEmpty,
		cons: F2(cons),
		uncons: uncons,
		append: F2(append),
		concat: concat,
		length: length,
		map: F2(map),
		filter: F2(filter),
		reverse: reverse,
		foldl: F3(foldl),
		foldr: F3(foldr),

		split: F2(split),
		join: F2(join),
		repeat: F2(repeat),

		slice: F3(slice),
		left: F2(left),
		right: F2(right),
		dropLeft: F2(dropLeft),
		dropRight: F2(dropRight),

		pad: F3(pad),
		padLeft: F3(padLeft),
		padRight: F3(padRight),

		trim: trim,
		trimLeft: trimLeft,
		trimRight: trimRight,

		words: words,
		lines: lines,

		toUpper: toUpper,
		toLower: toLower,

		any: F2(any),
		all: F2(all),

		contains: F2(contains),
		startsWith: F2(startsWith),
		endsWith: F2(endsWith),
		indexes: F2(indexes),

		toInt: toInt,
		toFloat: toFloat,
		toList: toList,
		fromList: fromList
	};

	}();

	//import Native.Utils //

	var _elm_lang$core$Native_Char = function() {

	return {
		fromCode: function(c) { return _elm_lang$core$Native_Utils.chr(String.fromCharCode(c)); },
		toCode: function(c) { return c.charCodeAt(0); },
		toUpper: function(c) { return _elm_lang$core$Native_Utils.chr(c.toUpperCase()); },
		toLower: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLowerCase()); },
		toLocaleUpper: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLocaleUpperCase()); },
		toLocaleLower: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLocaleLowerCase()); }
	};

	}();
	var _elm_lang$core$Char$fromCode = _elm_lang$core$Native_Char.fromCode;
	var _elm_lang$core$Char$toCode = _elm_lang$core$Native_Char.toCode;
	var _elm_lang$core$Char$toLocaleLower = _elm_lang$core$Native_Char.toLocaleLower;
	var _elm_lang$core$Char$toLocaleUpper = _elm_lang$core$Native_Char.toLocaleUpper;
	var _elm_lang$core$Char$toLower = _elm_lang$core$Native_Char.toLower;
	var _elm_lang$core$Char$toUpper = _elm_lang$core$Native_Char.toUpper;
	var _elm_lang$core$Char$isBetween = F3(
		function (low, high, $char) {
			var code = _elm_lang$core$Char$toCode($char);
			return (_elm_lang$core$Native_Utils.cmp(
				code,
				_elm_lang$core$Char$toCode(low)) > -1) && (_elm_lang$core$Native_Utils.cmp(
				code,
				_elm_lang$core$Char$toCode(high)) < 1);
		});
	var _elm_lang$core$Char$isUpper = A2(
		_elm_lang$core$Char$isBetween,
		_elm_lang$core$Native_Utils.chr('A'),
		_elm_lang$core$Native_Utils.chr('Z'));
	var _elm_lang$core$Char$isLower = A2(
		_elm_lang$core$Char$isBetween,
		_elm_lang$core$Native_Utils.chr('a'),
		_elm_lang$core$Native_Utils.chr('z'));
	var _elm_lang$core$Char$isDigit = A2(
		_elm_lang$core$Char$isBetween,
		_elm_lang$core$Native_Utils.chr('0'),
		_elm_lang$core$Native_Utils.chr('9'));
	var _elm_lang$core$Char$isOctDigit = A2(
		_elm_lang$core$Char$isBetween,
		_elm_lang$core$Native_Utils.chr('0'),
		_elm_lang$core$Native_Utils.chr('7'));
	var _elm_lang$core$Char$isHexDigit = function ($char) {
		return _elm_lang$core$Char$isDigit($char) || (A3(
			_elm_lang$core$Char$isBetween,
			_elm_lang$core$Native_Utils.chr('a'),
			_elm_lang$core$Native_Utils.chr('f'),
			$char) || A3(
			_elm_lang$core$Char$isBetween,
			_elm_lang$core$Native_Utils.chr('A'),
			_elm_lang$core$Native_Utils.chr('F'),
			$char));
	};

	var _elm_lang$core$Result$toMaybe = function (result) {
		var _p0 = result;
		if (_p0.ctor === 'Ok') {
			return _elm_lang$core$Maybe$Just(_p0._0);
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	};
	var _elm_lang$core$Result$withDefault = F2(
		function (def, result) {
			var _p1 = result;
			if (_p1.ctor === 'Ok') {
				return _p1._0;
			} else {
				return def;
			}
		});
	var _elm_lang$core$Result$Err = function (a) {
		return {ctor: 'Err', _0: a};
	};
	var _elm_lang$core$Result$andThen = F2(
		function (callback, result) {
			var _p2 = result;
			if (_p2.ctor === 'Ok') {
				return callback(_p2._0);
			} else {
				return _elm_lang$core$Result$Err(_p2._0);
			}
		});
	var _elm_lang$core$Result$Ok = function (a) {
		return {ctor: 'Ok', _0: a};
	};
	var _elm_lang$core$Result$map = F2(
		function (func, ra) {
			var _p3 = ra;
			if (_p3.ctor === 'Ok') {
				return _elm_lang$core$Result$Ok(
					func(_p3._0));
			} else {
				return _elm_lang$core$Result$Err(_p3._0);
			}
		});
	var _elm_lang$core$Result$map2 = F3(
		function (func, ra, rb) {
			var _p4 = {ctor: '_Tuple2', _0: ra, _1: rb};
			if (_p4._0.ctor === 'Ok') {
				if (_p4._1.ctor === 'Ok') {
					return _elm_lang$core$Result$Ok(
						A2(func, _p4._0._0, _p4._1._0));
				} else {
					return _elm_lang$core$Result$Err(_p4._1._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p4._0._0);
			}
		});
	var _elm_lang$core$Result$map3 = F4(
		function (func, ra, rb, rc) {
			var _p5 = {ctor: '_Tuple3', _0: ra, _1: rb, _2: rc};
			if (_p5._0.ctor === 'Ok') {
				if (_p5._1.ctor === 'Ok') {
					if (_p5._2.ctor === 'Ok') {
						return _elm_lang$core$Result$Ok(
							A3(func, _p5._0._0, _p5._1._0, _p5._2._0));
					} else {
						return _elm_lang$core$Result$Err(_p5._2._0);
					}
				} else {
					return _elm_lang$core$Result$Err(_p5._1._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p5._0._0);
			}
		});
	var _elm_lang$core$Result$map4 = F5(
		function (func, ra, rb, rc, rd) {
			var _p6 = {ctor: '_Tuple4', _0: ra, _1: rb, _2: rc, _3: rd};
			if (_p6._0.ctor === 'Ok') {
				if (_p6._1.ctor === 'Ok') {
					if (_p6._2.ctor === 'Ok') {
						if (_p6._3.ctor === 'Ok') {
							return _elm_lang$core$Result$Ok(
								A4(func, _p6._0._0, _p6._1._0, _p6._2._0, _p6._3._0));
						} else {
							return _elm_lang$core$Result$Err(_p6._3._0);
						}
					} else {
						return _elm_lang$core$Result$Err(_p6._2._0);
					}
				} else {
					return _elm_lang$core$Result$Err(_p6._1._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p6._0._0);
			}
		});
	var _elm_lang$core$Result$map5 = F6(
		function (func, ra, rb, rc, rd, re) {
			var _p7 = {ctor: '_Tuple5', _0: ra, _1: rb, _2: rc, _3: rd, _4: re};
			if (_p7._0.ctor === 'Ok') {
				if (_p7._1.ctor === 'Ok') {
					if (_p7._2.ctor === 'Ok') {
						if (_p7._3.ctor === 'Ok') {
							if (_p7._4.ctor === 'Ok') {
								return _elm_lang$core$Result$Ok(
									A5(func, _p7._0._0, _p7._1._0, _p7._2._0, _p7._3._0, _p7._4._0));
							} else {
								return _elm_lang$core$Result$Err(_p7._4._0);
							}
						} else {
							return _elm_lang$core$Result$Err(_p7._3._0);
						}
					} else {
						return _elm_lang$core$Result$Err(_p7._2._0);
					}
				} else {
					return _elm_lang$core$Result$Err(_p7._1._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p7._0._0);
			}
		});
	var _elm_lang$core$Result$mapError = F2(
		function (f, result) {
			var _p8 = result;
			if (_p8.ctor === 'Ok') {
				return _elm_lang$core$Result$Ok(_p8._0);
			} else {
				return _elm_lang$core$Result$Err(
					f(_p8._0));
			}
		});
	var _elm_lang$core$Result$fromMaybe = F2(
		function (err, maybe) {
			var _p9 = maybe;
			if (_p9.ctor === 'Just') {
				return _elm_lang$core$Result$Ok(_p9._0);
			} else {
				return _elm_lang$core$Result$Err(err);
			}
		});

	var _elm_lang$core$String$fromList = _elm_lang$core$Native_String.fromList;
	var _elm_lang$core$String$toList = _elm_lang$core$Native_String.toList;
	var _elm_lang$core$String$toFloat = _elm_lang$core$Native_String.toFloat;
	var _elm_lang$core$String$toInt = _elm_lang$core$Native_String.toInt;
	var _elm_lang$core$String$indices = _elm_lang$core$Native_String.indexes;
	var _elm_lang$core$String$indexes = _elm_lang$core$Native_String.indexes;
	var _elm_lang$core$String$endsWith = _elm_lang$core$Native_String.endsWith;
	var _elm_lang$core$String$startsWith = _elm_lang$core$Native_String.startsWith;
	var _elm_lang$core$String$contains = _elm_lang$core$Native_String.contains;
	var _elm_lang$core$String$all = _elm_lang$core$Native_String.all;
	var _elm_lang$core$String$any = _elm_lang$core$Native_String.any;
	var _elm_lang$core$String$toLower = _elm_lang$core$Native_String.toLower;
	var _elm_lang$core$String$toUpper = _elm_lang$core$Native_String.toUpper;
	var _elm_lang$core$String$lines = _elm_lang$core$Native_String.lines;
	var _elm_lang$core$String$words = _elm_lang$core$Native_String.words;
	var _elm_lang$core$String$trimRight = _elm_lang$core$Native_String.trimRight;
	var _elm_lang$core$String$trimLeft = _elm_lang$core$Native_String.trimLeft;
	var _elm_lang$core$String$trim = _elm_lang$core$Native_String.trim;
	var _elm_lang$core$String$padRight = _elm_lang$core$Native_String.padRight;
	var _elm_lang$core$String$padLeft = _elm_lang$core$Native_String.padLeft;
	var _elm_lang$core$String$pad = _elm_lang$core$Native_String.pad;
	var _elm_lang$core$String$dropRight = _elm_lang$core$Native_String.dropRight;
	var _elm_lang$core$String$dropLeft = _elm_lang$core$Native_String.dropLeft;
	var _elm_lang$core$String$right = _elm_lang$core$Native_String.right;
	var _elm_lang$core$String$left = _elm_lang$core$Native_String.left;
	var _elm_lang$core$String$slice = _elm_lang$core$Native_String.slice;
	var _elm_lang$core$String$repeat = _elm_lang$core$Native_String.repeat;
	var _elm_lang$core$String$join = _elm_lang$core$Native_String.join;
	var _elm_lang$core$String$split = _elm_lang$core$Native_String.split;
	var _elm_lang$core$String$foldr = _elm_lang$core$Native_String.foldr;
	var _elm_lang$core$String$foldl = _elm_lang$core$Native_String.foldl;
	var _elm_lang$core$String$reverse = _elm_lang$core$Native_String.reverse;
	var _elm_lang$core$String$filter = _elm_lang$core$Native_String.filter;
	var _elm_lang$core$String$map = _elm_lang$core$Native_String.map;
	var _elm_lang$core$String$length = _elm_lang$core$Native_String.length;
	var _elm_lang$core$String$concat = _elm_lang$core$Native_String.concat;
	var _elm_lang$core$String$append = _elm_lang$core$Native_String.append;
	var _elm_lang$core$String$uncons = _elm_lang$core$Native_String.uncons;
	var _elm_lang$core$String$cons = _elm_lang$core$Native_String.cons;
	var _elm_lang$core$String$fromChar = function ($char) {
		return A2(_elm_lang$core$String$cons, $char, '');
	};
	var _elm_lang$core$String$isEmpty = _elm_lang$core$Native_String.isEmpty;

	var _elm_lang$core$Dict$foldr = F3(
		function (f, acc, t) {
			foldr:
			while (true) {
				var _p0 = t;
				if (_p0.ctor === 'RBEmpty_elm_builtin') {
					return acc;
				} else {
					var _v1 = f,
						_v2 = A3(
						f,
						_p0._1,
						_p0._2,
						A3(_elm_lang$core$Dict$foldr, f, acc, _p0._4)),
						_v3 = _p0._3;
					f = _v1;
					acc = _v2;
					t = _v3;
					continue foldr;
				}
			}
		});
	var _elm_lang$core$Dict$keys = function (dict) {
		return A3(
			_elm_lang$core$Dict$foldr,
			F3(
				function (key, value, keyList) {
					return {ctor: '::', _0: key, _1: keyList};
				}),
			{ctor: '[]'},
			dict);
	};
	var _elm_lang$core$Dict$values = function (dict) {
		return A3(
			_elm_lang$core$Dict$foldr,
			F3(
				function (key, value, valueList) {
					return {ctor: '::', _0: value, _1: valueList};
				}),
			{ctor: '[]'},
			dict);
	};
	var _elm_lang$core$Dict$toList = function (dict) {
		return A3(
			_elm_lang$core$Dict$foldr,
			F3(
				function (key, value, list) {
					return {
						ctor: '::',
						_0: {ctor: '_Tuple2', _0: key, _1: value},
						_1: list
					};
				}),
			{ctor: '[]'},
			dict);
	};
	var _elm_lang$core$Dict$foldl = F3(
		function (f, acc, dict) {
			foldl:
			while (true) {
				var _p1 = dict;
				if (_p1.ctor === 'RBEmpty_elm_builtin') {
					return acc;
				} else {
					var _v5 = f,
						_v6 = A3(
						f,
						_p1._1,
						_p1._2,
						A3(_elm_lang$core$Dict$foldl, f, acc, _p1._3)),
						_v7 = _p1._4;
					f = _v5;
					acc = _v6;
					dict = _v7;
					continue foldl;
				}
			}
		});
	var _elm_lang$core$Dict$merge = F6(
		function (leftStep, bothStep, rightStep, leftDict, rightDict, initialResult) {
			var stepState = F3(
				function (rKey, rValue, _p2) {
					stepState:
					while (true) {
						var _p3 = _p2;
						var _p9 = _p3._1;
						var _p8 = _p3._0;
						var _p4 = _p8;
						if (_p4.ctor === '[]') {
							return {
								ctor: '_Tuple2',
								_0: _p8,
								_1: A3(rightStep, rKey, rValue, _p9)
							};
						} else {
							var _p7 = _p4._1;
							var _p6 = _p4._0._1;
							var _p5 = _p4._0._0;
							if (_elm_lang$core$Native_Utils.cmp(_p5, rKey) < 0) {
								var _v10 = rKey,
									_v11 = rValue,
									_v12 = {
									ctor: '_Tuple2',
									_0: _p7,
									_1: A3(leftStep, _p5, _p6, _p9)
								};
								rKey = _v10;
								rValue = _v11;
								_p2 = _v12;
								continue stepState;
							} else {
								if (_elm_lang$core$Native_Utils.cmp(_p5, rKey) > 0) {
									return {
										ctor: '_Tuple2',
										_0: _p8,
										_1: A3(rightStep, rKey, rValue, _p9)
									};
								} else {
									return {
										ctor: '_Tuple2',
										_0: _p7,
										_1: A4(bothStep, _p5, _p6, rValue, _p9)
									};
								}
							}
						}
					}
				});
			var _p10 = A3(
				_elm_lang$core$Dict$foldl,
				stepState,
				{
					ctor: '_Tuple2',
					_0: _elm_lang$core$Dict$toList(leftDict),
					_1: initialResult
				},
				rightDict);
			var leftovers = _p10._0;
			var intermediateResult = _p10._1;
			return A3(
				_elm_lang$core$List$foldl,
				F2(
					function (_p11, result) {
						var _p12 = _p11;
						return A3(leftStep, _p12._0, _p12._1, result);
					}),
				intermediateResult,
				leftovers);
		});
	var _elm_lang$core$Dict$reportRemBug = F4(
		function (msg, c, lgot, rgot) {
			return _elm_lang$core$Native_Debug.crash(
				_elm_lang$core$String$concat(
					{
						ctor: '::',
						_0: 'Internal red-black tree invariant violated, expected ',
						_1: {
							ctor: '::',
							_0: msg,
							_1: {
								ctor: '::',
								_0: ' and got ',
								_1: {
									ctor: '::',
									_0: _elm_lang$core$Basics$toString(c),
									_1: {
										ctor: '::',
										_0: '/',
										_1: {
											ctor: '::',
											_0: lgot,
											_1: {
												ctor: '::',
												_0: '/',
												_1: {
													ctor: '::',
													_0: rgot,
													_1: {
														ctor: '::',
														_0: '\nPlease report this bug to <https://github.com/elm-lang/core/issues>',
														_1: {ctor: '[]'}
													}
												}
											}
										}
									}
								}
							}
						}
					}));
		});
	var _elm_lang$core$Dict$isBBlack = function (dict) {
		var _p13 = dict;
		_v14_2:
		do {
			if (_p13.ctor === 'RBNode_elm_builtin') {
				if (_p13._0.ctor === 'BBlack') {
					return true;
				} else {
					break _v14_2;
				}
			} else {
				if (_p13._0.ctor === 'LBBlack') {
					return true;
				} else {
					break _v14_2;
				}
			}
		} while(false);
		return false;
	};
	var _elm_lang$core$Dict$sizeHelp = F2(
		function (n, dict) {
			sizeHelp:
			while (true) {
				var _p14 = dict;
				if (_p14.ctor === 'RBEmpty_elm_builtin') {
					return n;
				} else {
					var _v16 = A2(_elm_lang$core$Dict$sizeHelp, n + 1, _p14._4),
						_v17 = _p14._3;
					n = _v16;
					dict = _v17;
					continue sizeHelp;
				}
			}
		});
	var _elm_lang$core$Dict$size = function (dict) {
		return A2(_elm_lang$core$Dict$sizeHelp, 0, dict);
	};
	var _elm_lang$core$Dict$get = F2(
		function (targetKey, dict) {
			get:
			while (true) {
				var _p15 = dict;
				if (_p15.ctor === 'RBEmpty_elm_builtin') {
					return _elm_lang$core$Maybe$Nothing;
				} else {
					var _p16 = A2(_elm_lang$core$Basics$compare, targetKey, _p15._1);
					switch (_p16.ctor) {
						case 'LT':
							var _v20 = targetKey,
								_v21 = _p15._3;
							targetKey = _v20;
							dict = _v21;
							continue get;
						case 'EQ':
							return _elm_lang$core$Maybe$Just(_p15._2);
						default:
							var _v22 = targetKey,
								_v23 = _p15._4;
							targetKey = _v22;
							dict = _v23;
							continue get;
					}
				}
			}
		});
	var _elm_lang$core$Dict$member = F2(
		function (key, dict) {
			var _p17 = A2(_elm_lang$core$Dict$get, key, dict);
			if (_p17.ctor === 'Just') {
				return true;
			} else {
				return false;
			}
		});
	var _elm_lang$core$Dict$maxWithDefault = F3(
		function (k, v, r) {
			maxWithDefault:
			while (true) {
				var _p18 = r;
				if (_p18.ctor === 'RBEmpty_elm_builtin') {
					return {ctor: '_Tuple2', _0: k, _1: v};
				} else {
					var _v26 = _p18._1,
						_v27 = _p18._2,
						_v28 = _p18._4;
					k = _v26;
					v = _v27;
					r = _v28;
					continue maxWithDefault;
				}
			}
		});
	var _elm_lang$core$Dict$NBlack = {ctor: 'NBlack'};
	var _elm_lang$core$Dict$BBlack = {ctor: 'BBlack'};
	var _elm_lang$core$Dict$Black = {ctor: 'Black'};
	var _elm_lang$core$Dict$blackish = function (t) {
		var _p19 = t;
		if (_p19.ctor === 'RBNode_elm_builtin') {
			var _p20 = _p19._0;
			return _elm_lang$core$Native_Utils.eq(_p20, _elm_lang$core$Dict$Black) || _elm_lang$core$Native_Utils.eq(_p20, _elm_lang$core$Dict$BBlack);
		} else {
			return true;
		}
	};
	var _elm_lang$core$Dict$Red = {ctor: 'Red'};
	var _elm_lang$core$Dict$moreBlack = function (color) {
		var _p21 = color;
		switch (_p21.ctor) {
			case 'Black':
				return _elm_lang$core$Dict$BBlack;
			case 'Red':
				return _elm_lang$core$Dict$Black;
			case 'NBlack':
				return _elm_lang$core$Dict$Red;
			default:
				return _elm_lang$core$Native_Debug.crash('Can\'t make a double black node more black!');
		}
	};
	var _elm_lang$core$Dict$lessBlack = function (color) {
		var _p22 = color;
		switch (_p22.ctor) {
			case 'BBlack':
				return _elm_lang$core$Dict$Black;
			case 'Black':
				return _elm_lang$core$Dict$Red;
			case 'Red':
				return _elm_lang$core$Dict$NBlack;
			default:
				return _elm_lang$core$Native_Debug.crash('Can\'t make a negative black node less black!');
		}
	};
	var _elm_lang$core$Dict$LBBlack = {ctor: 'LBBlack'};
	var _elm_lang$core$Dict$LBlack = {ctor: 'LBlack'};
	var _elm_lang$core$Dict$RBEmpty_elm_builtin = function (a) {
		return {ctor: 'RBEmpty_elm_builtin', _0: a};
	};
	var _elm_lang$core$Dict$empty = _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
	var _elm_lang$core$Dict$isEmpty = function (dict) {
		return _elm_lang$core$Native_Utils.eq(dict, _elm_lang$core$Dict$empty);
	};
	var _elm_lang$core$Dict$RBNode_elm_builtin = F5(
		function (a, b, c, d, e) {
			return {ctor: 'RBNode_elm_builtin', _0: a, _1: b, _2: c, _3: d, _4: e};
		});
	var _elm_lang$core$Dict$ensureBlackRoot = function (dict) {
		var _p23 = dict;
		if ((_p23.ctor === 'RBNode_elm_builtin') && (_p23._0.ctor === 'Red')) {
			return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p23._1, _p23._2, _p23._3, _p23._4);
		} else {
			return dict;
		}
	};
	var _elm_lang$core$Dict$lessBlackTree = function (dict) {
		var _p24 = dict;
		if (_p24.ctor === 'RBNode_elm_builtin') {
			return A5(
				_elm_lang$core$Dict$RBNode_elm_builtin,
				_elm_lang$core$Dict$lessBlack(_p24._0),
				_p24._1,
				_p24._2,
				_p24._3,
				_p24._4);
		} else {
			return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
		}
	};
	var _elm_lang$core$Dict$balancedTree = function (col) {
		return function (xk) {
			return function (xv) {
				return function (yk) {
					return function (yv) {
						return function (zk) {
							return function (zv) {
								return function (a) {
									return function (b) {
										return function (c) {
											return function (d) {
												return A5(
													_elm_lang$core$Dict$RBNode_elm_builtin,
													_elm_lang$core$Dict$lessBlack(col),
													yk,
													yv,
													A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, xk, xv, a, b),
													A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, zk, zv, c, d));
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
	var _elm_lang$core$Dict$blacken = function (t) {
		var _p25 = t;
		if (_p25.ctor === 'RBEmpty_elm_builtin') {
			return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
		} else {
			return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p25._1, _p25._2, _p25._3, _p25._4);
		}
	};
	var _elm_lang$core$Dict$redden = function (t) {
		var _p26 = t;
		if (_p26.ctor === 'RBEmpty_elm_builtin') {
			return _elm_lang$core$Native_Debug.crash('can\'t make a Leaf red');
		} else {
			return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Red, _p26._1, _p26._2, _p26._3, _p26._4);
		}
	};
	var _elm_lang$core$Dict$balanceHelp = function (tree) {
		var _p27 = tree;
		_v36_6:
		do {
			_v36_5:
			do {
				_v36_4:
				do {
					_v36_3:
					do {
						_v36_2:
						do {
							_v36_1:
							do {
								_v36_0:
								do {
									if (_p27.ctor === 'RBNode_elm_builtin') {
										if (_p27._3.ctor === 'RBNode_elm_builtin') {
											if (_p27._4.ctor === 'RBNode_elm_builtin') {
												switch (_p27._3._0.ctor) {
													case 'Red':
														switch (_p27._4._0.ctor) {
															case 'Red':
																if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																	break _v36_0;
																} else {
																	if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																		break _v36_1;
																	} else {
																		if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																			break _v36_2;
																		} else {
																			if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																				break _v36_3;
																			} else {
																				break _v36_6;
																			}
																		}
																	}
																}
															case 'NBlack':
																if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																	break _v36_0;
																} else {
																	if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																		break _v36_1;
																	} else {
																		if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																			break _v36_4;
																		} else {
																			break _v36_6;
																		}
																	}
																}
															default:
																if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																	break _v36_0;
																} else {
																	if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																		break _v36_1;
																	} else {
																		break _v36_6;
																	}
																}
														}
													case 'NBlack':
														switch (_p27._4._0.ctor) {
															case 'Red':
																if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																	break _v36_2;
																} else {
																	if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																		break _v36_3;
																	} else {
																		if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																			break _v36_5;
																		} else {
																			break _v36_6;
																		}
																	}
																}
															case 'NBlack':
																if (_p27._0.ctor === 'BBlack') {
																	if ((((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																		break _v36_4;
																	} else {
																		if ((((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																			break _v36_5;
																		} else {
																			break _v36_6;
																		}
																	}
																} else {
																	break _v36_6;
																}
															default:
																if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																	break _v36_5;
																} else {
																	break _v36_6;
																}
														}
													default:
														switch (_p27._4._0.ctor) {
															case 'Red':
																if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																	break _v36_2;
																} else {
																	if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																		break _v36_3;
																	} else {
																		break _v36_6;
																	}
																}
															case 'NBlack':
																if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																	break _v36_4;
																} else {
																	break _v36_6;
																}
															default:
																break _v36_6;
														}
												}
											} else {
												switch (_p27._3._0.ctor) {
													case 'Red':
														if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
															break _v36_0;
														} else {
															if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																break _v36_1;
															} else {
																break _v36_6;
															}
														}
													case 'NBlack':
														if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
															break _v36_5;
														} else {
															break _v36_6;
														}
													default:
														break _v36_6;
												}
											}
										} else {
											if (_p27._4.ctor === 'RBNode_elm_builtin') {
												switch (_p27._4._0.ctor) {
													case 'Red':
														if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
															break _v36_2;
														} else {
															if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																break _v36_3;
															} else {
																break _v36_6;
															}
														}
													case 'NBlack':
														if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
															break _v36_4;
														} else {
															break _v36_6;
														}
													default:
														break _v36_6;
												}
											} else {
												break _v36_6;
											}
										}
									} else {
										break _v36_6;
									}
								} while(false);
								return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._3._3._1)(_p27._3._3._2)(_p27._3._1)(_p27._3._2)(_p27._1)(_p27._2)(_p27._3._3._3)(_p27._3._3._4)(_p27._3._4)(_p27._4);
							} while(false);
							return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._3._1)(_p27._3._2)(_p27._3._4._1)(_p27._3._4._2)(_p27._1)(_p27._2)(_p27._3._3)(_p27._3._4._3)(_p27._3._4._4)(_p27._4);
						} while(false);
						return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._1)(_p27._2)(_p27._4._3._1)(_p27._4._3._2)(_p27._4._1)(_p27._4._2)(_p27._3)(_p27._4._3._3)(_p27._4._3._4)(_p27._4._4);
					} while(false);
					return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._1)(_p27._2)(_p27._4._1)(_p27._4._2)(_p27._4._4._1)(_p27._4._4._2)(_p27._3)(_p27._4._3)(_p27._4._4._3)(_p27._4._4._4);
				} while(false);
				return A5(
					_elm_lang$core$Dict$RBNode_elm_builtin,
					_elm_lang$core$Dict$Black,
					_p27._4._3._1,
					_p27._4._3._2,
					A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p27._1, _p27._2, _p27._3, _p27._4._3._3),
					A5(
						_elm_lang$core$Dict$balance,
						_elm_lang$core$Dict$Black,
						_p27._4._1,
						_p27._4._2,
						_p27._4._3._4,
						_elm_lang$core$Dict$redden(_p27._4._4)));
			} while(false);
			return A5(
				_elm_lang$core$Dict$RBNode_elm_builtin,
				_elm_lang$core$Dict$Black,
				_p27._3._4._1,
				_p27._3._4._2,
				A5(
					_elm_lang$core$Dict$balance,
					_elm_lang$core$Dict$Black,
					_p27._3._1,
					_p27._3._2,
					_elm_lang$core$Dict$redden(_p27._3._3),
					_p27._3._4._3),
				A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p27._1, _p27._2, _p27._3._4._4, _p27._4));
		} while(false);
		return tree;
	};
	var _elm_lang$core$Dict$balance = F5(
		function (c, k, v, l, r) {
			var tree = A5(_elm_lang$core$Dict$RBNode_elm_builtin, c, k, v, l, r);
			return _elm_lang$core$Dict$blackish(tree) ? _elm_lang$core$Dict$balanceHelp(tree) : tree;
		});
	var _elm_lang$core$Dict$bubble = F5(
		function (c, k, v, l, r) {
			return (_elm_lang$core$Dict$isBBlack(l) || _elm_lang$core$Dict$isBBlack(r)) ? A5(
				_elm_lang$core$Dict$balance,
				_elm_lang$core$Dict$moreBlack(c),
				k,
				v,
				_elm_lang$core$Dict$lessBlackTree(l),
				_elm_lang$core$Dict$lessBlackTree(r)) : A5(_elm_lang$core$Dict$RBNode_elm_builtin, c, k, v, l, r);
		});
	var _elm_lang$core$Dict$removeMax = F5(
		function (c, k, v, l, r) {
			var _p28 = r;
			if (_p28.ctor === 'RBEmpty_elm_builtin') {
				return A3(_elm_lang$core$Dict$rem, c, l, r);
			} else {
				return A5(
					_elm_lang$core$Dict$bubble,
					c,
					k,
					v,
					l,
					A5(_elm_lang$core$Dict$removeMax, _p28._0, _p28._1, _p28._2, _p28._3, _p28._4));
			}
		});
	var _elm_lang$core$Dict$rem = F3(
		function (color, left, right) {
			var _p29 = {ctor: '_Tuple2', _0: left, _1: right};
			if (_p29._0.ctor === 'RBEmpty_elm_builtin') {
				if (_p29._1.ctor === 'RBEmpty_elm_builtin') {
					var _p30 = color;
					switch (_p30.ctor) {
						case 'Red':
							return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
						case 'Black':
							return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBBlack);
						default:
							return _elm_lang$core$Native_Debug.crash('cannot have bblack or nblack nodes at this point');
					}
				} else {
					var _p33 = _p29._1._0;
					var _p32 = _p29._0._0;
					var _p31 = {ctor: '_Tuple3', _0: color, _1: _p32, _2: _p33};
					if ((((_p31.ctor === '_Tuple3') && (_p31._0.ctor === 'Black')) && (_p31._1.ctor === 'LBlack')) && (_p31._2.ctor === 'Red')) {
						return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p29._1._1, _p29._1._2, _p29._1._3, _p29._1._4);
					} else {
						return A4(
							_elm_lang$core$Dict$reportRemBug,
							'Black/LBlack/Red',
							color,
							_elm_lang$core$Basics$toString(_p32),
							_elm_lang$core$Basics$toString(_p33));
					}
				}
			} else {
				if (_p29._1.ctor === 'RBEmpty_elm_builtin') {
					var _p36 = _p29._1._0;
					var _p35 = _p29._0._0;
					var _p34 = {ctor: '_Tuple3', _0: color, _1: _p35, _2: _p36};
					if ((((_p34.ctor === '_Tuple3') && (_p34._0.ctor === 'Black')) && (_p34._1.ctor === 'Red')) && (_p34._2.ctor === 'LBlack')) {
						return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p29._0._1, _p29._0._2, _p29._0._3, _p29._0._4);
					} else {
						return A4(
							_elm_lang$core$Dict$reportRemBug,
							'Black/Red/LBlack',
							color,
							_elm_lang$core$Basics$toString(_p35),
							_elm_lang$core$Basics$toString(_p36));
					}
				} else {
					var _p40 = _p29._0._2;
					var _p39 = _p29._0._4;
					var _p38 = _p29._0._1;
					var newLeft = A5(_elm_lang$core$Dict$removeMax, _p29._0._0, _p38, _p40, _p29._0._3, _p39);
					var _p37 = A3(_elm_lang$core$Dict$maxWithDefault, _p38, _p40, _p39);
					var k = _p37._0;
					var v = _p37._1;
					return A5(_elm_lang$core$Dict$bubble, color, k, v, newLeft, right);
				}
			}
		});
	var _elm_lang$core$Dict$map = F2(
		function (f, dict) {
			var _p41 = dict;
			if (_p41.ctor === 'RBEmpty_elm_builtin') {
				return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
			} else {
				var _p42 = _p41._1;
				return A5(
					_elm_lang$core$Dict$RBNode_elm_builtin,
					_p41._0,
					_p42,
					A2(f, _p42, _p41._2),
					A2(_elm_lang$core$Dict$map, f, _p41._3),
					A2(_elm_lang$core$Dict$map, f, _p41._4));
			}
		});
	var _elm_lang$core$Dict$Same = {ctor: 'Same'};
	var _elm_lang$core$Dict$Remove = {ctor: 'Remove'};
	var _elm_lang$core$Dict$Insert = {ctor: 'Insert'};
	var _elm_lang$core$Dict$update = F3(
		function (k, alter, dict) {
			var up = function (dict) {
				var _p43 = dict;
				if (_p43.ctor === 'RBEmpty_elm_builtin') {
					var _p44 = alter(_elm_lang$core$Maybe$Nothing);
					if (_p44.ctor === 'Nothing') {
						return {ctor: '_Tuple2', _0: _elm_lang$core$Dict$Same, _1: _elm_lang$core$Dict$empty};
					} else {
						return {
							ctor: '_Tuple2',
							_0: _elm_lang$core$Dict$Insert,
							_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Red, k, _p44._0, _elm_lang$core$Dict$empty, _elm_lang$core$Dict$empty)
						};
					}
				} else {
					var _p55 = _p43._2;
					var _p54 = _p43._4;
					var _p53 = _p43._3;
					var _p52 = _p43._1;
					var _p51 = _p43._0;
					var _p45 = A2(_elm_lang$core$Basics$compare, k, _p52);
					switch (_p45.ctor) {
						case 'EQ':
							var _p46 = alter(
								_elm_lang$core$Maybe$Just(_p55));
							if (_p46.ctor === 'Nothing') {
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Remove,
									_1: A3(_elm_lang$core$Dict$rem, _p51, _p53, _p54)
								};
							} else {
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Same,
									_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p46._0, _p53, _p54)
								};
							}
						case 'LT':
							var _p47 = up(_p53);
							var flag = _p47._0;
							var newLeft = _p47._1;
							var _p48 = flag;
							switch (_p48.ctor) {
								case 'Same':
									return {
										ctor: '_Tuple2',
										_0: _elm_lang$core$Dict$Same,
										_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p55, newLeft, _p54)
									};
								case 'Insert':
									return {
										ctor: '_Tuple2',
										_0: _elm_lang$core$Dict$Insert,
										_1: A5(_elm_lang$core$Dict$balance, _p51, _p52, _p55, newLeft, _p54)
									};
								default:
									return {
										ctor: '_Tuple2',
										_0: _elm_lang$core$Dict$Remove,
										_1: A5(_elm_lang$core$Dict$bubble, _p51, _p52, _p55, newLeft, _p54)
									};
							}
						default:
							var _p49 = up(_p54);
							var flag = _p49._0;
							var newRight = _p49._1;
							var _p50 = flag;
							switch (_p50.ctor) {
								case 'Same':
									return {
										ctor: '_Tuple2',
										_0: _elm_lang$core$Dict$Same,
										_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p55, _p53, newRight)
									};
								case 'Insert':
									return {
										ctor: '_Tuple2',
										_0: _elm_lang$core$Dict$Insert,
										_1: A5(_elm_lang$core$Dict$balance, _p51, _p52, _p55, _p53, newRight)
									};
								default:
									return {
										ctor: '_Tuple2',
										_0: _elm_lang$core$Dict$Remove,
										_1: A5(_elm_lang$core$Dict$bubble, _p51, _p52, _p55, _p53, newRight)
									};
							}
					}
				}
			};
			var _p56 = up(dict);
			var flag = _p56._0;
			var updatedDict = _p56._1;
			var _p57 = flag;
			switch (_p57.ctor) {
				case 'Same':
					return updatedDict;
				case 'Insert':
					return _elm_lang$core$Dict$ensureBlackRoot(updatedDict);
				default:
					return _elm_lang$core$Dict$blacken(updatedDict);
			}
		});
	var _elm_lang$core$Dict$insert = F3(
		function (key, value, dict) {
			return A3(
				_elm_lang$core$Dict$update,
				key,
				_elm_lang$core$Basics$always(
					_elm_lang$core$Maybe$Just(value)),
				dict);
		});
	var _elm_lang$core$Dict$singleton = F2(
		function (key, value) {
			return A3(_elm_lang$core$Dict$insert, key, value, _elm_lang$core$Dict$empty);
		});
	var _elm_lang$core$Dict$union = F2(
		function (t1, t2) {
			return A3(_elm_lang$core$Dict$foldl, _elm_lang$core$Dict$insert, t2, t1);
		});
	var _elm_lang$core$Dict$filter = F2(
		function (predicate, dictionary) {
			var add = F3(
				function (key, value, dict) {
					return A2(predicate, key, value) ? A3(_elm_lang$core$Dict$insert, key, value, dict) : dict;
				});
			return A3(_elm_lang$core$Dict$foldl, add, _elm_lang$core$Dict$empty, dictionary);
		});
	var _elm_lang$core$Dict$intersect = F2(
		function (t1, t2) {
			return A2(
				_elm_lang$core$Dict$filter,
				F2(
					function (k, _p58) {
						return A2(_elm_lang$core$Dict$member, k, t2);
					}),
				t1);
		});
	var _elm_lang$core$Dict$partition = F2(
		function (predicate, dict) {
			var add = F3(
				function (key, value, _p59) {
					var _p60 = _p59;
					var _p62 = _p60._1;
					var _p61 = _p60._0;
					return A2(predicate, key, value) ? {
						ctor: '_Tuple2',
						_0: A3(_elm_lang$core$Dict$insert, key, value, _p61),
						_1: _p62
					} : {
						ctor: '_Tuple2',
						_0: _p61,
						_1: A3(_elm_lang$core$Dict$insert, key, value, _p62)
					};
				});
			return A3(
				_elm_lang$core$Dict$foldl,
				add,
				{ctor: '_Tuple2', _0: _elm_lang$core$Dict$empty, _1: _elm_lang$core$Dict$empty},
				dict);
		});
	var _elm_lang$core$Dict$fromList = function (assocs) {
		return A3(
			_elm_lang$core$List$foldl,
			F2(
				function (_p63, dict) {
					var _p64 = _p63;
					return A3(_elm_lang$core$Dict$insert, _p64._0, _p64._1, dict);
				}),
			_elm_lang$core$Dict$empty,
			assocs);
	};
	var _elm_lang$core$Dict$remove = F2(
		function (key, dict) {
			return A3(
				_elm_lang$core$Dict$update,
				key,
				_elm_lang$core$Basics$always(_elm_lang$core$Maybe$Nothing),
				dict);
		});
	var _elm_lang$core$Dict$diff = F2(
		function (t1, t2) {
			return A3(
				_elm_lang$core$Dict$foldl,
				F3(
					function (k, v, t) {
						return A2(_elm_lang$core$Dict$remove, k, t);
					}),
				t1,
				t2);
		});

	//import Maybe, Native.Array, Native.List, Native.Utils, Result //

	var _elm_lang$core$Native_Json = function() {


	// CORE DECODERS

	function succeed(msg)
	{
		return {
			ctor: '<decoder>',
			tag: 'succeed',
			msg: msg
		};
	}

	function fail(msg)
	{
		return {
			ctor: '<decoder>',
			tag: 'fail',
			msg: msg
		};
	}

	function decodePrimitive(tag)
	{
		return {
			ctor: '<decoder>',
			tag: tag
		};
	}

	function decodeContainer(tag, decoder)
	{
		return {
			ctor: '<decoder>',
			tag: tag,
			decoder: decoder
		};
	}

	function decodeNull(value)
	{
		return {
			ctor: '<decoder>',
			tag: 'null',
			value: value
		};
	}

	function decodeField(field, decoder)
	{
		return {
			ctor: '<decoder>',
			tag: 'field',
			field: field,
			decoder: decoder
		};
	}

	function decodeIndex(index, decoder)
	{
		return {
			ctor: '<decoder>',
			tag: 'index',
			index: index,
			decoder: decoder
		};
	}

	function decodeKeyValuePairs(decoder)
	{
		return {
			ctor: '<decoder>',
			tag: 'key-value',
			decoder: decoder
		};
	}

	function mapMany(f, decoders)
	{
		return {
			ctor: '<decoder>',
			tag: 'map-many',
			func: f,
			decoders: decoders
		};
	}

	function andThen(callback, decoder)
	{
		return {
			ctor: '<decoder>',
			tag: 'andThen',
			decoder: decoder,
			callback: callback
		};
	}

	function oneOf(decoders)
	{
		return {
			ctor: '<decoder>',
			tag: 'oneOf',
			decoders: decoders
		};
	}


	// DECODING OBJECTS

	function map1(f, d1)
	{
		return mapMany(f, [d1]);
	}

	function map2(f, d1, d2)
	{
		return mapMany(f, [d1, d2]);
	}

	function map3(f, d1, d2, d3)
	{
		return mapMany(f, [d1, d2, d3]);
	}

	function map4(f, d1, d2, d3, d4)
	{
		return mapMany(f, [d1, d2, d3, d4]);
	}

	function map5(f, d1, d2, d3, d4, d5)
	{
		return mapMany(f, [d1, d2, d3, d4, d5]);
	}

	function map6(f, d1, d2, d3, d4, d5, d6)
	{
		return mapMany(f, [d1, d2, d3, d4, d5, d6]);
	}

	function map7(f, d1, d2, d3, d4, d5, d6, d7)
	{
		return mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
	}

	function map8(f, d1, d2, d3, d4, d5, d6, d7, d8)
	{
		return mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
	}


	// DECODE HELPERS

	function ok(value)
	{
		return { tag: 'ok', value: value };
	}

	function badPrimitive(type, value)
	{
		return { tag: 'primitive', type: type, value: value };
	}

	function badIndex(index, nestedProblems)
	{
		return { tag: 'index', index: index, rest: nestedProblems };
	}

	function badField(field, nestedProblems)
	{
		return { tag: 'field', field: field, rest: nestedProblems };
	}

	function badIndex(index, nestedProblems)
	{
		return { tag: 'index', index: index, rest: nestedProblems };
	}

	function badOneOf(problems)
	{
		return { tag: 'oneOf', problems: problems };
	}

	function bad(msg)
	{
		return { tag: 'fail', msg: msg };
	}

	function badToString(problem)
	{
		var context = '_';
		while (problem)
		{
			switch (problem.tag)
			{
				case 'primitive':
					return 'Expecting ' + problem.type
						+ (context === '_' ? '' : ' at ' + context)
						+ ' but instead got: ' + jsToString(problem.value);

				case 'index':
					context += '[' + problem.index + ']';
					problem = problem.rest;
					break;

				case 'field':
					context += '.' + problem.field;
					problem = problem.rest;
					break;

				case 'oneOf':
					var problems = problem.problems;
					for (var i = 0; i < problems.length; i++)
					{
						problems[i] = badToString(problems[i]);
					}
					return 'I ran into the following problems'
						+ (context === '_' ? '' : ' at ' + context)
						+ ':\n\n' + problems.join('\n');

				case 'fail':
					return 'I ran into a `fail` decoder'
						+ (context === '_' ? '' : ' at ' + context)
						+ ': ' + problem.msg;
			}
		}
	}

	function jsToString(value)
	{
		return value === undefined
			? 'undefined'
			: JSON.stringify(value);
	}


	// DECODE

	function runOnString(decoder, string)
	{
		var json;
		try
		{
			json = JSON.parse(string);
		}
		catch (e)
		{
			return _elm_lang$core$Result$Err('Given an invalid JSON: ' + e.message);
		}
		return run(decoder, json);
	}

	function run(decoder, value)
	{
		var result = runHelp(decoder, value);
		return (result.tag === 'ok')
			? _elm_lang$core$Result$Ok(result.value)
			: _elm_lang$core$Result$Err(badToString(result));
	}

	function runHelp(decoder, value)
	{
		switch (decoder.tag)
		{
			case 'bool':
				return (typeof value === 'boolean')
					? ok(value)
					: badPrimitive('a Bool', value);

			case 'int':
				if (typeof value !== 'number') {
					return badPrimitive('an Int', value);
				}

				if (-2147483647 < value && value < 2147483647 && (value | 0) === value) {
					return ok(value);
				}

				if (isFinite(value) && !(value % 1)) {
					return ok(value);
				}

				return badPrimitive('an Int', value);

			case 'float':
				return (typeof value === 'number')
					? ok(value)
					: badPrimitive('a Float', value);

			case 'string':
				return (typeof value === 'string')
					? ok(value)
					: (value instanceof String)
						? ok(value + '')
						: badPrimitive('a String', value);

			case 'null':
				return (value === null)
					? ok(decoder.value)
					: badPrimitive('null', value);

			case 'value':
				return ok(value);

			case 'list':
				if (!(value instanceof Array))
				{
					return badPrimitive('a List', value);
				}

				var list = _elm_lang$core$Native_List.Nil;
				for (var i = value.length; i--; )
				{
					var result = runHelp(decoder.decoder, value[i]);
					if (result.tag !== 'ok')
					{
						return badIndex(i, result)
					}
					list = _elm_lang$core$Native_List.Cons(result.value, list);
				}
				return ok(list);

			case 'array':
				if (!(value instanceof Array))
				{
					return badPrimitive('an Array', value);
				}

				var len = value.length;
				var array = new Array(len);
				for (var i = len; i--; )
				{
					var result = runHelp(decoder.decoder, value[i]);
					if (result.tag !== 'ok')
					{
						return badIndex(i, result);
					}
					array[i] = result.value;
				}
				return ok(_elm_lang$core$Native_Array.fromJSArray(array));

			case 'maybe':
				var result = runHelp(decoder.decoder, value);
				return (result.tag === 'ok')
					? ok(_elm_lang$core$Maybe$Just(result.value))
					: ok(_elm_lang$core$Maybe$Nothing);

			case 'field':
				var field = decoder.field;
				if (typeof value !== 'object' || value === null || !(field in value))
				{
					return badPrimitive('an object with a field named `' + field + '`', value);
				}

				var result = runHelp(decoder.decoder, value[field]);
				return (result.tag === 'ok') ? result : badField(field, result);

			case 'index':
				var index = decoder.index;
				if (!(value instanceof Array))
				{
					return badPrimitive('an array', value);
				}
				if (index >= value.length)
				{
					return badPrimitive('a longer array. Need index ' + index + ' but there are only ' + value.length + ' entries', value);
				}

				var result = runHelp(decoder.decoder, value[index]);
				return (result.tag === 'ok') ? result : badIndex(index, result);

			case 'key-value':
				if (typeof value !== 'object' || value === null || value instanceof Array)
				{
					return badPrimitive('an object', value);
				}

				var keyValuePairs = _elm_lang$core$Native_List.Nil;
				for (var key in value)
				{
					var result = runHelp(decoder.decoder, value[key]);
					if (result.tag !== 'ok')
					{
						return badField(key, result);
					}
					var pair = _elm_lang$core$Native_Utils.Tuple2(key, result.value);
					keyValuePairs = _elm_lang$core$Native_List.Cons(pair, keyValuePairs);
				}
				return ok(keyValuePairs);

			case 'map-many':
				var answer = decoder.func;
				var decoders = decoder.decoders;
				for (var i = 0; i < decoders.length; i++)
				{
					var result = runHelp(decoders[i], value);
					if (result.tag !== 'ok')
					{
						return result;
					}
					answer = answer(result.value);
				}
				return ok(answer);

			case 'andThen':
				var result = runHelp(decoder.decoder, value);
				return (result.tag !== 'ok')
					? result
					: runHelp(decoder.callback(result.value), value);

			case 'oneOf':
				var errors = [];
				var temp = decoder.decoders;
				while (temp.ctor !== '[]')
				{
					var result = runHelp(temp._0, value);

					if (result.tag === 'ok')
					{
						return result;
					}

					errors.push(result);

					temp = temp._1;
				}
				return badOneOf(errors);

			case 'fail':
				return bad(decoder.msg);

			case 'succeed':
				return ok(decoder.msg);
		}
	}


	// EQUALITY

	function equality(a, b)
	{
		if (a === b)
		{
			return true;
		}

		if (a.tag !== b.tag)
		{
			return false;
		}

		switch (a.tag)
		{
			case 'succeed':
			case 'fail':
				return a.msg === b.msg;

			case 'bool':
			case 'int':
			case 'float':
			case 'string':
			case 'value':
				return true;

			case 'null':
				return a.value === b.value;

			case 'list':
			case 'array':
			case 'maybe':
			case 'key-value':
				return equality(a.decoder, b.decoder);

			case 'field':
				return a.field === b.field && equality(a.decoder, b.decoder);

			case 'index':
				return a.index === b.index && equality(a.decoder, b.decoder);

			case 'map-many':
				if (a.func !== b.func)
				{
					return false;
				}
				return listEquality(a.decoders, b.decoders);

			case 'andThen':
				return a.callback === b.callback && equality(a.decoder, b.decoder);

			case 'oneOf':
				return listEquality(a.decoders, b.decoders);
		}
	}

	function listEquality(aDecoders, bDecoders)
	{
		var len = aDecoders.length;
		if (len !== bDecoders.length)
		{
			return false;
		}
		for (var i = 0; i < len; i++)
		{
			if (!equality(aDecoders[i], bDecoders[i]))
			{
				return false;
			}
		}
		return true;
	}


	// ENCODE

	function encode(indentLevel, value)
	{
		return JSON.stringify(value, null, indentLevel);
	}

	function identity(value)
	{
		return value;
	}

	function encodeObject(keyValuePairs)
	{
		var obj = {};
		while (keyValuePairs.ctor !== '[]')
		{
			var pair = keyValuePairs._0;
			obj[pair._0] = pair._1;
			keyValuePairs = keyValuePairs._1;
		}
		return obj;
	}

	return {
		encode: F2(encode),
		runOnString: F2(runOnString),
		run: F2(run),

		decodeNull: decodeNull,
		decodePrimitive: decodePrimitive,
		decodeContainer: F2(decodeContainer),

		decodeField: F2(decodeField),
		decodeIndex: F2(decodeIndex),

		map1: F2(map1),
		map2: F3(map2),
		map3: F4(map3),
		map4: F5(map4),
		map5: F6(map5),
		map6: F7(map6),
		map7: F8(map7),
		map8: F9(map8),
		decodeKeyValuePairs: decodeKeyValuePairs,

		andThen: F2(andThen),
		fail: fail,
		succeed: succeed,
		oneOf: oneOf,

		identity: identity,
		encodeNull: null,
		encodeArray: _elm_lang$core$Native_Array.toJSArray,
		encodeList: _elm_lang$core$Native_List.toArray,
		encodeObject: encodeObject,

		equality: equality
	};

	}();

	var _elm_lang$core$Json_Encode$list = _elm_lang$core$Native_Json.encodeList;
	var _elm_lang$core$Json_Encode$array = _elm_lang$core$Native_Json.encodeArray;
	var _elm_lang$core$Json_Encode$object = _elm_lang$core$Native_Json.encodeObject;
	var _elm_lang$core$Json_Encode$null = _elm_lang$core$Native_Json.encodeNull;
	var _elm_lang$core$Json_Encode$bool = _elm_lang$core$Native_Json.identity;
	var _elm_lang$core$Json_Encode$float = _elm_lang$core$Native_Json.identity;
	var _elm_lang$core$Json_Encode$int = _elm_lang$core$Native_Json.identity;
	var _elm_lang$core$Json_Encode$string = _elm_lang$core$Native_Json.identity;
	var _elm_lang$core$Json_Encode$encode = _elm_lang$core$Native_Json.encode;
	var _elm_lang$core$Json_Encode$Value = {ctor: 'Value'};

	var _elm_lang$core$Json_Decode$null = _elm_lang$core$Native_Json.decodeNull;
	var _elm_lang$core$Json_Decode$value = _elm_lang$core$Native_Json.decodePrimitive('value');
	var _elm_lang$core$Json_Decode$andThen = _elm_lang$core$Native_Json.andThen;
	var _elm_lang$core$Json_Decode$fail = _elm_lang$core$Native_Json.fail;
	var _elm_lang$core$Json_Decode$succeed = _elm_lang$core$Native_Json.succeed;
	var _elm_lang$core$Json_Decode$lazy = function (thunk) {
		return A2(
			_elm_lang$core$Json_Decode$andThen,
			thunk,
			_elm_lang$core$Json_Decode$succeed(
				{ctor: '_Tuple0'}));
	};
	var _elm_lang$core$Json_Decode$decodeValue = _elm_lang$core$Native_Json.run;
	var _elm_lang$core$Json_Decode$decodeString = _elm_lang$core$Native_Json.runOnString;
	var _elm_lang$core$Json_Decode$map8 = _elm_lang$core$Native_Json.map8;
	var _elm_lang$core$Json_Decode$map7 = _elm_lang$core$Native_Json.map7;
	var _elm_lang$core$Json_Decode$map6 = _elm_lang$core$Native_Json.map6;
	var _elm_lang$core$Json_Decode$map5 = _elm_lang$core$Native_Json.map5;
	var _elm_lang$core$Json_Decode$map4 = _elm_lang$core$Native_Json.map4;
	var _elm_lang$core$Json_Decode$map3 = _elm_lang$core$Native_Json.map3;
	var _elm_lang$core$Json_Decode$map2 = _elm_lang$core$Native_Json.map2;
	var _elm_lang$core$Json_Decode$map = _elm_lang$core$Native_Json.map1;
	var _elm_lang$core$Json_Decode$oneOf = _elm_lang$core$Native_Json.oneOf;
	var _elm_lang$core$Json_Decode$maybe = function (decoder) {
		return A2(_elm_lang$core$Native_Json.decodeContainer, 'maybe', decoder);
	};
	var _elm_lang$core$Json_Decode$index = _elm_lang$core$Native_Json.decodeIndex;
	var _elm_lang$core$Json_Decode$field = _elm_lang$core$Native_Json.decodeField;
	var _elm_lang$core$Json_Decode$at = F2(
		function (fields, decoder) {
			return A3(_elm_lang$core$List$foldr, _elm_lang$core$Json_Decode$field, decoder, fields);
		});
	var _elm_lang$core$Json_Decode$keyValuePairs = _elm_lang$core$Native_Json.decodeKeyValuePairs;
	var _elm_lang$core$Json_Decode$dict = function (decoder) {
		return A2(
			_elm_lang$core$Json_Decode$map,
			_elm_lang$core$Dict$fromList,
			_elm_lang$core$Json_Decode$keyValuePairs(decoder));
	};
	var _elm_lang$core$Json_Decode$array = function (decoder) {
		return A2(_elm_lang$core$Native_Json.decodeContainer, 'array', decoder);
	};
	var _elm_lang$core$Json_Decode$list = function (decoder) {
		return A2(_elm_lang$core$Native_Json.decodeContainer, 'list', decoder);
	};
	var _elm_lang$core$Json_Decode$nullable = function (decoder) {
		return _elm_lang$core$Json_Decode$oneOf(
			{
				ctor: '::',
				_0: _elm_lang$core$Json_Decode$null(_elm_lang$core$Maybe$Nothing),
				_1: {
					ctor: '::',
					_0: A2(_elm_lang$core$Json_Decode$map, _elm_lang$core$Maybe$Just, decoder),
					_1: {ctor: '[]'}
				}
			});
	};
	var _elm_lang$core$Json_Decode$float = _elm_lang$core$Native_Json.decodePrimitive('float');
	var _elm_lang$core$Json_Decode$int = _elm_lang$core$Native_Json.decodePrimitive('int');
	var _elm_lang$core$Json_Decode$bool = _elm_lang$core$Native_Json.decodePrimitive('bool');
	var _elm_lang$core$Json_Decode$string = _elm_lang$core$Native_Json.decodePrimitive('string');
	var _elm_lang$core$Json_Decode$Decoder = {ctor: 'Decoder'};

	var _elm_lang$dom$Native_Dom = function() {

	var fakeNode = {
		addEventListener: function() {},
		removeEventListener: function() {}
	};

	var onDocument = on(typeof document !== 'undefined' ? document : fakeNode);
	var onWindow = on(typeof window !== 'undefined' ? window : fakeNode);

	function on(node)
	{
		return function(eventName, decoder, toTask)
		{
			return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {

				function performTask(event)
				{
					var result = A2(_elm_lang$core$Json_Decode$decodeValue, decoder, event);
					if (result.ctor === 'Ok')
					{
						_elm_lang$core$Native_Scheduler.rawSpawn(toTask(result._0));
					}
				}

				node.addEventListener(eventName, performTask);

				return function()
				{
					node.removeEventListener(eventName, performTask);
				};
			});
		};
	}

	var rAF = typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(callback) { callback(); };

	function withNode(id, doStuff)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			rAF(function()
			{
				var node = document.getElementById(id);
				if (node === null)
				{
					callback(_elm_lang$core$Native_Scheduler.fail({ ctor: 'NotFound', _0: id }));
					return;
				}
				callback(_elm_lang$core$Native_Scheduler.succeed(doStuff(node)));
			});
		});
	}


	// FOCUS

	function focus(id)
	{
		return withNode(id, function(node) {
			node.focus();
			return _elm_lang$core$Native_Utils.Tuple0;
		});
	}

	function blur(id)
	{
		return withNode(id, function(node) {
			node.blur();
			return _elm_lang$core$Native_Utils.Tuple0;
		});
	}


	// SCROLLING

	function getScrollTop(id)
	{
		return withNode(id, function(node) {
			return node.scrollTop;
		});
	}

	function setScrollTop(id, desiredScrollTop)
	{
		return withNode(id, function(node) {
			node.scrollTop = desiredScrollTop;
			return _elm_lang$core$Native_Utils.Tuple0;
		});
	}

	function toBottom(id)
	{
		return withNode(id, function(node) {
			node.scrollTop = node.scrollHeight;
			return _elm_lang$core$Native_Utils.Tuple0;
		});
	}

	function getScrollLeft(id)
	{
		return withNode(id, function(node) {
			return node.scrollLeft;
		});
	}

	function setScrollLeft(id, desiredScrollLeft)
	{
		return withNode(id, function(node) {
			node.scrollLeft = desiredScrollLeft;
			return _elm_lang$core$Native_Utils.Tuple0;
		});
	}

	function toRight(id)
	{
		return withNode(id, function(node) {
			node.scrollLeft = node.scrollWidth;
			return _elm_lang$core$Native_Utils.Tuple0;
		});
	}


	// SIZE

	function width(options, id)
	{
		return withNode(id, function(node) {
			switch (options.ctor)
			{
				case 'Content':
					return node.scrollWidth;
				case 'VisibleContent':
					return node.clientWidth;
				case 'VisibleContentWithBorders':
					return node.offsetWidth;
				case 'VisibleContentWithBordersAndMargins':
					var rect = node.getBoundingClientRect();
					return rect.right - rect.left;
			}
		});
	}

	function height(options, id)
	{
		return withNode(id, function(node) {
			switch (options.ctor)
			{
				case 'Content':
					return node.scrollHeight;
				case 'VisibleContent':
					return node.clientHeight;
				case 'VisibleContentWithBorders':
					return node.offsetHeight;
				case 'VisibleContentWithBordersAndMargins':
					var rect = node.getBoundingClientRect();
					return rect.bottom - rect.top;
			}
		});
	}

	return {
		onDocument: F3(onDocument),
		onWindow: F3(onWindow),

		focus: focus,
		blur: blur,

		getScrollTop: getScrollTop,
		setScrollTop: F2(setScrollTop),
		getScrollLeft: getScrollLeft,
		setScrollLeft: F2(setScrollLeft),
		toBottom: toBottom,
		toRight: toRight,

		height: F2(height),
		width: F2(width)
	};

	}();

	//import Native.Utils //

	var _elm_lang$core$Native_Scheduler = function() {

	var MAX_STEPS = 10000;


	// TASKS

	function succeed(value)
	{
		return {
			ctor: '_Task_succeed',
			value: value
		};
	}

	function fail(error)
	{
		return {
			ctor: '_Task_fail',
			value: error
		};
	}

	function nativeBinding(callback)
	{
		return {
			ctor: '_Task_nativeBinding',
			callback: callback,
			cancel: null
		};
	}

	function andThen(callback, task)
	{
		return {
			ctor: '_Task_andThen',
			callback: callback,
			task: task
		};
	}

	function onError(callback, task)
	{
		return {
			ctor: '_Task_onError',
			callback: callback,
			task: task
		};
	}

	function receive(callback)
	{
		return {
			ctor: '_Task_receive',
			callback: callback
		};
	}


	// PROCESSES

	function rawSpawn(task)
	{
		var process = {
			ctor: '_Process',
			id: _elm_lang$core$Native_Utils.guid(),
			root: task,
			stack: null,
			mailbox: []
		};

		enqueue(process);

		return process;
	}

	function spawn(task)
	{
		return nativeBinding(function(callback) {
			var process = rawSpawn(task);
			callback(succeed(process));
		});
	}

	function rawSend(process, msg)
	{
		process.mailbox.push(msg);
		enqueue(process);
	}

	function send(process, msg)
	{
		return nativeBinding(function(callback) {
			rawSend(process, msg);
			callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
		});
	}

	function kill(process)
	{
		return nativeBinding(function(callback) {
			var root = process.root;
			if (root.ctor === '_Task_nativeBinding' && root.cancel)
			{
				root.cancel();
			}

			process.root = null;

			callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
		});
	}

	function sleep(time)
	{
		return nativeBinding(function(callback) {
			var id = setTimeout(function() {
				callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
			}, time);

			return function() { clearTimeout(id); };
		});
	}


	// STEP PROCESSES

	function step(numSteps, process)
	{
		while (numSteps < MAX_STEPS)
		{
			var ctor = process.root.ctor;

			if (ctor === '_Task_succeed')
			{
				while (process.stack && process.stack.ctor === '_Task_onError')
				{
					process.stack = process.stack.rest;
				}
				if (process.stack === null)
				{
					break;
				}
				process.root = process.stack.callback(process.root.value);
				process.stack = process.stack.rest;
				++numSteps;
				continue;
			}

			if (ctor === '_Task_fail')
			{
				while (process.stack && process.stack.ctor === '_Task_andThen')
				{
					process.stack = process.stack.rest;
				}
				if (process.stack === null)
				{
					break;
				}
				process.root = process.stack.callback(process.root.value);
				process.stack = process.stack.rest;
				++numSteps;
				continue;
			}

			if (ctor === '_Task_andThen')
			{
				process.stack = {
					ctor: '_Task_andThen',
					callback: process.root.callback,
					rest: process.stack
				};
				process.root = process.root.task;
				++numSteps;
				continue;
			}

			if (ctor === '_Task_onError')
			{
				process.stack = {
					ctor: '_Task_onError',
					callback: process.root.callback,
					rest: process.stack
				};
				process.root = process.root.task;
				++numSteps;
				continue;
			}

			if (ctor === '_Task_nativeBinding')
			{
				process.root.cancel = process.root.callback(function(newRoot) {
					process.root = newRoot;
					enqueue(process);
				});

				break;
			}

			if (ctor === '_Task_receive')
			{
				var mailbox = process.mailbox;
				if (mailbox.length === 0)
				{
					break;
				}

				process.root = process.root.callback(mailbox.shift());
				++numSteps;
				continue;
			}

			throw new Error(ctor);
		}

		if (numSteps < MAX_STEPS)
		{
			return numSteps + 1;
		}
		enqueue(process);

		return numSteps;
	}


	// WORK QUEUE

	var working = false;
	var workQueue = [];

	function enqueue(process)
	{
		workQueue.push(process);

		if (!working)
		{
			setTimeout(work, 0);
			working = true;
		}
	}

	function work()
	{
		var numSteps = 0;
		var process;
		while (numSteps < MAX_STEPS && (process = workQueue.shift()))
		{
			if (process.root)
			{
				numSteps = step(numSteps, process);
			}
		}
		if (!process)
		{
			working = false;
			return;
		}
		setTimeout(work, 0);
	}


	return {
		succeed: succeed,
		fail: fail,
		nativeBinding: nativeBinding,
		andThen: F2(andThen),
		onError: F2(onError),
		receive: receive,

		spawn: spawn,
		kill: kill,
		sleep: sleep,
		send: F2(send),

		rawSpawn: rawSpawn,
		rawSend: rawSend
	};

	}();
	//import //

	var _elm_lang$core$Native_Platform = function() {


	// PROGRAMS

	function program(impl)
	{
		return function(flagDecoder)
		{
			return function(object, moduleName)
			{
				object['worker'] = function worker(flags)
				{
					if (typeof flags !== 'undefined')
					{
						throw new Error(
							'The `' + moduleName + '` module does not need flags.\n'
							+ 'Call ' + moduleName + '.worker() with no arguments and you should be all set!'
						);
					}

					return initialize(
						impl.init,
						impl.update,
						impl.subscriptions,
						renderer
					);
				};
			};
		};
	}

	function programWithFlags(impl)
	{
		return function(flagDecoder)
		{
			return function(object, moduleName)
			{
				object['worker'] = function worker(flags)
				{
					if (typeof flagDecoder === 'undefined')
					{
						throw new Error(
							'Are you trying to sneak a Never value into Elm? Trickster!\n'
							+ 'It looks like ' + moduleName + '.main is defined with `programWithFlags` but has type `Program Never`.\n'
							+ 'Use `program` instead if you do not want flags.'
						);
					}

					var result = A2(_elm_lang$core$Native_Json.run, flagDecoder, flags);
					if (result.ctor === 'Err')
					{
						throw new Error(
							moduleName + '.worker(...) was called with an unexpected argument.\n'
							+ 'I tried to convert it to an Elm value, but ran into this problem:\n\n'
							+ result._0
						);
					}

					return initialize(
						impl.init(result._0),
						impl.update,
						impl.subscriptions,
						renderer
					);
				};
			};
		};
	}

	function renderer(enqueue, _)
	{
		return function(_) {};
	}


	// HTML TO PROGRAM

	function htmlToProgram(vnode)
	{
		var emptyBag = batch(_elm_lang$core$Native_List.Nil);
		var noChange = _elm_lang$core$Native_Utils.Tuple2(
			_elm_lang$core$Native_Utils.Tuple0,
			emptyBag
		);

		return _elm_lang$virtual_dom$VirtualDom$program({
			init: noChange,
			view: function(model) { return main; },
			update: F2(function(msg, model) { return noChange; }),
			subscriptions: function (model) { return emptyBag; }
		});
	}


	// INITIALIZE A PROGRAM

	function initialize(init, update, subscriptions, renderer)
	{
		// ambient state
		var managers = {};
		var updateView;

		// init and update state in main process
		var initApp = _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
			var model = init._0;
			updateView = renderer(enqueue, model);
			var cmds = init._1;
			var subs = subscriptions(model);
			dispatchEffects(managers, cmds, subs);
			callback(_elm_lang$core$Native_Scheduler.succeed(model));
		});

		function onMessage(msg, model)
		{
			return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
				var results = A2(update, msg, model);
				model = results._0;
				updateView(model);
				var cmds = results._1;
				var subs = subscriptions(model);
				dispatchEffects(managers, cmds, subs);
				callback(_elm_lang$core$Native_Scheduler.succeed(model));
			});
		}

		var mainProcess = spawnLoop(initApp, onMessage);

		function enqueue(msg)
		{
			_elm_lang$core$Native_Scheduler.rawSend(mainProcess, msg);
		}

		var ports = setupEffects(managers, enqueue);

		return ports ? { ports: ports } : {};
	}


	// EFFECT MANAGERS

	var effectManagers = {};

	function setupEffects(managers, callback)
	{
		var ports;

		// setup all necessary effect managers
		for (var key in effectManagers)
		{
			var manager = effectManagers[key];

			if (manager.isForeign)
			{
				ports = ports || {};
				ports[key] = manager.tag === 'cmd'
					? setupOutgoingPort(key)
					: setupIncomingPort(key, callback);
			}

			managers[key] = makeManager(manager, callback);
		}

		return ports;
	}

	function makeManager(info, callback)
	{
		var router = {
			main: callback,
			self: undefined
		};

		var tag = info.tag;
		var onEffects = info.onEffects;
		var onSelfMsg = info.onSelfMsg;

		function onMessage(msg, state)
		{
			if (msg.ctor === 'self')
			{
				return A3(onSelfMsg, router, msg._0, state);
			}

			var fx = msg._0;
			switch (tag)
			{
				case 'cmd':
					return A3(onEffects, router, fx.cmds, state);

				case 'sub':
					return A3(onEffects, router, fx.subs, state);

				case 'fx':
					return A4(onEffects, router, fx.cmds, fx.subs, state);
			}
		}

		var process = spawnLoop(info.init, onMessage);
		router.self = process;
		return process;
	}

	function sendToApp(router, msg)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			router.main(msg);
			callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
		});
	}

	function sendToSelf(router, msg)
	{
		return A2(_elm_lang$core$Native_Scheduler.send, router.self, {
			ctor: 'self',
			_0: msg
		});
	}


	// HELPER for STATEFUL LOOPS

	function spawnLoop(init, onMessage)
	{
		var andThen = _elm_lang$core$Native_Scheduler.andThen;

		function loop(state)
		{
			var handleMsg = _elm_lang$core$Native_Scheduler.receive(function(msg) {
				return onMessage(msg, state);
			});
			return A2(andThen, loop, handleMsg);
		}

		var task = A2(andThen, loop, init);

		return _elm_lang$core$Native_Scheduler.rawSpawn(task);
	}


	// BAGS

	function leaf(home)
	{
		return function(value)
		{
			return {
				type: 'leaf',
				home: home,
				value: value
			};
		};
	}

	function batch(list)
	{
		return {
			type: 'node',
			branches: list
		};
	}

	function map(tagger, bag)
	{
		return {
			type: 'map',
			tagger: tagger,
			tree: bag
		}
	}


	// PIPE BAGS INTO EFFECT MANAGERS

	function dispatchEffects(managers, cmdBag, subBag)
	{
		var effectsDict = {};
		gatherEffects(true, cmdBag, effectsDict, null);
		gatherEffects(false, subBag, effectsDict, null);

		for (var home in managers)
		{
			var fx = home in effectsDict
				? effectsDict[home]
				: {
					cmds: _elm_lang$core$Native_List.Nil,
					subs: _elm_lang$core$Native_List.Nil
				};

			_elm_lang$core$Native_Scheduler.rawSend(managers[home], { ctor: 'fx', _0: fx });
		}
	}

	function gatherEffects(isCmd, bag, effectsDict, taggers)
	{
		switch (bag.type)
		{
			case 'leaf':
				var home = bag.home;
				var effect = toEffect(isCmd, home, taggers, bag.value);
				effectsDict[home] = insert(isCmd, effect, effectsDict[home]);
				return;

			case 'node':
				var list = bag.branches;
				while (list.ctor !== '[]')
				{
					gatherEffects(isCmd, list._0, effectsDict, taggers);
					list = list._1;
				}
				return;

			case 'map':
				gatherEffects(isCmd, bag.tree, effectsDict, {
					tagger: bag.tagger,
					rest: taggers
				});
				return;
		}
	}

	function toEffect(isCmd, home, taggers, value)
	{
		function applyTaggers(x)
		{
			var temp = taggers;
			while (temp)
			{
				x = temp.tagger(x);
				temp = temp.rest;
			}
			return x;
		}

		var map = isCmd
			? effectManagers[home].cmdMap
			: effectManagers[home].subMap;

		return A2(map, applyTaggers, value)
	}

	function insert(isCmd, newEffect, effects)
	{
		effects = effects || {
			cmds: _elm_lang$core$Native_List.Nil,
			subs: _elm_lang$core$Native_List.Nil
		};
		if (isCmd)
		{
			effects.cmds = _elm_lang$core$Native_List.Cons(newEffect, effects.cmds);
			return effects;
		}
		effects.subs = _elm_lang$core$Native_List.Cons(newEffect, effects.subs);
		return effects;
	}


	// PORTS

	function checkPortName(name)
	{
		if (name in effectManagers)
		{
			throw new Error('There can only be one port named `' + name + '`, but your program has multiple.');
		}
	}


	// OUTGOING PORTS

	function outgoingPort(name, converter)
	{
		checkPortName(name);
		effectManagers[name] = {
			tag: 'cmd',
			cmdMap: outgoingPortMap,
			converter: converter,
			isForeign: true
		};
		return leaf(name);
	}

	var outgoingPortMap = F2(function cmdMap(tagger, value) {
		return value;
	});

	function setupOutgoingPort(name)
	{
		var subs = [];
		var converter = effectManagers[name].converter;

		// CREATE MANAGER

		var init = _elm_lang$core$Native_Scheduler.succeed(null);

		function onEffects(router, cmdList, state)
		{
			while (cmdList.ctor !== '[]')
			{
				// grab a separate reference to subs in case unsubscribe is called
				var currentSubs = subs;
				var value = converter(cmdList._0);
				for (var i = 0; i < currentSubs.length; i++)
				{
					currentSubs[i](value);
				}
				cmdList = cmdList._1;
			}
			return init;
		}

		effectManagers[name].init = init;
		effectManagers[name].onEffects = F3(onEffects);

		// PUBLIC API

		function subscribe(callback)
		{
			subs.push(callback);
		}

		function unsubscribe(callback)
		{
			// copy subs into a new array in case unsubscribe is called within a
			// subscribed callback
			subs = subs.slice();
			var index = subs.indexOf(callback);
			if (index >= 0)
			{
				subs.splice(index, 1);
			}
		}

		return {
			subscribe: subscribe,
			unsubscribe: unsubscribe
		};
	}


	// INCOMING PORTS

	function incomingPort(name, converter)
	{
		checkPortName(name);
		effectManagers[name] = {
			tag: 'sub',
			subMap: incomingPortMap,
			converter: converter,
			isForeign: true
		};
		return leaf(name);
	}

	var incomingPortMap = F2(function subMap(tagger, finalTagger)
	{
		return function(value)
		{
			return tagger(finalTagger(value));
		};
	});

	function setupIncomingPort(name, callback)
	{
		var sentBeforeInit = [];
		var subs = _elm_lang$core$Native_List.Nil;
		var converter = effectManagers[name].converter;
		var currentOnEffects = preInitOnEffects;
		var currentSend = preInitSend;

		// CREATE MANAGER

		var init = _elm_lang$core$Native_Scheduler.succeed(null);

		function preInitOnEffects(router, subList, state)
		{
			var postInitResult = postInitOnEffects(router, subList, state);

			for(var i = 0; i < sentBeforeInit.length; i++)
			{
				postInitSend(sentBeforeInit[i]);
			}

			sentBeforeInit = null; // to release objects held in queue
			currentSend = postInitSend;
			currentOnEffects = postInitOnEffects;
			return postInitResult;
		}

		function postInitOnEffects(router, subList, state)
		{
			subs = subList;
			return init;
		}

		function onEffects(router, subList, state)
		{
			return currentOnEffects(router, subList, state);
		}

		effectManagers[name].init = init;
		effectManagers[name].onEffects = F3(onEffects);

		// PUBLIC API

		function preInitSend(value)
		{
			sentBeforeInit.push(value);
		}

		function postInitSend(value)
		{
			var temp = subs;
			while (temp.ctor !== '[]')
			{
				callback(temp._0(value));
				temp = temp._1;
			}
		}

		function send(incomingValue)
		{
			var result = A2(_elm_lang$core$Json_Decode$decodeValue, converter, incomingValue);
			if (result.ctor === 'Err')
			{
				throw new Error('Trying to send an unexpected type of value through port `' + name + '`:\n' + result._0);
			}

			currentSend(result._0);
		}

		return { send: send };
	}

	return {
		// routers
		sendToApp: F2(sendToApp),
		sendToSelf: F2(sendToSelf),

		// global setup
		effectManagers: effectManagers,
		outgoingPort: outgoingPort,
		incomingPort: incomingPort,

		htmlToProgram: htmlToProgram,
		program: program,
		programWithFlags: programWithFlags,
		initialize: initialize,

		// effect bags
		leaf: leaf,
		batch: batch,
		map: F2(map)
	};

	}();

	var _elm_lang$core$Platform_Cmd$batch = _elm_lang$core$Native_Platform.batch;
	var _elm_lang$core$Platform_Cmd$none = _elm_lang$core$Platform_Cmd$batch(
		{ctor: '[]'});
	var _elm_lang$core$Platform_Cmd_ops = _elm_lang$core$Platform_Cmd_ops || {};
	_elm_lang$core$Platform_Cmd_ops['!'] = F2(
		function (model, commands) {
			return {
				ctor: '_Tuple2',
				_0: model,
				_1: _elm_lang$core$Platform_Cmd$batch(commands)
			};
		});
	var _elm_lang$core$Platform_Cmd$map = _elm_lang$core$Native_Platform.map;
	var _elm_lang$core$Platform_Cmd$Cmd = {ctor: 'Cmd'};

	var _elm_lang$core$Platform_Sub$batch = _elm_lang$core$Native_Platform.batch;
	var _elm_lang$core$Platform_Sub$none = _elm_lang$core$Platform_Sub$batch(
		{ctor: '[]'});
	var _elm_lang$core$Platform_Sub$map = _elm_lang$core$Native_Platform.map;
	var _elm_lang$core$Platform_Sub$Sub = {ctor: 'Sub'};

	var _elm_lang$core$Platform$hack = _elm_lang$core$Native_Scheduler.succeed;
	var _elm_lang$core$Platform$sendToSelf = _elm_lang$core$Native_Platform.sendToSelf;
	var _elm_lang$core$Platform$sendToApp = _elm_lang$core$Native_Platform.sendToApp;
	var _elm_lang$core$Platform$programWithFlags = _elm_lang$core$Native_Platform.programWithFlags;
	var _elm_lang$core$Platform$program = _elm_lang$core$Native_Platform.program;
	var _elm_lang$core$Platform$Program = {ctor: 'Program'};
	var _elm_lang$core$Platform$Task = {ctor: 'Task'};
	var _elm_lang$core$Platform$ProcessId = {ctor: 'ProcessId'};
	var _elm_lang$core$Platform$Router = {ctor: 'Router'};

	var _elm_lang$core$Task$onError = _elm_lang$core$Native_Scheduler.onError;
	var _elm_lang$core$Task$andThen = _elm_lang$core$Native_Scheduler.andThen;
	var _elm_lang$core$Task$spawnCmd = F2(
		function (router, _p0) {
			var _p1 = _p0;
			return _elm_lang$core$Native_Scheduler.spawn(
				A2(
					_elm_lang$core$Task$andThen,
					_elm_lang$core$Platform$sendToApp(router),
					_p1._0));
		});
	var _elm_lang$core$Task$fail = _elm_lang$core$Native_Scheduler.fail;
	var _elm_lang$core$Task$mapError = F2(
		function (convert, task) {
			return A2(
				_elm_lang$core$Task$onError,
				function (_p2) {
					return _elm_lang$core$Task$fail(
						convert(_p2));
				},
				task);
		});
	var _elm_lang$core$Task$succeed = _elm_lang$core$Native_Scheduler.succeed;
	var _elm_lang$core$Task$map = F2(
		function (func, taskA) {
			return A2(
				_elm_lang$core$Task$andThen,
				function (a) {
					return _elm_lang$core$Task$succeed(
						func(a));
				},
				taskA);
		});
	var _elm_lang$core$Task$map2 = F3(
		function (func, taskA, taskB) {
			return A2(
				_elm_lang$core$Task$andThen,
				function (a) {
					return A2(
						_elm_lang$core$Task$andThen,
						function (b) {
							return _elm_lang$core$Task$succeed(
								A2(func, a, b));
						},
						taskB);
				},
				taskA);
		});
	var _elm_lang$core$Task$map3 = F4(
		function (func, taskA, taskB, taskC) {
			return A2(
				_elm_lang$core$Task$andThen,
				function (a) {
					return A2(
						_elm_lang$core$Task$andThen,
						function (b) {
							return A2(
								_elm_lang$core$Task$andThen,
								function (c) {
									return _elm_lang$core$Task$succeed(
										A3(func, a, b, c));
								},
								taskC);
						},
						taskB);
				},
				taskA);
		});
	var _elm_lang$core$Task$map4 = F5(
		function (func, taskA, taskB, taskC, taskD) {
			return A2(
				_elm_lang$core$Task$andThen,
				function (a) {
					return A2(
						_elm_lang$core$Task$andThen,
						function (b) {
							return A2(
								_elm_lang$core$Task$andThen,
								function (c) {
									return A2(
										_elm_lang$core$Task$andThen,
										function (d) {
											return _elm_lang$core$Task$succeed(
												A4(func, a, b, c, d));
										},
										taskD);
								},
								taskC);
						},
						taskB);
				},
				taskA);
		});
	var _elm_lang$core$Task$map5 = F6(
		function (func, taskA, taskB, taskC, taskD, taskE) {
			return A2(
				_elm_lang$core$Task$andThen,
				function (a) {
					return A2(
						_elm_lang$core$Task$andThen,
						function (b) {
							return A2(
								_elm_lang$core$Task$andThen,
								function (c) {
									return A2(
										_elm_lang$core$Task$andThen,
										function (d) {
											return A2(
												_elm_lang$core$Task$andThen,
												function (e) {
													return _elm_lang$core$Task$succeed(
														A5(func, a, b, c, d, e));
												},
												taskE);
										},
										taskD);
								},
								taskC);
						},
						taskB);
				},
				taskA);
		});
	var _elm_lang$core$Task$sequence = function (tasks) {
		var _p3 = tasks;
		if (_p3.ctor === '[]') {
			return _elm_lang$core$Task$succeed(
				{ctor: '[]'});
		} else {
			return A3(
				_elm_lang$core$Task$map2,
				F2(
					function (x, y) {
						return {ctor: '::', _0: x, _1: y};
					}),
				_p3._0,
				_elm_lang$core$Task$sequence(_p3._1));
		}
	};
	var _elm_lang$core$Task$onEffects = F3(
		function (router, commands, state) {
			return A2(
				_elm_lang$core$Task$map,
				function (_p4) {
					return {ctor: '_Tuple0'};
				},
				_elm_lang$core$Task$sequence(
					A2(
						_elm_lang$core$List$map,
						_elm_lang$core$Task$spawnCmd(router),
						commands)));
		});
	var _elm_lang$core$Task$init = _elm_lang$core$Task$succeed(
		{ctor: '_Tuple0'});
	var _elm_lang$core$Task$onSelfMsg = F3(
		function (_p7, _p6, _p5) {
			return _elm_lang$core$Task$succeed(
				{ctor: '_Tuple0'});
		});
	var _elm_lang$core$Task$command = _elm_lang$core$Native_Platform.leaf('Task');
	var _elm_lang$core$Task$Perform = function (a) {
		return {ctor: 'Perform', _0: a};
	};
	var _elm_lang$core$Task$perform = F2(
		function (toMessage, task) {
			return _elm_lang$core$Task$command(
				_elm_lang$core$Task$Perform(
					A2(_elm_lang$core$Task$map, toMessage, task)));
		});
	var _elm_lang$core$Task$attempt = F2(
		function (resultToMessage, task) {
			return _elm_lang$core$Task$command(
				_elm_lang$core$Task$Perform(
					A2(
						_elm_lang$core$Task$onError,
						function (_p8) {
							return _elm_lang$core$Task$succeed(
								resultToMessage(
									_elm_lang$core$Result$Err(_p8)));
						},
						A2(
							_elm_lang$core$Task$andThen,
							function (_p9) {
								return _elm_lang$core$Task$succeed(
									resultToMessage(
										_elm_lang$core$Result$Ok(_p9)));
							},
							task))));
		});
	var _elm_lang$core$Task$cmdMap = F2(
		function (tagger, _p10) {
			var _p11 = _p10;
			return _elm_lang$core$Task$Perform(
				A2(_elm_lang$core$Task$map, tagger, _p11._0));
		});
	_elm_lang$core$Native_Platform.effectManagers['Task'] = {pkg: 'elm-lang/core', init: _elm_lang$core$Task$init, onEffects: _elm_lang$core$Task$onEffects, onSelfMsg: _elm_lang$core$Task$onSelfMsg, tag: 'cmd', cmdMap: _elm_lang$core$Task$cmdMap};

	var _elm_lang$core$Debug$crash = _elm_lang$core$Native_Debug.crash;
	var _elm_lang$core$Debug$log = _elm_lang$core$Native_Debug.log;

	var _elm_lang$core$Tuple$mapSecond = F2(
		function (func, _p0) {
			var _p1 = _p0;
			return {
				ctor: '_Tuple2',
				_0: _p1._0,
				_1: func(_p1._1)
			};
		});
	var _elm_lang$core$Tuple$mapFirst = F2(
		function (func, _p2) {
			var _p3 = _p2;
			return {
				ctor: '_Tuple2',
				_0: func(_p3._0),
				_1: _p3._1
			};
		});
	var _elm_lang$core$Tuple$second = function (_p4) {
		var _p5 = _p4;
		return _p5._1;
	};
	var _elm_lang$core$Tuple$first = function (_p6) {
		var _p7 = _p6;
		return _p7._0;
	};

	var _elm_lang$dom$Dom_LowLevel$onWindow = _elm_lang$dom$Native_Dom.onWindow;
	var _elm_lang$dom$Dom_LowLevel$onDocument = _elm_lang$dom$Native_Dom.onDocument;

	var _elm_lang$virtual_dom$VirtualDom_Debug$wrap;
	var _elm_lang$virtual_dom$VirtualDom_Debug$wrapWithFlags;

	var _elm_lang$virtual_dom$Native_VirtualDom = function() {

	var STYLE_KEY = 'STYLE';
	var EVENT_KEY = 'EVENT';
	var ATTR_KEY = 'ATTR';
	var ATTR_NS_KEY = 'ATTR_NS';

	var localDoc = typeof document !== 'undefined' ? document : {};


	////////////  VIRTUAL DOM NODES  ////////////


	function text(string)
	{
		return {
			type: 'text',
			text: string
		};
	}


	function node(tag)
	{
		return F2(function(factList, kidList) {
			return nodeHelp(tag, factList, kidList);
		});
	}


	function nodeHelp(tag, factList, kidList)
	{
		var organized = organizeFacts(factList);
		var namespace = organized.namespace;
		var facts = organized.facts;

		var children = [];
		var descendantsCount = 0;
		while (kidList.ctor !== '[]')
		{
			var kid = kidList._0;
			descendantsCount += (kid.descendantsCount || 0);
			children.push(kid);
			kidList = kidList._1;
		}
		descendantsCount += children.length;

		return {
			type: 'node',
			tag: tag,
			facts: facts,
			children: children,
			namespace: namespace,
			descendantsCount: descendantsCount
		};
	}


	function keyedNode(tag, factList, kidList)
	{
		var organized = organizeFacts(factList);
		var namespace = organized.namespace;
		var facts = organized.facts;

		var children = [];
		var descendantsCount = 0;
		while (kidList.ctor !== '[]')
		{
			var kid = kidList._0;
			descendantsCount += (kid._1.descendantsCount || 0);
			children.push(kid);
			kidList = kidList._1;
		}
		descendantsCount += children.length;

		return {
			type: 'keyed-node',
			tag: tag,
			facts: facts,
			children: children,
			namespace: namespace,
			descendantsCount: descendantsCount
		};
	}


	function custom(factList, model, impl)
	{
		var facts = organizeFacts(factList).facts;

		return {
			type: 'custom',
			facts: facts,
			model: model,
			impl: impl
		};
	}


	function map(tagger, node)
	{
		return {
			type: 'tagger',
			tagger: tagger,
			node: node,
			descendantsCount: 1 + (node.descendantsCount || 0)
		};
	}


	function thunk(func, args, thunk)
	{
		return {
			type: 'thunk',
			func: func,
			args: args,
			thunk: thunk,
			node: undefined
		};
	}

	function lazy(fn, a)
	{
		return thunk(fn, [a], function() {
			return fn(a);
		});
	}

	function lazy2(fn, a, b)
	{
		return thunk(fn, [a,b], function() {
			return A2(fn, a, b);
		});
	}

	function lazy3(fn, a, b, c)
	{
		return thunk(fn, [a,b,c], function() {
			return A3(fn, a, b, c);
		});
	}



	// FACTS


	function organizeFacts(factList)
	{
		var namespace, facts = {};

		while (factList.ctor !== '[]')
		{
			var entry = factList._0;
			var key = entry.key;

			if (key === ATTR_KEY || key === ATTR_NS_KEY || key === EVENT_KEY)
			{
				var subFacts = facts[key] || {};
				subFacts[entry.realKey] = entry.value;
				facts[key] = subFacts;
			}
			else if (key === STYLE_KEY)
			{
				var styles = facts[key] || {};
				var styleList = entry.value;
				while (styleList.ctor !== '[]')
				{
					var style = styleList._0;
					styles[style._0] = style._1;
					styleList = styleList._1;
				}
				facts[key] = styles;
			}
			else if (key === 'namespace')
			{
				namespace = entry.value;
			}
			else if (key === 'className')
			{
				var classes = facts[key];
				facts[key] = typeof classes === 'undefined'
					? entry.value
					: classes + ' ' + entry.value;
			}
	 		else
			{
				facts[key] = entry.value;
			}
			factList = factList._1;
		}

		return {
			facts: facts,
			namespace: namespace
		};
	}



	////////////  PROPERTIES AND ATTRIBUTES  ////////////


	function style(value)
	{
		return {
			key: STYLE_KEY,
			value: value
		};
	}


	function property(key, value)
	{
		return {
			key: key,
			value: value
		};
	}


	function attribute(key, value)
	{
		return {
			key: ATTR_KEY,
			realKey: key,
			value: value
		};
	}


	function attributeNS(namespace, key, value)
	{
		return {
			key: ATTR_NS_KEY,
			realKey: key,
			value: {
				value: value,
				namespace: namespace
			}
		};
	}


	function on(name, options, decoder)
	{
		return {
			key: EVENT_KEY,
			realKey: name,
			value: {
				options: options,
				decoder: decoder
			}
		};
	}


	function equalEvents(a, b)
	{
		if (a.options !== b.options)
		{
			if (a.options.stopPropagation !== b.options.stopPropagation || a.options.preventDefault !== b.options.preventDefault)
			{
				return false;
			}
		}
		return _elm_lang$core$Native_Json.equality(a.decoder, b.decoder);
	}


	function mapProperty(func, property)
	{
		if (property.key !== EVENT_KEY)
		{
			return property;
		}
		return on(
			property.realKey,
			property.value.options,
			A2(_elm_lang$core$Json_Decode$map, func, property.value.decoder)
		);
	}


	////////////  RENDER  ////////////


	function render(vNode, eventNode)
	{
		switch (vNode.type)
		{
			case 'thunk':
				if (!vNode.node)
				{
					vNode.node = vNode.thunk();
				}
				return render(vNode.node, eventNode);

			case 'tagger':
				var subNode = vNode.node;
				var tagger = vNode.tagger;

				while (subNode.type === 'tagger')
				{
					typeof tagger !== 'object'
						? tagger = [tagger, subNode.tagger]
						: tagger.push(subNode.tagger);

					subNode = subNode.node;
				}

				var subEventRoot = { tagger: tagger, parent: eventNode };
				var domNode = render(subNode, subEventRoot);
				domNode.elm_event_node_ref = subEventRoot;
				return domNode;

			case 'text':
				return localDoc.createTextNode(vNode.text);

			case 'node':
				var domNode = vNode.namespace
					? localDoc.createElementNS(vNode.namespace, vNode.tag)
					: localDoc.createElement(vNode.tag);

				applyFacts(domNode, eventNode, vNode.facts);

				var children = vNode.children;

				for (var i = 0; i < children.length; i++)
				{
					domNode.appendChild(render(children[i], eventNode));
				}

				return domNode;

			case 'keyed-node':
				var domNode = vNode.namespace
					? localDoc.createElementNS(vNode.namespace, vNode.tag)
					: localDoc.createElement(vNode.tag);

				applyFacts(domNode, eventNode, vNode.facts);

				var children = vNode.children;

				for (var i = 0; i < children.length; i++)
				{
					domNode.appendChild(render(children[i]._1, eventNode));
				}

				return domNode;

			case 'custom':
				var domNode = vNode.impl.render(vNode.model);
				applyFacts(domNode, eventNode, vNode.facts);
				return domNode;
		}
	}



	////////////  APPLY FACTS  ////////////


	function applyFacts(domNode, eventNode, facts)
	{
		for (var key in facts)
		{
			var value = facts[key];

			switch (key)
			{
				case STYLE_KEY:
					applyStyles(domNode, value);
					break;

				case EVENT_KEY:
					applyEvents(domNode, eventNode, value);
					break;

				case ATTR_KEY:
					applyAttrs(domNode, value);
					break;

				case ATTR_NS_KEY:
					applyAttrsNS(domNode, value);
					break;

				case 'value':
					if (domNode[key] !== value)
					{
						domNode[key] = value;
					}
					break;

				default:
					domNode[key] = value;
					break;
			}
		}
	}

	function applyStyles(domNode, styles)
	{
		var domNodeStyle = domNode.style;

		for (var key in styles)
		{
			domNodeStyle[key] = styles[key];
		}
	}

	function applyEvents(domNode, eventNode, events)
	{
		var allHandlers = domNode.elm_handlers || {};

		for (var key in events)
		{
			var handler = allHandlers[key];
			var value = events[key];

			if (typeof value === 'undefined')
			{
				domNode.removeEventListener(key, handler);
				allHandlers[key] = undefined;
			}
			else if (typeof handler === 'undefined')
			{
				var handler = makeEventHandler(eventNode, value);
				domNode.addEventListener(key, handler);
				allHandlers[key] = handler;
			}
			else
			{
				handler.info = value;
			}
		}

		domNode.elm_handlers = allHandlers;
	}

	function makeEventHandler(eventNode, info)
	{
		function eventHandler(event)
		{
			var info = eventHandler.info;

			var value = A2(_elm_lang$core$Native_Json.run, info.decoder, event);

			if (value.ctor === 'Ok')
			{
				var options = info.options;
				if (options.stopPropagation)
				{
					event.stopPropagation();
				}
				if (options.preventDefault)
				{
					event.preventDefault();
				}

				var message = value._0;

				var currentEventNode = eventNode;
				while (currentEventNode)
				{
					var tagger = currentEventNode.tagger;
					if (typeof tagger === 'function')
					{
						message = tagger(message);
					}
					else
					{
						for (var i = tagger.length; i--; )
						{
							message = tagger[i](message);
						}
					}
					currentEventNode = currentEventNode.parent;
				}
			}
		};

		eventHandler.info = info;

		return eventHandler;
	}

	function applyAttrs(domNode, attrs)
	{
		for (var key in attrs)
		{
			var value = attrs[key];
			if (typeof value === 'undefined')
			{
				domNode.removeAttribute(key);
			}
			else
			{
				domNode.setAttribute(key, value);
			}
		}
	}

	function applyAttrsNS(domNode, nsAttrs)
	{
		for (var key in nsAttrs)
		{
			var pair = nsAttrs[key];
			var namespace = pair.namespace;
			var value = pair.value;

			if (typeof value === 'undefined')
			{
				domNode.removeAttributeNS(namespace, key);
			}
			else
			{
				domNode.setAttributeNS(namespace, key, value);
			}
		}
	}



	////////////  DIFF  ////////////


	function diff(a, b)
	{
		var patches = [];
		diffHelp(a, b, patches, 0);
		return patches;
	}


	function makePatch(type, index, data)
	{
		return {
			index: index,
			type: type,
			data: data,
			domNode: undefined,
			eventNode: undefined
		};
	}


	function diffHelp(a, b, patches, index)
	{
		if (a === b)
		{
			return;
		}

		var aType = a.type;
		var bType = b.type;

		// Bail if you run into different types of nodes. Implies that the
		// structure has changed significantly and it's not worth a diff.
		if (aType !== bType)
		{
			patches.push(makePatch('p-redraw', index, b));
			return;
		}

		// Now we know that both nodes are the same type.
		switch (bType)
		{
			case 'thunk':
				var aArgs = a.args;
				var bArgs = b.args;
				var i = aArgs.length;
				var same = a.func === b.func && i === bArgs.length;
				while (same && i--)
				{
					same = aArgs[i] === bArgs[i];
				}
				if (same)
				{
					b.node = a.node;
					return;
				}
				b.node = b.thunk();
				var subPatches = [];
				diffHelp(a.node, b.node, subPatches, 0);
				if (subPatches.length > 0)
				{
					patches.push(makePatch('p-thunk', index, subPatches));
				}
				return;

			case 'tagger':
				// gather nested taggers
				var aTaggers = a.tagger;
				var bTaggers = b.tagger;
				var nesting = false;

				var aSubNode = a.node;
				while (aSubNode.type === 'tagger')
				{
					nesting = true;

					typeof aTaggers !== 'object'
						? aTaggers = [aTaggers, aSubNode.tagger]
						: aTaggers.push(aSubNode.tagger);

					aSubNode = aSubNode.node;
				}

				var bSubNode = b.node;
				while (bSubNode.type === 'tagger')
				{
					nesting = true;

					typeof bTaggers !== 'object'
						? bTaggers = [bTaggers, bSubNode.tagger]
						: bTaggers.push(bSubNode.tagger);

					bSubNode = bSubNode.node;
				}

				// Just bail if different numbers of taggers. This implies the
				// structure of the virtual DOM has changed.
				if (nesting && aTaggers.length !== bTaggers.length)
				{
					patches.push(makePatch('p-redraw', index, b));
					return;
				}

				// check if taggers are "the same"
				if (nesting ? !pairwiseRefEqual(aTaggers, bTaggers) : aTaggers !== bTaggers)
				{
					patches.push(makePatch('p-tagger', index, bTaggers));
				}

				// diff everything below the taggers
				diffHelp(aSubNode, bSubNode, patches, index + 1);
				return;

			case 'text':
				if (a.text !== b.text)
				{
					patches.push(makePatch('p-text', index, b.text));
					return;
				}

				return;

			case 'node':
				// Bail if obvious indicators have changed. Implies more serious
				// structural changes such that it's not worth it to diff.
				if (a.tag !== b.tag || a.namespace !== b.namespace)
				{
					patches.push(makePatch('p-redraw', index, b));
					return;
				}

				var factsDiff = diffFacts(a.facts, b.facts);

				if (typeof factsDiff !== 'undefined')
				{
					patches.push(makePatch('p-facts', index, factsDiff));
				}

				diffChildren(a, b, patches, index);
				return;

			case 'keyed-node':
				// Bail if obvious indicators have changed. Implies more serious
				// structural changes such that it's not worth it to diff.
				if (a.tag !== b.tag || a.namespace !== b.namespace)
				{
					patches.push(makePatch('p-redraw', index, b));
					return;
				}

				var factsDiff = diffFacts(a.facts, b.facts);

				if (typeof factsDiff !== 'undefined')
				{
					patches.push(makePatch('p-facts', index, factsDiff));
				}

				diffKeyedChildren(a, b, patches, index);
				return;

			case 'custom':
				if (a.impl !== b.impl)
				{
					patches.push(makePatch('p-redraw', index, b));
					return;
				}

				var factsDiff = diffFacts(a.facts, b.facts);
				if (typeof factsDiff !== 'undefined')
				{
					patches.push(makePatch('p-facts', index, factsDiff));
				}

				var patch = b.impl.diff(a,b);
				if (patch)
				{
					patches.push(makePatch('p-custom', index, patch));
					return;
				}

				return;
		}
	}


	// assumes the incoming arrays are the same length
	function pairwiseRefEqual(as, bs)
	{
		for (var i = 0; i < as.length; i++)
		{
			if (as[i] !== bs[i])
			{
				return false;
			}
		}

		return true;
	}


	// TODO Instead of creating a new diff object, it's possible to just test if
	// there *is* a diff. During the actual patch, do the diff again and make the
	// modifications directly. This way, there's no new allocations. Worth it?
	function diffFacts(a, b, category)
	{
		var diff;

		// look for changes and removals
		for (var aKey in a)
		{
			if (aKey === STYLE_KEY || aKey === EVENT_KEY || aKey === ATTR_KEY || aKey === ATTR_NS_KEY)
			{
				var subDiff = diffFacts(a[aKey], b[aKey] || {}, aKey);
				if (subDiff)
				{
					diff = diff || {};
					diff[aKey] = subDiff;
				}
				continue;
			}

			// remove if not in the new facts
			if (!(aKey in b))
			{
				diff = diff || {};
				diff[aKey] =
					(typeof category === 'undefined')
						? (typeof a[aKey] === 'string' ? '' : null)
						:
					(category === STYLE_KEY)
						? ''
						:
					(category === EVENT_KEY || category === ATTR_KEY)
						? undefined
						:
					{ namespace: a[aKey].namespace, value: undefined };

				continue;
			}

			var aValue = a[aKey];
			var bValue = b[aKey];

			// reference equal, so don't worry about it
			if (aValue === bValue && aKey !== 'value'
				|| category === EVENT_KEY && equalEvents(aValue, bValue))
			{
				continue;
			}

			diff = diff || {};
			diff[aKey] = bValue;
		}

		// add new stuff
		for (var bKey in b)
		{
			if (!(bKey in a))
			{
				diff = diff || {};
				diff[bKey] = b[bKey];
			}
		}

		return diff;
	}


	function diffChildren(aParent, bParent, patches, rootIndex)
	{
		var aChildren = aParent.children;
		var bChildren = bParent.children;

		var aLen = aChildren.length;
		var bLen = bChildren.length;

		// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

		if (aLen > bLen)
		{
			patches.push(makePatch('p-remove-last', rootIndex, aLen - bLen));
		}
		else if (aLen < bLen)
		{
			patches.push(makePatch('p-append', rootIndex, bChildren.slice(aLen)));
		}

		// PAIRWISE DIFF EVERYTHING ELSE

		var index = rootIndex;
		var minLen = aLen < bLen ? aLen : bLen;
		for (var i = 0; i < minLen; i++)
		{
			index++;
			var aChild = aChildren[i];
			diffHelp(aChild, bChildren[i], patches, index);
			index += aChild.descendantsCount || 0;
		}
	}



	////////////  KEYED DIFF  ////////////


	function diffKeyedChildren(aParent, bParent, patches, rootIndex)
	{
		var localPatches = [];

		var changes = {}; // Dict String Entry
		var inserts = []; // Array { index : Int, entry : Entry }
		// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

		var aChildren = aParent.children;
		var bChildren = bParent.children;
		var aLen = aChildren.length;
		var bLen = bChildren.length;
		var aIndex = 0;
		var bIndex = 0;

		var index = rootIndex;

		while (aIndex < aLen && bIndex < bLen)
		{
			var a = aChildren[aIndex];
			var b = bChildren[bIndex];

			var aKey = a._0;
			var bKey = b._0;
			var aNode = a._1;
			var bNode = b._1;

			// check if keys match

			if (aKey === bKey)
			{
				index++;
				diffHelp(aNode, bNode, localPatches, index);
				index += aNode.descendantsCount || 0;

				aIndex++;
				bIndex++;
				continue;
			}

			// look ahead 1 to detect insertions and removals.

			var aLookAhead = aIndex + 1 < aLen;
			var bLookAhead = bIndex + 1 < bLen;

			if (aLookAhead)
			{
				var aNext = aChildren[aIndex + 1];
				var aNextKey = aNext._0;
				var aNextNode = aNext._1;
				var oldMatch = bKey === aNextKey;
			}

			if (bLookAhead)
			{
				var bNext = bChildren[bIndex + 1];
				var bNextKey = bNext._0;
				var bNextNode = bNext._1;
				var newMatch = aKey === bNextKey;
			}


			// swap a and b
			if (aLookAhead && bLookAhead && newMatch && oldMatch)
			{
				index++;
				diffHelp(aNode, bNextNode, localPatches, index);
				insertNode(changes, localPatches, aKey, bNode, bIndex, inserts);
				index += aNode.descendantsCount || 0;

				index++;
				removeNode(changes, localPatches, aKey, aNextNode, index);
				index += aNextNode.descendantsCount || 0;

				aIndex += 2;
				bIndex += 2;
				continue;
			}

			// insert b
			if (bLookAhead && newMatch)
			{
				index++;
				insertNode(changes, localPatches, bKey, bNode, bIndex, inserts);
				diffHelp(aNode, bNextNode, localPatches, index);
				index += aNode.descendantsCount || 0;

				aIndex += 1;
				bIndex += 2;
				continue;
			}

			// remove a
			if (aLookAhead && oldMatch)
			{
				index++;
				removeNode(changes, localPatches, aKey, aNode, index);
				index += aNode.descendantsCount || 0;

				index++;
				diffHelp(aNextNode, bNode, localPatches, index);
				index += aNextNode.descendantsCount || 0;

				aIndex += 2;
				bIndex += 1;
				continue;
			}

			// remove a, insert b
			if (aLookAhead && bLookAhead && aNextKey === bNextKey)
			{
				index++;
				removeNode(changes, localPatches, aKey, aNode, index);
				insertNode(changes, localPatches, bKey, bNode, bIndex, inserts);
				index += aNode.descendantsCount || 0;

				index++;
				diffHelp(aNextNode, bNextNode, localPatches, index);
				index += aNextNode.descendantsCount || 0;

				aIndex += 2;
				bIndex += 2;
				continue;
			}

			break;
		}

		// eat up any remaining nodes with removeNode and insertNode

		while (aIndex < aLen)
		{
			index++;
			var a = aChildren[aIndex];
			var aNode = a._1;
			removeNode(changes, localPatches, a._0, aNode, index);
			index += aNode.descendantsCount || 0;
			aIndex++;
		}

		var endInserts;
		while (bIndex < bLen)
		{
			endInserts = endInserts || [];
			var b = bChildren[bIndex];
			insertNode(changes, localPatches, b._0, b._1, undefined, endInserts);
			bIndex++;
		}

		if (localPatches.length > 0 || inserts.length > 0 || typeof endInserts !== 'undefined')
		{
			patches.push(makePatch('p-reorder', rootIndex, {
				patches: localPatches,
				inserts: inserts,
				endInserts: endInserts
			}));
		}
	}



	////////////  CHANGES FROM KEYED DIFF  ////////////


	var POSTFIX = '_elmW6BL';


	function insertNode(changes, localPatches, key, vnode, bIndex, inserts)
	{
		var entry = changes[key];

		// never seen this key before
		if (typeof entry === 'undefined')
		{
			entry = {
				tag: 'insert',
				vnode: vnode,
				index: bIndex,
				data: undefined
			};

			inserts.push({ index: bIndex, entry: entry });
			changes[key] = entry;

			return;
		}

		// this key was removed earlier, a match!
		if (entry.tag === 'remove')
		{
			inserts.push({ index: bIndex, entry: entry });

			entry.tag = 'move';
			var subPatches = [];
			diffHelp(entry.vnode, vnode, subPatches, entry.index);
			entry.index = bIndex;
			entry.data.data = {
				patches: subPatches,
				entry: entry
			};

			return;
		}

		// this key has already been inserted or moved, a duplicate!
		insertNode(changes, localPatches, key + POSTFIX, vnode, bIndex, inserts);
	}


	function removeNode(changes, localPatches, key, vnode, index)
	{
		var entry = changes[key];

		// never seen this key before
		if (typeof entry === 'undefined')
		{
			var patch = makePatch('p-remove', index, undefined);
			localPatches.push(patch);

			changes[key] = {
				tag: 'remove',
				vnode: vnode,
				index: index,
				data: patch
			};

			return;
		}

		// this key was inserted earlier, a match!
		if (entry.tag === 'insert')
		{
			entry.tag = 'move';
			var subPatches = [];
			diffHelp(vnode, entry.vnode, subPatches, index);

			var patch = makePatch('p-remove', index, {
				patches: subPatches,
				entry: entry
			});
			localPatches.push(patch);

			return;
		}

		// this key has already been removed or moved, a duplicate!
		removeNode(changes, localPatches, key + POSTFIX, vnode, index);
	}



	////////////  ADD DOM NODES  ////////////
	//
	// Each DOM node has an "index" assigned in order of traversal. It is important
	// to minimize our crawl over the actual DOM, so these indexes (along with the
	// descendantsCount of virtual nodes) let us skip touching entire subtrees of
	// the DOM if we know there are no patches there.


	function addDomNodes(domNode, vNode, patches, eventNode)
	{
		addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.descendantsCount, eventNode);
	}


	// assumes `patches` is non-empty and indexes increase monotonically.
	function addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
	{
		var patch = patches[i];
		var index = patch.index;

		while (index === low)
		{
			var patchType = patch.type;

			if (patchType === 'p-thunk')
			{
				addDomNodes(domNode, vNode.node, patch.data, eventNode);
			}
			else if (patchType === 'p-reorder')
			{
				patch.domNode = domNode;
				patch.eventNode = eventNode;

				var subPatches = patch.data.patches;
				if (subPatches.length > 0)
				{
					addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
			else if (patchType === 'p-remove')
			{
				patch.domNode = domNode;
				patch.eventNode = eventNode;

				var data = patch.data;
				if (typeof data !== 'undefined')
				{
					data.entry.data = domNode;
					var subPatches = data.patches;
					if (subPatches.length > 0)
					{
						addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
					}
				}
			}
			else
			{
				patch.domNode = domNode;
				patch.eventNode = eventNode;
			}

			i++;

			if (!(patch = patches[i]) || (index = patch.index) > high)
			{
				return i;
			}
		}

		switch (vNode.type)
		{
			case 'tagger':
				var subNode = vNode.node;

				while (subNode.type === "tagger")
				{
					subNode = subNode.node;
				}

				return addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);

			case 'node':
				var vChildren = vNode.children;
				var childNodes = domNode.childNodes;
				for (var j = 0; j < vChildren.length; j++)
				{
					low++;
					var vChild = vChildren[j];
					var nextLow = low + (vChild.descendantsCount || 0);
					if (low <= index && index <= nextLow)
					{
						i = addDomNodesHelp(childNodes[j], vChild, patches, i, low, nextLow, eventNode);
						if (!(patch = patches[i]) || (index = patch.index) > high)
						{
							return i;
						}
					}
					low = nextLow;
				}
				return i;

			case 'keyed-node':
				var vChildren = vNode.children;
				var childNodes = domNode.childNodes;
				for (var j = 0; j < vChildren.length; j++)
				{
					low++;
					var vChild = vChildren[j]._1;
					var nextLow = low + (vChild.descendantsCount || 0);
					if (low <= index && index <= nextLow)
					{
						i = addDomNodesHelp(childNodes[j], vChild, patches, i, low, nextLow, eventNode);
						if (!(patch = patches[i]) || (index = patch.index) > high)
						{
							return i;
						}
					}
					low = nextLow;
				}
				return i;

			case 'text':
			case 'thunk':
				throw new Error('should never traverse `text` or `thunk` nodes like this');
		}
	}



	////////////  APPLY PATCHES  ////////////


	function applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
	{
		if (patches.length === 0)
		{
			return rootDomNode;
		}

		addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
		return applyPatchesHelp(rootDomNode, patches);
	}

	function applyPatchesHelp(rootDomNode, patches)
	{
		for (var i = 0; i < patches.length; i++)
		{
			var patch = patches[i];
			var localDomNode = patch.domNode
			var newNode = applyPatch(localDomNode, patch);
			if (localDomNode === rootDomNode)
			{
				rootDomNode = newNode;
			}
		}
		return rootDomNode;
	}

	function applyPatch(domNode, patch)
	{
		switch (patch.type)
		{
			case 'p-redraw':
				return applyPatchRedraw(domNode, patch.data, patch.eventNode);

			case 'p-facts':
				applyFacts(domNode, patch.eventNode, patch.data);
				return domNode;

			case 'p-text':
				domNode.replaceData(0, domNode.length, patch.data);
				return domNode;

			case 'p-thunk':
				return applyPatchesHelp(domNode, patch.data);

			case 'p-tagger':
				if (typeof domNode.elm_event_node_ref !== 'undefined')
				{
					domNode.elm_event_node_ref.tagger = patch.data;
				}
				else
				{
					domNode.elm_event_node_ref = { tagger: patch.data, parent: patch.eventNode };
				}
				return domNode;

			case 'p-remove-last':
				var i = patch.data;
				while (i--)
				{
					domNode.removeChild(domNode.lastChild);
				}
				return domNode;

			case 'p-append':
				var newNodes = patch.data;
				for (var i = 0; i < newNodes.length; i++)
				{
					domNode.appendChild(render(newNodes[i], patch.eventNode));
				}
				return domNode;

			case 'p-remove':
				var data = patch.data;
				if (typeof data === 'undefined')
				{
					domNode.parentNode.removeChild(domNode);
					return domNode;
				}
				var entry = data.entry;
				if (typeof entry.index !== 'undefined')
				{
					domNode.parentNode.removeChild(domNode);
				}
				entry.data = applyPatchesHelp(domNode, data.patches);
				return domNode;

			case 'p-reorder':
				return applyPatchReorder(domNode, patch);

			case 'p-custom':
				var impl = patch.data;
				return impl.applyPatch(domNode, impl.data);

			default:
				throw new Error('Ran into an unknown patch!');
		}
	}


	function applyPatchRedraw(domNode, vNode, eventNode)
	{
		var parentNode = domNode.parentNode;
		var newNode = render(vNode, eventNode);

		if (typeof newNode.elm_event_node_ref === 'undefined')
		{
			newNode.elm_event_node_ref = domNode.elm_event_node_ref;
		}

		if (parentNode && newNode !== domNode)
		{
			parentNode.replaceChild(newNode, domNode);
		}
		return newNode;
	}


	function applyPatchReorder(domNode, patch)
	{
		var data = patch.data;

		// remove end inserts
		var frag = applyPatchReorderEndInsertsHelp(data.endInserts, patch);

		// removals
		domNode = applyPatchesHelp(domNode, data.patches);

		// inserts
		var inserts = data.inserts;
		for (var i = 0; i < inserts.length; i++)
		{
			var insert = inserts[i];
			var entry = insert.entry;
			var node = entry.tag === 'move'
				? entry.data
				: render(entry.vnode, patch.eventNode);
			domNode.insertBefore(node, domNode.childNodes[insert.index]);
		}

		// add end inserts
		if (typeof frag !== 'undefined')
		{
			domNode.appendChild(frag);
		}

		return domNode;
	}


	function applyPatchReorderEndInsertsHelp(endInserts, patch)
	{
		if (typeof endInserts === 'undefined')
		{
			return;
		}

		var frag = localDoc.createDocumentFragment();
		for (var i = 0; i < endInserts.length; i++)
		{
			var insert = endInserts[i];
			var entry = insert.entry;
			frag.appendChild(entry.tag === 'move'
				? entry.data
				: render(entry.vnode, patch.eventNode)
			);
		}
		return frag;
	}


	// PROGRAMS

	var program = makeProgram(checkNoFlags);
	var programWithFlags = makeProgram(checkYesFlags);

	function makeProgram(flagChecker)
	{
		return F2(function(debugWrap, impl)
		{
			return function(flagDecoder)
			{
				return function(object, moduleName, debugMetadata)
				{
					var checker = flagChecker(flagDecoder, moduleName);
					if (typeof debugMetadata === 'undefined')
					{
						normalSetup(impl, object, moduleName, checker);
					}
					else
					{
						debugSetup(A2(debugWrap, debugMetadata, impl), object, moduleName, checker);
					}
				};
			};
		});
	}

	function staticProgram(vNode)
	{
		var nothing = _elm_lang$core$Native_Utils.Tuple2(
			_elm_lang$core$Native_Utils.Tuple0,
			_elm_lang$core$Platform_Cmd$none
		);
		return A2(program, _elm_lang$virtual_dom$VirtualDom_Debug$wrap, {
			init: nothing,
			view: function() { return vNode; },
			update: F2(function() { return nothing; }),
			subscriptions: function() { return _elm_lang$core$Platform_Sub$none; }
		})();
	}


	// FLAG CHECKERS

	function checkNoFlags(flagDecoder, moduleName)
	{
		return function(init, flags, domNode)
		{
			if (typeof flags === 'undefined')
			{
				return init;
			}

			var errorMessage =
				'The `' + moduleName + '` module does not need flags.\n'
				+ 'Initialize it with no arguments and you should be all set!';

			crash(errorMessage, domNode);
		};
	}

	function checkYesFlags(flagDecoder, moduleName)
	{
		return function(init, flags, domNode)
		{
			if (typeof flagDecoder === 'undefined')
			{
				var errorMessage =
					'Are you trying to sneak a Never value into Elm? Trickster!\n'
					+ 'It looks like ' + moduleName + '.main is defined with `programWithFlags` but has type `Program Never`.\n'
					+ 'Use `program` instead if you do not want flags.'

				crash(errorMessage, domNode);
			}

			var result = A2(_elm_lang$core$Native_Json.run, flagDecoder, flags);
			if (result.ctor === 'Ok')
			{
				return init(result._0);
			}

			var errorMessage =
				'Trying to initialize the `' + moduleName + '` module with an unexpected flag.\n'
				+ 'I tried to convert it to an Elm value, but ran into this problem:\n\n'
				+ result._0;

			crash(errorMessage, domNode);
		};
	}

	function crash(errorMessage, domNode)
	{
		if (domNode)
		{
			domNode.innerHTML =
				'<div style="padding-left:1em;">'
				+ '<h2 style="font-weight:normal;"><b>Oops!</b> Something went wrong when starting your Elm program.</h2>'
				+ '<pre style="padding-left:1em;">' + errorMessage + '</pre>'
				+ '</div>';
		}

		throw new Error(errorMessage);
	}


	//  NORMAL SETUP

	function normalSetup(impl, object, moduleName, flagChecker)
	{
		object['embed'] = function embed(node, flags)
		{
			while (node.lastChild)
			{
				node.removeChild(node.lastChild);
			}

			return _elm_lang$core$Native_Platform.initialize(
				flagChecker(impl.init, flags, node),
				impl.update,
				impl.subscriptions,
				normalRenderer(node, impl.view)
			);
		};

		object['fullscreen'] = function fullscreen(flags)
		{
			return _elm_lang$core$Native_Platform.initialize(
				flagChecker(impl.init, flags, document.body),
				impl.update,
				impl.subscriptions,
				normalRenderer(document.body, impl.view)
			);
		};
	}

	function normalRenderer(parentNode, view)
	{
		return function(tagger, initialModel)
		{
			var eventNode = { tagger: tagger, parent: undefined };
			var initialVirtualNode = view(initialModel);
			var domNode = render(initialVirtualNode, eventNode);
			parentNode.appendChild(domNode);
			return makeStepper(domNode, view, initialVirtualNode, eventNode);
		};
	}


	// STEPPER

	var rAF =
		typeof requestAnimationFrame !== 'undefined'
			? requestAnimationFrame
			: function(callback) { setTimeout(callback, 1000 / 60); };

	function makeStepper(domNode, view, initialVirtualNode, eventNode)
	{
		var state = 'NO_REQUEST';
		var currNode = initialVirtualNode;
		var nextModel;

		function updateIfNeeded()
		{
			switch (state)
			{
				case 'NO_REQUEST':
					throw new Error(
						'Unexpected draw callback.\n' +
						'Please report this to <https://github.com/elm-lang/virtual-dom/issues>.'
					);

				case 'PENDING_REQUEST':
					rAF(updateIfNeeded);
					state = 'EXTRA_REQUEST';

					var nextNode = view(nextModel);
					var patches = diff(currNode, nextNode);
					domNode = applyPatches(domNode, currNode, patches, eventNode);
					currNode = nextNode;

					return;

				case 'EXTRA_REQUEST':
					state = 'NO_REQUEST';
					return;
			}
		}

		return function stepper(model)
		{
			if (state === 'NO_REQUEST')
			{
				rAF(updateIfNeeded);
			}
			state = 'PENDING_REQUEST';
			nextModel = model;
		};
	}


	// DEBUG SETUP

	function debugSetup(impl, object, moduleName, flagChecker)
	{
		object['fullscreen'] = function fullscreen(flags)
		{
			var popoutRef = { doc: undefined };
			return _elm_lang$core$Native_Platform.initialize(
				flagChecker(impl.init, flags, document.body),
				impl.update(scrollTask(popoutRef)),
				impl.subscriptions,
				debugRenderer(moduleName, document.body, popoutRef, impl.view, impl.viewIn, impl.viewOut)
			);
		};

		object['embed'] = function fullscreen(node, flags)
		{
			var popoutRef = { doc: undefined };
			return _elm_lang$core$Native_Platform.initialize(
				flagChecker(impl.init, flags, node),
				impl.update(scrollTask(popoutRef)),
				impl.subscriptions,
				debugRenderer(moduleName, node, popoutRef, impl.view, impl.viewIn, impl.viewOut)
			);
		};
	}

	function scrollTask(popoutRef)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			var doc = popoutRef.doc;
			if (doc)
			{
				var msgs = doc.getElementsByClassName('debugger-sidebar-messages')[0];
				if (msgs)
				{
					msgs.scrollTop = msgs.scrollHeight;
				}
			}
			callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
		});
	}


	function debugRenderer(moduleName, parentNode, popoutRef, view, viewIn, viewOut)
	{
		return function(tagger, initialModel)
		{
			var appEventNode = { tagger: tagger, parent: undefined };
			var eventNode = { tagger: tagger, parent: undefined };

			// make normal stepper
			var appVirtualNode = view(initialModel);
			var appNode = render(appVirtualNode, appEventNode);
			parentNode.appendChild(appNode);
			var appStepper = makeStepper(appNode, view, appVirtualNode, appEventNode);

			// make overlay stepper
			var overVirtualNode = viewIn(initialModel)._1;
			var overNode = render(overVirtualNode, eventNode);
			parentNode.appendChild(overNode);
			var wrappedViewIn = wrapViewIn(appEventNode, overNode, viewIn);
			var overStepper = makeStepper(overNode, wrappedViewIn, overVirtualNode, eventNode);

			// make debugger stepper
			var debugStepper = makeDebugStepper(initialModel, viewOut, eventNode, parentNode, moduleName, popoutRef);

			return function stepper(model)
			{
				appStepper(model);
				overStepper(model);
				debugStepper(model);
			}
		};
	}

	function makeDebugStepper(initialModel, view, eventNode, parentNode, moduleName, popoutRef)
	{
		var curr;
		var domNode;

		return function stepper(model)
		{
			if (!model.isDebuggerOpen)
			{
				return;
			}

			if (!popoutRef.doc)
			{
				curr = view(model);
				domNode = openDebugWindow(moduleName, popoutRef, curr, eventNode);
				return;
			}

			// switch to document of popout
			localDoc = popoutRef.doc;

			var next = view(model);
			var patches = diff(curr, next);
			domNode = applyPatches(domNode, curr, patches, eventNode);
			curr = next;

			// switch back to normal document
			localDoc = document;
		};
	}

	function openDebugWindow(moduleName, popoutRef, virtualNode, eventNode)
	{
		var w = 900;
		var h = 360;
		var x = screen.width - w;
		var y = screen.height - h;
		var debugWindow = window.open('', '', 'width=' + w + ',height=' + h + ',left=' + x + ',top=' + y);

		// switch to window document
		localDoc = debugWindow.document;

		popoutRef.doc = localDoc;
		localDoc.title = 'Debugger - ' + moduleName;
		localDoc.body.style.margin = '0';
		localDoc.body.style.padding = '0';
		var domNode = render(virtualNode, eventNode);
		localDoc.body.appendChild(domNode);

		localDoc.addEventListener('keydown', function(event) {
			if (event.metaKey && event.which === 82)
			{
				window.location.reload();
			}
			if (event.which === 38)
			{
				eventNode.tagger({ ctor: 'Up' });
				event.preventDefault();
			}
			if (event.which === 40)
			{
				eventNode.tagger({ ctor: 'Down' });
				event.preventDefault();
			}
		});

		function close()
		{
			popoutRef.doc = undefined;
			debugWindow.close();
		}
		window.addEventListener('unload', close);
		debugWindow.addEventListener('unload', function() {
			popoutRef.doc = undefined;
			window.removeEventListener('unload', close);
			eventNode.tagger({ ctor: 'Close' });
		});

		// switch back to the normal document
		localDoc = document;

		return domNode;
	}


	// BLOCK EVENTS

	function wrapViewIn(appEventNode, overlayNode, viewIn)
	{
		var ignorer = makeIgnorer(overlayNode);
		var blocking = 'Normal';
		var overflow;

		var normalTagger = appEventNode.tagger;
		var blockTagger = function() {};

		return function(model)
		{
			var tuple = viewIn(model);
			var newBlocking = tuple._0.ctor;
			appEventNode.tagger = newBlocking === 'Normal' ? normalTagger : blockTagger;
			if (blocking !== newBlocking)
			{
				traverse('removeEventListener', ignorer, blocking);
				traverse('addEventListener', ignorer, newBlocking);

				if (blocking === 'Normal')
				{
					overflow = document.body.style.overflow;
					document.body.style.overflow = 'hidden';
				}

				if (newBlocking === 'Normal')
				{
					document.body.style.overflow = overflow;
				}

				blocking = newBlocking;
			}
			return tuple._1;
		}
	}

	function traverse(verbEventListener, ignorer, blocking)
	{
		switch(blocking)
		{
			case 'Normal':
				return;

			case 'Pause':
				return traverseHelp(verbEventListener, ignorer, mostEvents);

			case 'Message':
				return traverseHelp(verbEventListener, ignorer, allEvents);
		}
	}

	function traverseHelp(verbEventListener, handler, eventNames)
	{
		for (var i = 0; i < eventNames.length; i++)
		{
			document.body[verbEventListener](eventNames[i], handler, true);
		}
	}

	function makeIgnorer(overlayNode)
	{
		return function(event)
		{
			if (event.type === 'keydown' && event.metaKey && event.which === 82)
			{
				return;
			}

			var isScroll = event.type === 'scroll' || event.type === 'wheel';

			var node = event.target;
			while (node !== null)
			{
				if (node.className === 'elm-overlay-message-details' && isScroll)
				{
					return;
				}

				if (node === overlayNode && !isScroll)
				{
					return;
				}
				node = node.parentNode;
			}

			event.stopPropagation();
			event.preventDefault();
		}
	}

	var mostEvents = [
		'click', 'dblclick', 'mousemove',
		'mouseup', 'mousedown', 'mouseenter', 'mouseleave',
		'touchstart', 'touchend', 'touchcancel', 'touchmove',
		'pointerdown', 'pointerup', 'pointerover', 'pointerout',
		'pointerenter', 'pointerleave', 'pointermove', 'pointercancel',
		'dragstart', 'drag', 'dragend', 'dragenter', 'dragover', 'dragleave', 'drop',
		'keyup', 'keydown', 'keypress',
		'input', 'change',
		'focus', 'blur'
	];

	var allEvents = mostEvents.concat('wheel', 'scroll');


	return {
		node: node,
		text: text,
		custom: custom,
		map: F2(map),

		on: F3(on),
		style: style,
		property: F2(property),
		attribute: F2(attribute),
		attributeNS: F3(attributeNS),
		mapProperty: F2(mapProperty),

		lazy: F2(lazy),
		lazy2: F3(lazy2),
		lazy3: F4(lazy3),
		keyedNode: F3(keyedNode),

		program: program,
		programWithFlags: programWithFlags,
		staticProgram: staticProgram
	};

	}();

	var _elm_lang$virtual_dom$VirtualDom$programWithFlags = function (impl) {
		return A2(_elm_lang$virtual_dom$Native_VirtualDom.programWithFlags, _elm_lang$virtual_dom$VirtualDom_Debug$wrapWithFlags, impl);
	};
	var _elm_lang$virtual_dom$VirtualDom$program = function (impl) {
		return A2(_elm_lang$virtual_dom$Native_VirtualDom.program, _elm_lang$virtual_dom$VirtualDom_Debug$wrap, impl);
	};
	var _elm_lang$virtual_dom$VirtualDom$keyedNode = _elm_lang$virtual_dom$Native_VirtualDom.keyedNode;
	var _elm_lang$virtual_dom$VirtualDom$lazy3 = _elm_lang$virtual_dom$Native_VirtualDom.lazy3;
	var _elm_lang$virtual_dom$VirtualDom$lazy2 = _elm_lang$virtual_dom$Native_VirtualDom.lazy2;
	var _elm_lang$virtual_dom$VirtualDom$lazy = _elm_lang$virtual_dom$Native_VirtualDom.lazy;
	var _elm_lang$virtual_dom$VirtualDom$defaultOptions = {stopPropagation: false, preventDefault: false};
	var _elm_lang$virtual_dom$VirtualDom$onWithOptions = _elm_lang$virtual_dom$Native_VirtualDom.on;
	var _elm_lang$virtual_dom$VirtualDom$on = F2(
		function (eventName, decoder) {
			return A3(_elm_lang$virtual_dom$VirtualDom$onWithOptions, eventName, _elm_lang$virtual_dom$VirtualDom$defaultOptions, decoder);
		});
	var _elm_lang$virtual_dom$VirtualDom$style = _elm_lang$virtual_dom$Native_VirtualDom.style;
	var _elm_lang$virtual_dom$VirtualDom$mapProperty = _elm_lang$virtual_dom$Native_VirtualDom.mapProperty;
	var _elm_lang$virtual_dom$VirtualDom$attributeNS = _elm_lang$virtual_dom$Native_VirtualDom.attributeNS;
	var _elm_lang$virtual_dom$VirtualDom$attribute = _elm_lang$virtual_dom$Native_VirtualDom.attribute;
	var _elm_lang$virtual_dom$VirtualDom$property = _elm_lang$virtual_dom$Native_VirtualDom.property;
	var _elm_lang$virtual_dom$VirtualDom$map = _elm_lang$virtual_dom$Native_VirtualDom.map;
	var _elm_lang$virtual_dom$VirtualDom$text = _elm_lang$virtual_dom$Native_VirtualDom.text;
	var _elm_lang$virtual_dom$VirtualDom$node = _elm_lang$virtual_dom$Native_VirtualDom.node;
	var _elm_lang$virtual_dom$VirtualDom$Options = F2(
		function (a, b) {
			return {stopPropagation: a, preventDefault: b};
		});
	var _elm_lang$virtual_dom$VirtualDom$Node = {ctor: 'Node'};
	var _elm_lang$virtual_dom$VirtualDom$Property = {ctor: 'Property'};

	var _elm_lang$html$Html$programWithFlags = _elm_lang$virtual_dom$VirtualDom$programWithFlags;
	var _elm_lang$html$Html$program = _elm_lang$virtual_dom$VirtualDom$program;
	var _elm_lang$html$Html$beginnerProgram = function (_p0) {
		var _p1 = _p0;
		return _elm_lang$html$Html$program(
			{
				init: A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_p1.model,
					{ctor: '[]'}),
				update: F2(
					function (msg, model) {
						return A2(
							_elm_lang$core$Platform_Cmd_ops['!'],
							A2(_p1.update, msg, model),
							{ctor: '[]'});
					}),
				view: _p1.view,
				subscriptions: function (_p2) {
					return _elm_lang$core$Platform_Sub$none;
				}
			});
	};
	var _elm_lang$html$Html$map = _elm_lang$virtual_dom$VirtualDom$map;
	var _elm_lang$html$Html$text = _elm_lang$virtual_dom$VirtualDom$text;
	var _elm_lang$html$Html$node = _elm_lang$virtual_dom$VirtualDom$node;
	var _elm_lang$html$Html$body = _elm_lang$html$Html$node('body');
	var _elm_lang$html$Html$section = _elm_lang$html$Html$node('section');
	var _elm_lang$html$Html$nav = _elm_lang$html$Html$node('nav');
	var _elm_lang$html$Html$article = _elm_lang$html$Html$node('article');
	var _elm_lang$html$Html$aside = _elm_lang$html$Html$node('aside');
	var _elm_lang$html$Html$h1 = _elm_lang$html$Html$node('h1');
	var _elm_lang$html$Html$h2 = _elm_lang$html$Html$node('h2');
	var _elm_lang$html$Html$h3 = _elm_lang$html$Html$node('h3');
	var _elm_lang$html$Html$h4 = _elm_lang$html$Html$node('h4');
	var _elm_lang$html$Html$h5 = _elm_lang$html$Html$node('h5');
	var _elm_lang$html$Html$h6 = _elm_lang$html$Html$node('h6');
	var _elm_lang$html$Html$header = _elm_lang$html$Html$node('header');
	var _elm_lang$html$Html$footer = _elm_lang$html$Html$node('footer');
	var _elm_lang$html$Html$address = _elm_lang$html$Html$node('address');
	var _elm_lang$html$Html$main_ = _elm_lang$html$Html$node('main');
	var _elm_lang$html$Html$p = _elm_lang$html$Html$node('p');
	var _elm_lang$html$Html$hr = _elm_lang$html$Html$node('hr');
	var _elm_lang$html$Html$pre = _elm_lang$html$Html$node('pre');
	var _elm_lang$html$Html$blockquote = _elm_lang$html$Html$node('blockquote');
	var _elm_lang$html$Html$ol = _elm_lang$html$Html$node('ol');
	var _elm_lang$html$Html$ul = _elm_lang$html$Html$node('ul');
	var _elm_lang$html$Html$li = _elm_lang$html$Html$node('li');
	var _elm_lang$html$Html$dl = _elm_lang$html$Html$node('dl');
	var _elm_lang$html$Html$dt = _elm_lang$html$Html$node('dt');
	var _elm_lang$html$Html$dd = _elm_lang$html$Html$node('dd');
	var _elm_lang$html$Html$figure = _elm_lang$html$Html$node('figure');
	var _elm_lang$html$Html$figcaption = _elm_lang$html$Html$node('figcaption');
	var _elm_lang$html$Html$div = _elm_lang$html$Html$node('div');
	var _elm_lang$html$Html$a = _elm_lang$html$Html$node('a');
	var _elm_lang$html$Html$em = _elm_lang$html$Html$node('em');
	var _elm_lang$html$Html$strong = _elm_lang$html$Html$node('strong');
	var _elm_lang$html$Html$small = _elm_lang$html$Html$node('small');
	var _elm_lang$html$Html$s = _elm_lang$html$Html$node('s');
	var _elm_lang$html$Html$cite = _elm_lang$html$Html$node('cite');
	var _elm_lang$html$Html$q = _elm_lang$html$Html$node('q');
	var _elm_lang$html$Html$dfn = _elm_lang$html$Html$node('dfn');
	var _elm_lang$html$Html$abbr = _elm_lang$html$Html$node('abbr');
	var _elm_lang$html$Html$time = _elm_lang$html$Html$node('time');
	var _elm_lang$html$Html$code = _elm_lang$html$Html$node('code');
	var _elm_lang$html$Html$var = _elm_lang$html$Html$node('var');
	var _elm_lang$html$Html$samp = _elm_lang$html$Html$node('samp');
	var _elm_lang$html$Html$kbd = _elm_lang$html$Html$node('kbd');
	var _elm_lang$html$Html$sub = _elm_lang$html$Html$node('sub');
	var _elm_lang$html$Html$sup = _elm_lang$html$Html$node('sup');
	var _elm_lang$html$Html$i = _elm_lang$html$Html$node('i');
	var _elm_lang$html$Html$b = _elm_lang$html$Html$node('b');
	var _elm_lang$html$Html$u = _elm_lang$html$Html$node('u');
	var _elm_lang$html$Html$mark = _elm_lang$html$Html$node('mark');
	var _elm_lang$html$Html$ruby = _elm_lang$html$Html$node('ruby');
	var _elm_lang$html$Html$rt = _elm_lang$html$Html$node('rt');
	var _elm_lang$html$Html$rp = _elm_lang$html$Html$node('rp');
	var _elm_lang$html$Html$bdi = _elm_lang$html$Html$node('bdi');
	var _elm_lang$html$Html$bdo = _elm_lang$html$Html$node('bdo');
	var _elm_lang$html$Html$span = _elm_lang$html$Html$node('span');
	var _elm_lang$html$Html$br = _elm_lang$html$Html$node('br');
	var _elm_lang$html$Html$wbr = _elm_lang$html$Html$node('wbr');
	var _elm_lang$html$Html$ins = _elm_lang$html$Html$node('ins');
	var _elm_lang$html$Html$del = _elm_lang$html$Html$node('del');
	var _elm_lang$html$Html$img = _elm_lang$html$Html$node('img');
	var _elm_lang$html$Html$iframe = _elm_lang$html$Html$node('iframe');
	var _elm_lang$html$Html$embed = _elm_lang$html$Html$node('embed');
	var _elm_lang$html$Html$object = _elm_lang$html$Html$node('object');
	var _elm_lang$html$Html$param = _elm_lang$html$Html$node('param');
	var _elm_lang$html$Html$video = _elm_lang$html$Html$node('video');
	var _elm_lang$html$Html$audio = _elm_lang$html$Html$node('audio');
	var _elm_lang$html$Html$source = _elm_lang$html$Html$node('source');
	var _elm_lang$html$Html$track = _elm_lang$html$Html$node('track');
	var _elm_lang$html$Html$canvas = _elm_lang$html$Html$node('canvas');
	var _elm_lang$html$Html$math = _elm_lang$html$Html$node('math');
	var _elm_lang$html$Html$table = _elm_lang$html$Html$node('table');
	var _elm_lang$html$Html$caption = _elm_lang$html$Html$node('caption');
	var _elm_lang$html$Html$colgroup = _elm_lang$html$Html$node('colgroup');
	var _elm_lang$html$Html$col = _elm_lang$html$Html$node('col');
	var _elm_lang$html$Html$tbody = _elm_lang$html$Html$node('tbody');
	var _elm_lang$html$Html$thead = _elm_lang$html$Html$node('thead');
	var _elm_lang$html$Html$tfoot = _elm_lang$html$Html$node('tfoot');
	var _elm_lang$html$Html$tr = _elm_lang$html$Html$node('tr');
	var _elm_lang$html$Html$td = _elm_lang$html$Html$node('td');
	var _elm_lang$html$Html$th = _elm_lang$html$Html$node('th');
	var _elm_lang$html$Html$form = _elm_lang$html$Html$node('form');
	var _elm_lang$html$Html$fieldset = _elm_lang$html$Html$node('fieldset');
	var _elm_lang$html$Html$legend = _elm_lang$html$Html$node('legend');
	var _elm_lang$html$Html$label = _elm_lang$html$Html$node('label');
	var _elm_lang$html$Html$input = _elm_lang$html$Html$node('input');
	var _elm_lang$html$Html$button = _elm_lang$html$Html$node('button');
	var _elm_lang$html$Html$select = _elm_lang$html$Html$node('select');
	var _elm_lang$html$Html$datalist = _elm_lang$html$Html$node('datalist');
	var _elm_lang$html$Html$optgroup = _elm_lang$html$Html$node('optgroup');
	var _elm_lang$html$Html$option = _elm_lang$html$Html$node('option');
	var _elm_lang$html$Html$textarea = _elm_lang$html$Html$node('textarea');
	var _elm_lang$html$Html$keygen = _elm_lang$html$Html$node('keygen');
	var _elm_lang$html$Html$output = _elm_lang$html$Html$node('output');
	var _elm_lang$html$Html$progress = _elm_lang$html$Html$node('progress');
	var _elm_lang$html$Html$meter = _elm_lang$html$Html$node('meter');
	var _elm_lang$html$Html$details = _elm_lang$html$Html$node('details');
	var _elm_lang$html$Html$summary = _elm_lang$html$Html$node('summary');
	var _elm_lang$html$Html$menuitem = _elm_lang$html$Html$node('menuitem');
	var _elm_lang$html$Html$menu = _elm_lang$html$Html$node('menu');

	var _elm_lang$navigation$Native_Navigation = function() {


	// FAKE NAVIGATION

	function go(n)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			if (n !== 0)
			{
				history.go(n);
			}
			callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
		});
	}

	function pushState(url)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			history.pushState({}, '', url);
			callback(_elm_lang$core$Native_Scheduler.succeed(getLocation()));
		});
	}

	function replaceState(url)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			history.replaceState({}, '', url);
			callback(_elm_lang$core$Native_Scheduler.succeed(getLocation()));
		});
	}


	// REAL NAVIGATION

	function reloadPage(skipCache)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			document.location.reload(skipCache);
			callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
		});
	}

	function setLocation(url)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			try
			{
				window.location = url;
			}
			catch(err)
			{
				// Only Firefox can throw a NS_ERROR_MALFORMED_URI exception here.
				// Other browsers reload the page, so let's be consistent about that.
				document.location.reload(false);
			}
			callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
		});
	}


	// GET LOCATION

	function getLocation()
	{
		var location = document.location;

		return {
			href: location.href,
			host: location.host,
			hostname: location.hostname,
			protocol: location.protocol,
			origin: location.origin,
			port_: location.port,
			pathname: location.pathname,
			search: location.search,
			hash: location.hash,
			username: location.username,
			password: location.password
		};
	}


	// DETECT IE11 PROBLEMS

	function isInternetExplorer11()
	{
		return window.navigator.userAgent.indexOf('Trident') !== -1;
	}


	return {
		go: go,
		setLocation: setLocation,
		reloadPage: reloadPage,
		pushState: pushState,
		replaceState: replaceState,
		getLocation: getLocation,
		isInternetExplorer11: isInternetExplorer11
	};

	}();

	//import Native.Scheduler //

	var _elm_lang$core$Native_Time = function() {

	var now = _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
	{
		callback(_elm_lang$core$Native_Scheduler.succeed(Date.now()));
	});

	function setInterval_(interval, task)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			var id = setInterval(function() {
				_elm_lang$core$Native_Scheduler.rawSpawn(task);
			}, interval);

			return function() { clearInterval(id); };
		});
	}

	return {
		now: now,
		setInterval_: F2(setInterval_)
	};

	}();
	var _elm_lang$core$Time$setInterval = _elm_lang$core$Native_Time.setInterval_;
	var _elm_lang$core$Time$spawnHelp = F3(
		function (router, intervals, processes) {
			var _p0 = intervals;
			if (_p0.ctor === '[]') {
				return _elm_lang$core$Task$succeed(processes);
			} else {
				var _p1 = _p0._0;
				var spawnRest = function (id) {
					return A3(
						_elm_lang$core$Time$spawnHelp,
						router,
						_p0._1,
						A3(_elm_lang$core$Dict$insert, _p1, id, processes));
				};
				var spawnTimer = _elm_lang$core$Native_Scheduler.spawn(
					A2(
						_elm_lang$core$Time$setInterval,
						_p1,
						A2(_elm_lang$core$Platform$sendToSelf, router, _p1)));
				return A2(_elm_lang$core$Task$andThen, spawnRest, spawnTimer);
			}
		});
	var _elm_lang$core$Time$addMySub = F2(
		function (_p2, state) {
			var _p3 = _p2;
			var _p6 = _p3._1;
			var _p5 = _p3._0;
			var _p4 = A2(_elm_lang$core$Dict$get, _p5, state);
			if (_p4.ctor === 'Nothing') {
				return A3(
					_elm_lang$core$Dict$insert,
					_p5,
					{
						ctor: '::',
						_0: _p6,
						_1: {ctor: '[]'}
					},
					state);
			} else {
				return A3(
					_elm_lang$core$Dict$insert,
					_p5,
					{ctor: '::', _0: _p6, _1: _p4._0},
					state);
			}
		});
	var _elm_lang$core$Time$inMilliseconds = function (t) {
		return t;
	};
	var _elm_lang$core$Time$millisecond = 1;
	var _elm_lang$core$Time$second = 1000 * _elm_lang$core$Time$millisecond;
	var _elm_lang$core$Time$minute = 60 * _elm_lang$core$Time$second;
	var _elm_lang$core$Time$hour = 60 * _elm_lang$core$Time$minute;
	var _elm_lang$core$Time$inHours = function (t) {
		return t / _elm_lang$core$Time$hour;
	};
	var _elm_lang$core$Time$inMinutes = function (t) {
		return t / _elm_lang$core$Time$minute;
	};
	var _elm_lang$core$Time$inSeconds = function (t) {
		return t / _elm_lang$core$Time$second;
	};
	var _elm_lang$core$Time$now = _elm_lang$core$Native_Time.now;
	var _elm_lang$core$Time$onSelfMsg = F3(
		function (router, interval, state) {
			var _p7 = A2(_elm_lang$core$Dict$get, interval, state.taggers);
			if (_p7.ctor === 'Nothing') {
				return _elm_lang$core$Task$succeed(state);
			} else {
				var tellTaggers = function (time) {
					return _elm_lang$core$Task$sequence(
						A2(
							_elm_lang$core$List$map,
							function (tagger) {
								return A2(
									_elm_lang$core$Platform$sendToApp,
									router,
									tagger(time));
							},
							_p7._0));
				};
				return A2(
					_elm_lang$core$Task$andThen,
					function (_p8) {
						return _elm_lang$core$Task$succeed(state);
					},
					A2(_elm_lang$core$Task$andThen, tellTaggers, _elm_lang$core$Time$now));
			}
		});
	var _elm_lang$core$Time$subscription = _elm_lang$core$Native_Platform.leaf('Time');
	var _elm_lang$core$Time$State = F2(
		function (a, b) {
			return {taggers: a, processes: b};
		});
	var _elm_lang$core$Time$init = _elm_lang$core$Task$succeed(
		A2(_elm_lang$core$Time$State, _elm_lang$core$Dict$empty, _elm_lang$core$Dict$empty));
	var _elm_lang$core$Time$onEffects = F3(
		function (router, subs, _p9) {
			var _p10 = _p9;
			var rightStep = F3(
				function (_p12, id, _p11) {
					var _p13 = _p11;
					return {
						ctor: '_Tuple3',
						_0: _p13._0,
						_1: _p13._1,
						_2: A2(
							_elm_lang$core$Task$andThen,
							function (_p14) {
								return _p13._2;
							},
							_elm_lang$core$Native_Scheduler.kill(id))
					};
				});
			var bothStep = F4(
				function (interval, taggers, id, _p15) {
					var _p16 = _p15;
					return {
						ctor: '_Tuple3',
						_0: _p16._0,
						_1: A3(_elm_lang$core$Dict$insert, interval, id, _p16._1),
						_2: _p16._2
					};
				});
			var leftStep = F3(
				function (interval, taggers, _p17) {
					var _p18 = _p17;
					return {
						ctor: '_Tuple3',
						_0: {ctor: '::', _0: interval, _1: _p18._0},
						_1: _p18._1,
						_2: _p18._2
					};
				});
			var newTaggers = A3(_elm_lang$core$List$foldl, _elm_lang$core$Time$addMySub, _elm_lang$core$Dict$empty, subs);
			var _p19 = A6(
				_elm_lang$core$Dict$merge,
				leftStep,
				bothStep,
				rightStep,
				newTaggers,
				_p10.processes,
				{
					ctor: '_Tuple3',
					_0: {ctor: '[]'},
					_1: _elm_lang$core$Dict$empty,
					_2: _elm_lang$core$Task$succeed(
						{ctor: '_Tuple0'})
				});
			var spawnList = _p19._0;
			var existingDict = _p19._1;
			var killTask = _p19._2;
			return A2(
				_elm_lang$core$Task$andThen,
				function (newProcesses) {
					return _elm_lang$core$Task$succeed(
						A2(_elm_lang$core$Time$State, newTaggers, newProcesses));
				},
				A2(
					_elm_lang$core$Task$andThen,
					function (_p20) {
						return A3(_elm_lang$core$Time$spawnHelp, router, spawnList, existingDict);
					},
					killTask));
		});
	var _elm_lang$core$Time$Every = F2(
		function (a, b) {
			return {ctor: 'Every', _0: a, _1: b};
		});
	var _elm_lang$core$Time$every = F2(
		function (interval, tagger) {
			return _elm_lang$core$Time$subscription(
				A2(_elm_lang$core$Time$Every, interval, tagger));
		});
	var _elm_lang$core$Time$subMap = F2(
		function (f, _p21) {
			var _p22 = _p21;
			return A2(
				_elm_lang$core$Time$Every,
				_p22._0,
				function (_p23) {
					return f(
						_p22._1(_p23));
				});
		});
	_elm_lang$core$Native_Platform.effectManagers['Time'] = {pkg: 'elm-lang/core', init: _elm_lang$core$Time$init, onEffects: _elm_lang$core$Time$onEffects, onSelfMsg: _elm_lang$core$Time$onSelfMsg, tag: 'sub', subMap: _elm_lang$core$Time$subMap};

	var _elm_lang$core$Process$kill = _elm_lang$core$Native_Scheduler.kill;
	var _elm_lang$core$Process$sleep = _elm_lang$core$Native_Scheduler.sleep;
	var _elm_lang$core$Process$spawn = _elm_lang$core$Native_Scheduler.spawn;

	var _elm_lang$navigation$Navigation$replaceState = _elm_lang$navigation$Native_Navigation.replaceState;
	var _elm_lang$navigation$Navigation$pushState = _elm_lang$navigation$Native_Navigation.pushState;
	var _elm_lang$navigation$Navigation$go = _elm_lang$navigation$Native_Navigation.go;
	var _elm_lang$navigation$Navigation$reloadPage = _elm_lang$navigation$Native_Navigation.reloadPage;
	var _elm_lang$navigation$Navigation$setLocation = _elm_lang$navigation$Native_Navigation.setLocation;
	var _elm_lang$navigation$Navigation_ops = _elm_lang$navigation$Navigation_ops || {};
	_elm_lang$navigation$Navigation_ops['&>'] = F2(
		function (task1, task2) {
			return A2(
				_elm_lang$core$Task$andThen,
				function (_p0) {
					return task2;
				},
				task1);
		});
	var _elm_lang$navigation$Navigation$notify = F3(
		function (router, subs, location) {
			var send = function (_p1) {
				var _p2 = _p1;
				return A2(
					_elm_lang$core$Platform$sendToApp,
					router,
					_p2._0(location));
			};
			return A2(
				_elm_lang$navigation$Navigation_ops['&>'],
				_elm_lang$core$Task$sequence(
					A2(_elm_lang$core$List$map, send, subs)),
				_elm_lang$core$Task$succeed(
					{ctor: '_Tuple0'}));
		});
	var _elm_lang$navigation$Navigation$cmdHelp = F3(
		function (router, subs, cmd) {
			var _p3 = cmd;
			switch (_p3.ctor) {
				case 'Jump':
					return _elm_lang$navigation$Navigation$go(_p3._0);
				case 'New':
					return A2(
						_elm_lang$core$Task$andThen,
						A2(_elm_lang$navigation$Navigation$notify, router, subs),
						_elm_lang$navigation$Navigation$pushState(_p3._0));
				case 'Modify':
					return A2(
						_elm_lang$core$Task$andThen,
						A2(_elm_lang$navigation$Navigation$notify, router, subs),
						_elm_lang$navigation$Navigation$replaceState(_p3._0));
				case 'Visit':
					return _elm_lang$navigation$Navigation$setLocation(_p3._0);
				default:
					return _elm_lang$navigation$Navigation$reloadPage(_p3._0);
			}
		});
	var _elm_lang$navigation$Navigation$killPopWatcher = function (popWatcher) {
		var _p4 = popWatcher;
		if (_p4.ctor === 'Normal') {
			return _elm_lang$core$Process$kill(_p4._0);
		} else {
			return A2(
				_elm_lang$navigation$Navigation_ops['&>'],
				_elm_lang$core$Process$kill(_p4._0),
				_elm_lang$core$Process$kill(_p4._1));
		}
	};
	var _elm_lang$navigation$Navigation$onSelfMsg = F3(
		function (router, location, state) {
			return A2(
				_elm_lang$navigation$Navigation_ops['&>'],
				A3(_elm_lang$navigation$Navigation$notify, router, state.subs, location),
				_elm_lang$core$Task$succeed(state));
		});
	var _elm_lang$navigation$Navigation$subscription = _elm_lang$core$Native_Platform.leaf('Navigation');
	var _elm_lang$navigation$Navigation$command = _elm_lang$core$Native_Platform.leaf('Navigation');
	var _elm_lang$navigation$Navigation$Location = function (a) {
		return function (b) {
			return function (c) {
				return function (d) {
					return function (e) {
						return function (f) {
							return function (g) {
								return function (h) {
									return function (i) {
										return function (j) {
											return function (k) {
												return {href: a, host: b, hostname: c, protocol: d, origin: e, port_: f, pathname: g, search: h, hash: i, username: j, password: k};
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
	var _elm_lang$navigation$Navigation$State = F2(
		function (a, b) {
			return {subs: a, popWatcher: b};
		});
	var _elm_lang$navigation$Navigation$init = _elm_lang$core$Task$succeed(
		A2(
			_elm_lang$navigation$Navigation$State,
			{ctor: '[]'},
			_elm_lang$core$Maybe$Nothing));
	var _elm_lang$navigation$Navigation$Reload = function (a) {
		return {ctor: 'Reload', _0: a};
	};
	var _elm_lang$navigation$Navigation$reload = _elm_lang$navigation$Navigation$command(
		_elm_lang$navigation$Navigation$Reload(false));
	var _elm_lang$navigation$Navigation$reloadAndSkipCache = _elm_lang$navigation$Navigation$command(
		_elm_lang$navigation$Navigation$Reload(true));
	var _elm_lang$navigation$Navigation$Visit = function (a) {
		return {ctor: 'Visit', _0: a};
	};
	var _elm_lang$navigation$Navigation$load = function (url) {
		return _elm_lang$navigation$Navigation$command(
			_elm_lang$navigation$Navigation$Visit(url));
	};
	var _elm_lang$navigation$Navigation$Modify = function (a) {
		return {ctor: 'Modify', _0: a};
	};
	var _elm_lang$navigation$Navigation$modifyUrl = function (url) {
		return _elm_lang$navigation$Navigation$command(
			_elm_lang$navigation$Navigation$Modify(url));
	};
	var _elm_lang$navigation$Navigation$New = function (a) {
		return {ctor: 'New', _0: a};
	};
	var _elm_lang$navigation$Navigation$newUrl = function (url) {
		return _elm_lang$navigation$Navigation$command(
			_elm_lang$navigation$Navigation$New(url));
	};
	var _elm_lang$navigation$Navigation$Jump = function (a) {
		return {ctor: 'Jump', _0: a};
	};
	var _elm_lang$navigation$Navigation$back = function (n) {
		return _elm_lang$navigation$Navigation$command(
			_elm_lang$navigation$Navigation$Jump(0 - n));
	};
	var _elm_lang$navigation$Navigation$forward = function (n) {
		return _elm_lang$navigation$Navigation$command(
			_elm_lang$navigation$Navigation$Jump(n));
	};
	var _elm_lang$navigation$Navigation$cmdMap = F2(
		function (_p5, myCmd) {
			var _p6 = myCmd;
			switch (_p6.ctor) {
				case 'Jump':
					return _elm_lang$navigation$Navigation$Jump(_p6._0);
				case 'New':
					return _elm_lang$navigation$Navigation$New(_p6._0);
				case 'Modify':
					return _elm_lang$navigation$Navigation$Modify(_p6._0);
				case 'Visit':
					return _elm_lang$navigation$Navigation$Visit(_p6._0);
				default:
					return _elm_lang$navigation$Navigation$Reload(_p6._0);
			}
		});
	var _elm_lang$navigation$Navigation$Monitor = function (a) {
		return {ctor: 'Monitor', _0: a};
	};
	var _elm_lang$navigation$Navigation$program = F2(
		function (locationToMessage, stuff) {
			var init = stuff.init(
				_elm_lang$navigation$Native_Navigation.getLocation(
					{ctor: '_Tuple0'}));
			var subs = function (model) {
				return _elm_lang$core$Platform_Sub$batch(
					{
						ctor: '::',
						_0: _elm_lang$navigation$Navigation$subscription(
							_elm_lang$navigation$Navigation$Monitor(locationToMessage)),
						_1: {
							ctor: '::',
							_0: stuff.subscriptions(model),
							_1: {ctor: '[]'}
						}
					});
			};
			return _elm_lang$html$Html$program(
				{init: init, view: stuff.view, update: stuff.update, subscriptions: subs});
		});
	var _elm_lang$navigation$Navigation$programWithFlags = F2(
		function (locationToMessage, stuff) {
			var init = function (flags) {
				return A2(
					stuff.init,
					flags,
					_elm_lang$navigation$Native_Navigation.getLocation(
						{ctor: '_Tuple0'}));
			};
			var subs = function (model) {
				return _elm_lang$core$Platform_Sub$batch(
					{
						ctor: '::',
						_0: _elm_lang$navigation$Navigation$subscription(
							_elm_lang$navigation$Navigation$Monitor(locationToMessage)),
						_1: {
							ctor: '::',
							_0: stuff.subscriptions(model),
							_1: {ctor: '[]'}
						}
					});
			};
			return _elm_lang$html$Html$programWithFlags(
				{init: init, view: stuff.view, update: stuff.update, subscriptions: subs});
		});
	var _elm_lang$navigation$Navigation$subMap = F2(
		function (func, _p7) {
			var _p8 = _p7;
			return _elm_lang$navigation$Navigation$Monitor(
				function (_p9) {
					return func(
						_p8._0(_p9));
				});
		});
	var _elm_lang$navigation$Navigation$InternetExplorer = F2(
		function (a, b) {
			return {ctor: 'InternetExplorer', _0: a, _1: b};
		});
	var _elm_lang$navigation$Navigation$Normal = function (a) {
		return {ctor: 'Normal', _0: a};
	};
	var _elm_lang$navigation$Navigation$spawnPopWatcher = function (router) {
		var reportLocation = function (_p10) {
			return A2(
				_elm_lang$core$Platform$sendToSelf,
				router,
				_elm_lang$navigation$Native_Navigation.getLocation(
					{ctor: '_Tuple0'}));
		};
		return _elm_lang$navigation$Native_Navigation.isInternetExplorer11(
			{ctor: '_Tuple0'}) ? A3(
			_elm_lang$core$Task$map2,
			_elm_lang$navigation$Navigation$InternetExplorer,
			_elm_lang$core$Process$spawn(
				A3(_elm_lang$dom$Dom_LowLevel$onWindow, 'popstate', _elm_lang$core$Json_Decode$value, reportLocation)),
			_elm_lang$core$Process$spawn(
				A3(_elm_lang$dom$Dom_LowLevel$onWindow, 'hashchange', _elm_lang$core$Json_Decode$value, reportLocation))) : A2(
			_elm_lang$core$Task$map,
			_elm_lang$navigation$Navigation$Normal,
			_elm_lang$core$Process$spawn(
				A3(_elm_lang$dom$Dom_LowLevel$onWindow, 'popstate', _elm_lang$core$Json_Decode$value, reportLocation)));
	};
	var _elm_lang$navigation$Navigation$onEffects = F4(
		function (router, cmds, subs, _p11) {
			var _p12 = _p11;
			var _p15 = _p12.popWatcher;
			var stepState = function () {
				var _p13 = {ctor: '_Tuple2', _0: subs, _1: _p15};
				_v6_2:
				do {
					if (_p13._0.ctor === '[]') {
						if (_p13._1.ctor === 'Just') {
							return A2(
								_elm_lang$navigation$Navigation_ops['&>'],
								_elm_lang$navigation$Navigation$killPopWatcher(_p13._1._0),
								_elm_lang$core$Task$succeed(
									A2(_elm_lang$navigation$Navigation$State, subs, _elm_lang$core$Maybe$Nothing)));
						} else {
							break _v6_2;
						}
					} else {
						if (_p13._1.ctor === 'Nothing') {
							return A2(
								_elm_lang$core$Task$map,
								function (_p14) {
									return A2(
										_elm_lang$navigation$Navigation$State,
										subs,
										_elm_lang$core$Maybe$Just(_p14));
								},
								_elm_lang$navigation$Navigation$spawnPopWatcher(router));
						} else {
							break _v6_2;
						}
					}
				} while(false);
				return _elm_lang$core$Task$succeed(
					A2(_elm_lang$navigation$Navigation$State, subs, _p15));
			}();
			return A2(
				_elm_lang$navigation$Navigation_ops['&>'],
				_elm_lang$core$Task$sequence(
					A2(
						_elm_lang$core$List$map,
						A2(_elm_lang$navigation$Navigation$cmdHelp, router, subs),
						cmds)),
				stepState);
		});
	_elm_lang$core$Native_Platform.effectManagers['Navigation'] = {pkg: 'elm-lang/navigation', init: _elm_lang$navigation$Navigation$init, onEffects: _elm_lang$navigation$Navigation$onEffects, onSelfMsg: _elm_lang$navigation$Navigation$onSelfMsg, tag: 'fx', cmdMap: _elm_lang$navigation$Navigation$cmdMap, subMap: _elm_lang$navigation$Navigation$subMap};

	var _elm_lang$html$Html_Attributes$map = _elm_lang$virtual_dom$VirtualDom$mapProperty;
	var _elm_lang$html$Html_Attributes$attribute = _elm_lang$virtual_dom$VirtualDom$attribute;
	var _elm_lang$html$Html_Attributes$contextmenu = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'contextmenu', value);
	};
	var _elm_lang$html$Html_Attributes$draggable = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'draggable', value);
	};
	var _elm_lang$html$Html_Attributes$itemprop = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'itemprop', value);
	};
	var _elm_lang$html$Html_Attributes$tabindex = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'tabIndex',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$charset = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'charset', value);
	};
	var _elm_lang$html$Html_Attributes$height = function (value) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'height',
			_elm_lang$core$Basics$toString(value));
	};
	var _elm_lang$html$Html_Attributes$width = function (value) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'width',
			_elm_lang$core$Basics$toString(value));
	};
	var _elm_lang$html$Html_Attributes$formaction = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'formAction', value);
	};
	var _elm_lang$html$Html_Attributes$list = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'list', value);
	};
	var _elm_lang$html$Html_Attributes$minlength = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'minLength',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$maxlength = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'maxlength',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$size = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'size',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$form = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'form', value);
	};
	var _elm_lang$html$Html_Attributes$cols = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'cols',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$rows = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'rows',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$challenge = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'challenge', value);
	};
	var _elm_lang$html$Html_Attributes$media = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'media', value);
	};
	var _elm_lang$html$Html_Attributes$rel = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'rel', value);
	};
	var _elm_lang$html$Html_Attributes$datetime = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'datetime', value);
	};
	var _elm_lang$html$Html_Attributes$pubdate = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'pubdate', value);
	};
	var _elm_lang$html$Html_Attributes$colspan = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'colspan',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$rowspan = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$attribute,
			'rowspan',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$manifest = function (value) {
		return A2(_elm_lang$html$Html_Attributes$attribute, 'manifest', value);
	};
	var _elm_lang$html$Html_Attributes$property = _elm_lang$virtual_dom$VirtualDom$property;
	var _elm_lang$html$Html_Attributes$stringProperty = F2(
		function (name, string) {
			return A2(
				_elm_lang$html$Html_Attributes$property,
				name,
				_elm_lang$core$Json_Encode$string(string));
		});
	var _elm_lang$html$Html_Attributes$class = function (name) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'className', name);
	};
	var _elm_lang$html$Html_Attributes$id = function (name) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'id', name);
	};
	var _elm_lang$html$Html_Attributes$title = function (name) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'title', name);
	};
	var _elm_lang$html$Html_Attributes$accesskey = function ($char) {
		return A2(
			_elm_lang$html$Html_Attributes$stringProperty,
			'accessKey',
			_elm_lang$core$String$fromChar($char));
	};
	var _elm_lang$html$Html_Attributes$dir = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'dir', value);
	};
	var _elm_lang$html$Html_Attributes$dropzone = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'dropzone', value);
	};
	var _elm_lang$html$Html_Attributes$lang = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'lang', value);
	};
	var _elm_lang$html$Html_Attributes$content = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'content', value);
	};
	var _elm_lang$html$Html_Attributes$httpEquiv = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'httpEquiv', value);
	};
	var _elm_lang$html$Html_Attributes$language = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'language', value);
	};
	var _elm_lang$html$Html_Attributes$src = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'src', value);
	};
	var _elm_lang$html$Html_Attributes$alt = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'alt', value);
	};
	var _elm_lang$html$Html_Attributes$preload = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'preload', value);
	};
	var _elm_lang$html$Html_Attributes$poster = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'poster', value);
	};
	var _elm_lang$html$Html_Attributes$kind = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'kind', value);
	};
	var _elm_lang$html$Html_Attributes$srclang = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'srclang', value);
	};
	var _elm_lang$html$Html_Attributes$sandbox = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'sandbox', value);
	};
	var _elm_lang$html$Html_Attributes$srcdoc = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'srcdoc', value);
	};
	var _elm_lang$html$Html_Attributes$type_ = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'type', value);
	};
	var _elm_lang$html$Html_Attributes$value = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'value', value);
	};
	var _elm_lang$html$Html_Attributes$defaultValue = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'defaultValue', value);
	};
	var _elm_lang$html$Html_Attributes$placeholder = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'placeholder', value);
	};
	var _elm_lang$html$Html_Attributes$accept = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'accept', value);
	};
	var _elm_lang$html$Html_Attributes$acceptCharset = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'acceptCharset', value);
	};
	var _elm_lang$html$Html_Attributes$action = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'action', value);
	};
	var _elm_lang$html$Html_Attributes$autocomplete = function (bool) {
		return A2(
			_elm_lang$html$Html_Attributes$stringProperty,
			'autocomplete',
			bool ? 'on' : 'off');
	};
	var _elm_lang$html$Html_Attributes$enctype = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'enctype', value);
	};
	var _elm_lang$html$Html_Attributes$method = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'method', value);
	};
	var _elm_lang$html$Html_Attributes$name = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'name', value);
	};
	var _elm_lang$html$Html_Attributes$pattern = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'pattern', value);
	};
	var _elm_lang$html$Html_Attributes$for = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'htmlFor', value);
	};
	var _elm_lang$html$Html_Attributes$max = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'max', value);
	};
	var _elm_lang$html$Html_Attributes$min = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'min', value);
	};
	var _elm_lang$html$Html_Attributes$step = function (n) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'step', n);
	};
	var _elm_lang$html$Html_Attributes$wrap = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'wrap', value);
	};
	var _elm_lang$html$Html_Attributes$usemap = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'useMap', value);
	};
	var _elm_lang$html$Html_Attributes$shape = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'shape', value);
	};
	var _elm_lang$html$Html_Attributes$coords = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'coords', value);
	};
	var _elm_lang$html$Html_Attributes$keytype = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'keytype', value);
	};
	var _elm_lang$html$Html_Attributes$align = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'align', value);
	};
	var _elm_lang$html$Html_Attributes$cite = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'cite', value);
	};
	var _elm_lang$html$Html_Attributes$href = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'href', value);
	};
	var _elm_lang$html$Html_Attributes$target = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'target', value);
	};
	var _elm_lang$html$Html_Attributes$downloadAs = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'download', value);
	};
	var _elm_lang$html$Html_Attributes$hreflang = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'hreflang', value);
	};
	var _elm_lang$html$Html_Attributes$ping = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'ping', value);
	};
	var _elm_lang$html$Html_Attributes$start = function (n) {
		return A2(
			_elm_lang$html$Html_Attributes$stringProperty,
			'start',
			_elm_lang$core$Basics$toString(n));
	};
	var _elm_lang$html$Html_Attributes$headers = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'headers', value);
	};
	var _elm_lang$html$Html_Attributes$scope = function (value) {
		return A2(_elm_lang$html$Html_Attributes$stringProperty, 'scope', value);
	};
	var _elm_lang$html$Html_Attributes$boolProperty = F2(
		function (name, bool) {
			return A2(
				_elm_lang$html$Html_Attributes$property,
				name,
				_elm_lang$core$Json_Encode$bool(bool));
		});
	var _elm_lang$html$Html_Attributes$hidden = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'hidden', bool);
	};
	var _elm_lang$html$Html_Attributes$contenteditable = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'contentEditable', bool);
	};
	var _elm_lang$html$Html_Attributes$spellcheck = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'spellcheck', bool);
	};
	var _elm_lang$html$Html_Attributes$async = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'async', bool);
	};
	var _elm_lang$html$Html_Attributes$defer = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'defer', bool);
	};
	var _elm_lang$html$Html_Attributes$scoped = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'scoped', bool);
	};
	var _elm_lang$html$Html_Attributes$autoplay = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'autoplay', bool);
	};
	var _elm_lang$html$Html_Attributes$controls = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'controls', bool);
	};
	var _elm_lang$html$Html_Attributes$loop = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'loop', bool);
	};
	var _elm_lang$html$Html_Attributes$default = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'default', bool);
	};
	var _elm_lang$html$Html_Attributes$seamless = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'seamless', bool);
	};
	var _elm_lang$html$Html_Attributes$checked = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'checked', bool);
	};
	var _elm_lang$html$Html_Attributes$selected = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'selected', bool);
	};
	var _elm_lang$html$Html_Attributes$autofocus = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'autofocus', bool);
	};
	var _elm_lang$html$Html_Attributes$disabled = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'disabled', bool);
	};
	var _elm_lang$html$Html_Attributes$multiple = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'multiple', bool);
	};
	var _elm_lang$html$Html_Attributes$novalidate = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'noValidate', bool);
	};
	var _elm_lang$html$Html_Attributes$readonly = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'readOnly', bool);
	};
	var _elm_lang$html$Html_Attributes$required = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'required', bool);
	};
	var _elm_lang$html$Html_Attributes$ismap = function (value) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'isMap', value);
	};
	var _elm_lang$html$Html_Attributes$download = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'download', bool);
	};
	var _elm_lang$html$Html_Attributes$reversed = function (bool) {
		return A2(_elm_lang$html$Html_Attributes$boolProperty, 'reversed', bool);
	};
	var _elm_lang$html$Html_Attributes$classList = function (list) {
		return _elm_lang$html$Html_Attributes$class(
			A2(
				_elm_lang$core$String$join,
				' ',
				A2(
					_elm_lang$core$List$map,
					_elm_lang$core$Tuple$first,
					A2(_elm_lang$core$List$filter, _elm_lang$core$Tuple$second, list))));
	};
	var _elm_lang$html$Html_Attributes$style = _elm_lang$virtual_dom$VirtualDom$style;

	var _ccamel$playground_elm$Page_Common$PageInfo = F4(
		function (a, b, c, d) {
			return {name: a, hash: b, description: c, srcRel: d};
		});

	var _ccamel$playground_elm$Page_About$view = function (model) {
		return A2(
			_elm_lang$html$Html$div,
			{
				ctor: '::',
				_0: _elm_lang$html$Html_Attributes$class('container'),
				_1: {ctor: '[]'}
			},
			{
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$hr,
					{ctor: '[]'},
					{ctor: '[]'}),
				_1: {
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$p,
						{
							ctor: '::',
							_0: _elm_lang$html$Html_Attributes$class('text-muted'),
							_1: {ctor: '[]'}
						},
						{
							ctor: '::',
							_0: _elm_lang$html$Html$text('The purpose of this playground is to '),
							_1: {
								ctor: '::',
								_0: A2(
									_elm_lang$html$Html$i,
									{ctor: '[]'},
									{
										ctor: '::',
										_0: _elm_lang$html$Html$text('explore'),
										_1: {ctor: '[]'}
									}),
								_1: {
									ctor: '::',
									_0: _elm_lang$html$Html$text(', '),
									_1: {
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$i,
											{ctor: '[]'},
											{
												ctor: '::',
												_0: _elm_lang$html$Html$text('study'),
												_1: {ctor: '[]'}
											}),
										_1: {
											ctor: '::',
											_0: _elm_lang$html$Html$text(' and '),
											_1: {
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$i,
													{ctor: '[]'},
													{
														ctor: '::',
														_0: _elm_lang$html$Html$text('assess'),
														_1: {ctor: '[]'}
													}),
												_1: {
													ctor: '::',
													_0: _elm_lang$html$Html$text(' the '),
													_1: {
														ctor: '::',
														_0: A2(
															_elm_lang$html$Html$a,
															{
																ctor: '::',
																_0: _elm_lang$html$Html_Attributes$href('http://elm-lang.org/'),
																_1: {ctor: '[]'}
															},
															{
																ctor: '::',
																_0: _elm_lang$html$Html$text('elm language'),
																_1: {ctor: '[]'}
															}),
														_1: {
															ctor: '::',
															_0: _elm_lang$html$Html$text(' — a delightful language for reliable webapps.'),
															_1: {ctor: '[]'}
														}
													}
												}
											}
										}
									}
								}
							}
						}),
					_1: {
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$p,
							{
								ctor: '::',
								_0: _elm_lang$html$Html_Attributes$class('text-muted'),
								_1: {ctor: '[]'}
							},
							{
								ctor: '::',
								_0: _elm_lang$html$Html$text('The showcases are intended to be:'),
								_1: {ctor: '[]'}
							}),
						_1: {
							ctor: '::',
							_0: A2(
								_elm_lang$html$Html$div,
								{
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$class('row'),
									_1: {
										ctor: '::',
										_0: _elm_lang$html$Html_Attributes$style(
											{
												ctor: '::',
												_0: {ctor: '_Tuple2', _0: 'padding-top', _1: '2em'},
												_1: {ctor: '[]'}
											}),
										_1: {ctor: '[]'}
									}
								},
								{
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$div,
										{
											ctor: '::',
											_0: _elm_lang$html$Html_Attributes$class('col-lg-4'),
											_1: {ctor: '[]'}
										},
										{
											ctor: '::',
											_0: A2(
												_elm_lang$html$Html$i,
												{
													ctor: '::',
													_0: A2(_elm_lang$html$Html_Attributes$attribute, 'aria-hidden', 'true'),
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$class('fa fa-child fa-3x iconic'),
														_1: {ctor: '[]'}
													}
												},
												{ctor: '[]'}),
											_1: {
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$h2,
													{
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$style(
															{
																ctor: '::',
																_0: {ctor: '_Tuple2', _0: 'padding-top', _1: '1em'},
																_1: {ctor: '[]'}
															}),
														_1: {ctor: '[]'}
													},
													{
														ctor: '::',
														_0: _elm_lang$html$Html$text('» simple'),
														_1: {ctor: '[]'}
													}),
												_1: {
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$p,
														{ctor: '[]'},
														{
															ctor: '::',
															_0: _elm_lang$html$Html$text('Fairly simple and understandable. Every showcase is implemented in a single elm file.'),
															_1: {ctor: '[]'}
														}),
													_1: {ctor: '[]'}
												}
											}
										}),
									_1: {
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$div,
											{
												ctor: '::',
												_0: _elm_lang$html$Html_Attributes$class('col-lg-4'),
												_1: {ctor: '[]'}
											},
											{
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$i,
													{
														ctor: '::',
														_0: A2(_elm_lang$html$Html_Attributes$attribute, 'aria-hidden', 'true'),
														_1: {
															ctor: '::',
															_0: _elm_lang$html$Html_Attributes$class('fa fa-search fa-3x iconic'),
															_1: {ctor: '[]'}
														}
													},
													{ctor: '[]'}),
												_1: {
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$h2,
														{
															ctor: '::',
															_0: _elm_lang$html$Html_Attributes$style(
																{
																	ctor: '::',
																	_0: {ctor: '_Tuple2', _0: 'padding-top', _1: '1em'},
																	_1: {ctor: '[]'}
																}),
															_1: {ctor: '[]'}
														},
														{
															ctor: '::',
															_0: _elm_lang$html$Html$text('» exploratory'),
															_1: {ctor: '[]'}
														}),
													_1: {
														ctor: '::',
														_0: A2(
															_elm_lang$html$Html$p,
															{ctor: '[]'},
															{
																ctor: '::',
																_0: _elm_lang$html$Html$text('Highlight some aspects of the '),
																_1: {
																	ctor: '::',
																	_0: A2(
																		_elm_lang$html$Html$a,
																		{
																			ctor: '::',
																			_0: _elm_lang$html$Html_Attributes$href('http://elm-lang.org/'),
																			_1: {ctor: '[]'}
																		},
																		{
																			ctor: '::',
																			_0: _elm_lang$html$Html$text('elm'),
																			_1: {ctor: '[]'}
																		}),
																	_1: {
																		ctor: '::',
																		_0: _elm_lang$html$Html$text(' language, like immutability, reactiveness, performance and interoperability with other JS libraries.'),
																		_1: {ctor: '[]'}
																	}
																}
															}),
														_1: {
															ctor: '::',
															_0: A2(
																_elm_lang$html$Html$p,
																{ctor: '[]'},
																{
																	ctor: '::',
																	_0: _elm_lang$html$Html$text('Explore some architectural/design patterns around reactive static/serverless '),
																	_1: {
																		ctor: '::',
																		_0: A2(
																			_elm_lang$html$Html$a,
																			{
																				ctor: '::',
																				_0: _elm_lang$html$Html_Attributes$href('https://en.wikipedia.org/wiki/Single-page_application'),
																				_1: {ctor: '[]'}
																			},
																			{
																				ctor: '::',
																				_0: _elm_lang$html$Html$text('SPA'),
																				_1: {ctor: '[]'}
																			}),
																		_1: {
																			ctor: '::',
																			_0: _elm_lang$html$Html$text('.'),
																			_1: {ctor: '[]'}
																		}
																	}
																}),
															_1: {ctor: '[]'}
														}
													}
												}
											}),
										_1: {
											ctor: '::',
											_0: A2(
												_elm_lang$html$Html$div,
												{
													ctor: '::',
													_0: _elm_lang$html$Html_Attributes$class('col-lg-4'),
													_1: {ctor: '[]'}
												},
												{
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$i,
														{
															ctor: '::',
															_0: A2(_elm_lang$html$Html_Attributes$attribute, 'aria-hidden', 'true'),
															_1: {
																ctor: '::',
																_0: _elm_lang$html$Html_Attributes$class('fa fa-futbol-o fa-3x iconic'),
																_1: {ctor: '[]'}
															}
														},
														{ctor: '[]'}),
													_1: {
														ctor: '::',
														_0: A2(
															_elm_lang$html$Html$h2,
															{
																ctor: '::',
																_0: _elm_lang$html$Html_Attributes$style(
																	{
																		ctor: '::',
																		_0: {ctor: '_Tuple2', _0: 'padding-top', _1: '1em'},
																		_1: {ctor: '[]'}
																	}),
																_1: {ctor: '[]'}
															},
															{
																ctor: '::',
																_0: _elm_lang$html$Html$text('» playable'),
																_1: {ctor: '[]'}
															}),
														_1: {
															ctor: '::',
															_0: A2(
																_elm_lang$html$Html$p,
																{ctor: '[]'},
																{
																	ctor: '::',
																	_0: _elm_lang$html$Html$text('As much as possible, provides a useful and functional content.'),
																	_1: {ctor: '[]'}
																}),
															_1: {ctor: '[]'}
														}
													}
												}),
											_1: {ctor: '[]'}
										}
									}
								}),
							_1: {ctor: '[]'}
						}
					}
				}
			});
	};
	var _ccamel$playground_elm$Page_About$subscriptions = function (model) {
		return _elm_lang$core$Platform_Sub$none;
	};
	var _ccamel$playground_elm$Page_About$update = F2(
		function (msg, model) {
			var _p0 = msg;
			return model;
		});
	var _ccamel$playground_elm$Page_About$initialModel = {};
	var _ccamel$playground_elm$Page_About$info = {
		name: 'about',
		hash: 'about',
		description: A2(
			_elm_lang$html$Html$div,
			{ctor: '[]'},
			{
				ctor: '::',
				_0: _elm_lang$html$Html$text('A very simple and minimal showcase that is used to lay the foundations of the navigation/routing (and to test that the whole site works correctly)'),
				_1: {ctor: '[]'}
			}),
		srcRel: 'Page/About.elm'
	};
	var _ccamel$playground_elm$Page_About$Model = {};
	var _ccamel$playground_elm$Page_About$Reset = {ctor: 'Reset'};

	var _ccamel$playground_elm$App_Messages$About = {ctor: 'About'};
	var _ccamel$playground_elm$App_Messages$AboutPageMsg = function (a) {
		return {ctor: 'AboutPageMsg', _0: a};
	};
	var _ccamel$playground_elm$App_Messages$GoToPage = function (a) {
		return {ctor: 'GoToPage', _0: a};
	};
	var _ccamel$playground_elm$App_Messages$GoToHome = {ctor: 'GoToHome'};
	var _ccamel$playground_elm$App_Messages$OnLocationChange = function (a) {
		return {ctor: 'OnLocationChange', _0: a};
	};

	var _elm_lang$http$Native_Http = function() {


	// ENCODING AND DECODING

	function encodeUri(string)
	{
		return encodeURIComponent(string);
	}

	function decodeUri(string)
	{
		try
		{
			return _elm_lang$core$Maybe$Just(decodeURIComponent(string));
		}
		catch(e)
		{
			return _elm_lang$core$Maybe$Nothing;
		}
	}


	// SEND REQUEST

	function toTask(request, maybeProgress)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
		{
			var xhr = new XMLHttpRequest();

			configureProgress(xhr, maybeProgress);

			xhr.addEventListener('error', function() {
				callback(_elm_lang$core$Native_Scheduler.fail({ ctor: 'NetworkError' }));
			});
			xhr.addEventListener('timeout', function() {
				callback(_elm_lang$core$Native_Scheduler.fail({ ctor: 'Timeout' }));
			});
			xhr.addEventListener('load', function() {
				callback(handleResponse(xhr, request.expect.responseToResult));
			});

			try
			{
				xhr.open(request.method, request.url, true);
			}
			catch (e)
			{
				return callback(_elm_lang$core$Native_Scheduler.fail({ ctor: 'BadUrl', _0: request.url }));
			}

			configureRequest(xhr, request);
			send(xhr, request.body);

			return function() { xhr.abort(); };
		});
	}

	function configureProgress(xhr, maybeProgress)
	{
		if (maybeProgress.ctor === 'Nothing')
		{
			return;
		}

		xhr.addEventListener('progress', function(event) {
			if (!event.lengthComputable)
			{
				return;
			}
			_elm_lang$core$Native_Scheduler.rawSpawn(maybeProgress._0({
				bytes: event.loaded,
				bytesExpected: event.total
			}));
		});
	}

	function configureRequest(xhr, request)
	{
		function setHeader(pair)
		{
			xhr.setRequestHeader(pair._0, pair._1);
		}

		A2(_elm_lang$core$List$map, setHeader, request.headers);
		xhr.responseType = request.expect.responseType;
		xhr.withCredentials = request.withCredentials;

		if (request.timeout.ctor === 'Just')
		{
			xhr.timeout = request.timeout._0;
		}
	}

	function send(xhr, body)
	{
		switch (body.ctor)
		{
			case 'EmptyBody':
				xhr.send();
				return;

			case 'StringBody':
				xhr.setRequestHeader('Content-Type', body._0);
				xhr.send(body._1);
				return;

			case 'FormDataBody':
				xhr.send(body._0);
				return;
		}
	}


	// RESPONSES

	function handleResponse(xhr, responseToResult)
	{
		var response = toResponse(xhr);

		if (xhr.status < 200 || 300 <= xhr.status)
		{
			response.body = xhr.responseText;
			return _elm_lang$core$Native_Scheduler.fail({
				ctor: 'BadStatus',
				_0: response
			});
		}

		var result = responseToResult(response);

		if (result.ctor === 'Ok')
		{
			return _elm_lang$core$Native_Scheduler.succeed(result._0);
		}
		else
		{
			response.body = xhr.responseText;
			return _elm_lang$core$Native_Scheduler.fail({
				ctor: 'BadPayload',
				_0: result._0,
				_1: response
			});
		}
	}

	function toResponse(xhr)
	{
		return {
			status: { code: xhr.status, message: xhr.statusText },
			headers: parseHeaders(xhr.getAllResponseHeaders()),
			url: xhr.responseURL,
			body: xhr.response
		};
	}

	function parseHeaders(rawHeaders)
	{
		var headers = _elm_lang$core$Dict$empty;

		if (!rawHeaders)
		{
			return headers;
		}

		var headerPairs = rawHeaders.split('\u000d\u000a');
		for (var i = headerPairs.length; i--; )
		{
			var headerPair = headerPairs[i];
			var index = headerPair.indexOf('\u003a\u0020');
			if (index > 0)
			{
				var key = headerPair.substring(0, index);
				var value = headerPair.substring(index + 2);

				headers = A3(_elm_lang$core$Dict$update, key, function(oldValue) {
					if (oldValue.ctor === 'Just')
					{
						return _elm_lang$core$Maybe$Just(value + ', ' + oldValue._0);
					}
					return _elm_lang$core$Maybe$Just(value);
				}, headers);
			}
		}

		return headers;
	}


	// EXPECTORS

	function expectStringResponse(responseToResult)
	{
		return {
			responseType: 'text',
			responseToResult: responseToResult
		};
	}

	function mapExpect(func, expect)
	{
		return {
			responseType: expect.responseType,
			responseToResult: function(response) {
				var convertedResponse = expect.responseToResult(response);
				return A2(_elm_lang$core$Result$map, func, convertedResponse);
			}
		};
	}


	// BODY

	function multipart(parts)
	{
		var formData = new FormData();

		while (parts.ctor !== '[]')
		{
			var part = parts._0;
			formData.append(part._0, part._1);
			parts = parts._1;
		}

		return { ctor: 'FormDataBody', _0: formData };
	}

	return {
		toTask: F2(toTask),
		expectStringResponse: expectStringResponse,
		mapExpect: F2(mapExpect),
		multipart: multipart,
		encodeUri: encodeUri,
		decodeUri: decodeUri
	};

	}();

	var _elm_lang$http$Http_Internal$map = F2(
		function (func, request) {
			return _elm_lang$core$Native_Utils.update(
				request,
				{
					expect: A2(_elm_lang$http$Native_Http.mapExpect, func, request.expect)
				});
		});
	var _elm_lang$http$Http_Internal$RawRequest = F7(
		function (a, b, c, d, e, f, g) {
			return {method: a, headers: b, url: c, body: d, expect: e, timeout: f, withCredentials: g};
		});
	var _elm_lang$http$Http_Internal$Request = function (a) {
		return {ctor: 'Request', _0: a};
	};
	var _elm_lang$http$Http_Internal$Expect = {ctor: 'Expect'};
	var _elm_lang$http$Http_Internal$FormDataBody = {ctor: 'FormDataBody'};
	var _elm_lang$http$Http_Internal$StringBody = F2(
		function (a, b) {
			return {ctor: 'StringBody', _0: a, _1: b};
		});
	var _elm_lang$http$Http_Internal$EmptyBody = {ctor: 'EmptyBody'};
	var _elm_lang$http$Http_Internal$Header = F2(
		function (a, b) {
			return {ctor: 'Header', _0: a, _1: b};
		});

	var _elm_lang$http$Http$decodeUri = _elm_lang$http$Native_Http.decodeUri;
	var _elm_lang$http$Http$encodeUri = _elm_lang$http$Native_Http.encodeUri;
	var _elm_lang$http$Http$expectStringResponse = _elm_lang$http$Native_Http.expectStringResponse;
	var _elm_lang$http$Http$expectJson = function (decoder) {
		return _elm_lang$http$Http$expectStringResponse(
			function (response) {
				return A2(_elm_lang$core$Json_Decode$decodeString, decoder, response.body);
			});
	};
	var _elm_lang$http$Http$expectString = _elm_lang$http$Http$expectStringResponse(
		function (response) {
			return _elm_lang$core$Result$Ok(response.body);
		});
	var _elm_lang$http$Http$multipartBody = _elm_lang$http$Native_Http.multipart;
	var _elm_lang$http$Http$stringBody = _elm_lang$http$Http_Internal$StringBody;
	var _elm_lang$http$Http$jsonBody = function (value) {
		return A2(
			_elm_lang$http$Http_Internal$StringBody,
			'application/json',
			A2(_elm_lang$core$Json_Encode$encode, 0, value));
	};
	var _elm_lang$http$Http$emptyBody = _elm_lang$http$Http_Internal$EmptyBody;
	var _elm_lang$http$Http$header = _elm_lang$http$Http_Internal$Header;
	var _elm_lang$http$Http$request = _elm_lang$http$Http_Internal$Request;
	var _elm_lang$http$Http$post = F3(
		function (url, body, decoder) {
			return _elm_lang$http$Http$request(
				{
					method: 'POST',
					headers: {ctor: '[]'},
					url: url,
					body: body,
					expect: _elm_lang$http$Http$expectJson(decoder),
					timeout: _elm_lang$core$Maybe$Nothing,
					withCredentials: false
				});
		});
	var _elm_lang$http$Http$get = F2(
		function (url, decoder) {
			return _elm_lang$http$Http$request(
				{
					method: 'GET',
					headers: {ctor: '[]'},
					url: url,
					body: _elm_lang$http$Http$emptyBody,
					expect: _elm_lang$http$Http$expectJson(decoder),
					timeout: _elm_lang$core$Maybe$Nothing,
					withCredentials: false
				});
		});
	var _elm_lang$http$Http$getString = function (url) {
		return _elm_lang$http$Http$request(
			{
				method: 'GET',
				headers: {ctor: '[]'},
				url: url,
				body: _elm_lang$http$Http$emptyBody,
				expect: _elm_lang$http$Http$expectString,
				timeout: _elm_lang$core$Maybe$Nothing,
				withCredentials: false
			});
	};
	var _elm_lang$http$Http$toTask = function (_p0) {
		var _p1 = _p0;
		return A2(_elm_lang$http$Native_Http.toTask, _p1._0, _elm_lang$core$Maybe$Nothing);
	};
	var _elm_lang$http$Http$send = F2(
		function (resultToMessage, request) {
			return A2(
				_elm_lang$core$Task$attempt,
				resultToMessage,
				_elm_lang$http$Http$toTask(request));
		});
	var _elm_lang$http$Http$Response = F4(
		function (a, b, c, d) {
			return {url: a, status: b, headers: c, body: d};
		});
	var _elm_lang$http$Http$BadPayload = F2(
		function (a, b) {
			return {ctor: 'BadPayload', _0: a, _1: b};
		});
	var _elm_lang$http$Http$BadStatus = function (a) {
		return {ctor: 'BadStatus', _0: a};
	};
	var _elm_lang$http$Http$NetworkError = {ctor: 'NetworkError'};
	var _elm_lang$http$Http$Timeout = {ctor: 'Timeout'};
	var _elm_lang$http$Http$BadUrl = function (a) {
		return {ctor: 'BadUrl', _0: a};
	};
	var _elm_lang$http$Http$StringPart = F2(
		function (a, b) {
			return {ctor: 'StringPart', _0: a, _1: b};
		});
	var _elm_lang$http$Http$stringPart = _elm_lang$http$Http$StringPart;

	var _evancz$url_parser$UrlParser$toKeyValuePair = function (segment) {
		var _p0 = A2(_elm_lang$core$String$split, '=', segment);
		if (((_p0.ctor === '::') && (_p0._1.ctor === '::')) && (_p0._1._1.ctor === '[]')) {
			return A3(
				_elm_lang$core$Maybe$map2,
				F2(
					function (v0, v1) {
						return {ctor: '_Tuple2', _0: v0, _1: v1};
					}),
				_elm_lang$http$Http$decodeUri(_p0._0),
				_elm_lang$http$Http$decodeUri(_p0._1._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	};
	var _evancz$url_parser$UrlParser$parseParams = function (queryString) {
		return _elm_lang$core$Dict$fromList(
			A2(
				_elm_lang$core$List$filterMap,
				_evancz$url_parser$UrlParser$toKeyValuePair,
				A2(
					_elm_lang$core$String$split,
					'&',
					A2(_elm_lang$core$String$dropLeft, 1, queryString))));
	};
	var _evancz$url_parser$UrlParser$splitUrl = function (url) {
		var _p1 = A2(_elm_lang$core$String$split, '/', url);
		if ((_p1.ctor === '::') && (_p1._0 === '')) {
			return _p1._1;
		} else {
			return _p1;
		}
	};
	var _evancz$url_parser$UrlParser$parseHelp = function (states) {
		parseHelp:
		while (true) {
			var _p2 = states;
			if (_p2.ctor === '[]') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				var _p4 = _p2._0;
				var _p3 = _p4.unvisited;
				if (_p3.ctor === '[]') {
					return _elm_lang$core$Maybe$Just(_p4.value);
				} else {
					if ((_p3._0 === '') && (_p3._1.ctor === '[]')) {
						return _elm_lang$core$Maybe$Just(_p4.value);
					} else {
						var _v4 = _p2._1;
						states = _v4;
						continue parseHelp;
					}
				}
			}
		}
	};
	var _evancz$url_parser$UrlParser$parse = F3(
		function (_p5, url, params) {
			var _p6 = _p5;
			return _evancz$url_parser$UrlParser$parseHelp(
				_p6._0(
					{
						visited: {ctor: '[]'},
						unvisited: _evancz$url_parser$UrlParser$splitUrl(url),
						params: params,
						value: _elm_lang$core$Basics$identity
					}));
		});
	var _evancz$url_parser$UrlParser$parseHash = F2(
		function (parser, location) {
			return A3(
				_evancz$url_parser$UrlParser$parse,
				parser,
				A2(_elm_lang$core$String$dropLeft, 1, location.hash),
				_evancz$url_parser$UrlParser$parseParams(location.search));
		});
	var _evancz$url_parser$UrlParser$parsePath = F2(
		function (parser, location) {
			return A3(
				_evancz$url_parser$UrlParser$parse,
				parser,
				location.pathname,
				_evancz$url_parser$UrlParser$parseParams(location.search));
		});
	var _evancz$url_parser$UrlParser$intParamHelp = function (maybeValue) {
		var _p7 = maybeValue;
		if (_p7.ctor === 'Nothing') {
			return _elm_lang$core$Maybe$Nothing;
		} else {
			return _elm_lang$core$Result$toMaybe(
				_elm_lang$core$String$toInt(_p7._0));
		}
	};
	var _evancz$url_parser$UrlParser$mapHelp = F2(
		function (func, _p8) {
			var _p9 = _p8;
			return {
				visited: _p9.visited,
				unvisited: _p9.unvisited,
				params: _p9.params,
				value: func(_p9.value)
			};
		});
	var _evancz$url_parser$UrlParser$State = F4(
		function (a, b, c, d) {
			return {visited: a, unvisited: b, params: c, value: d};
		});
	var _evancz$url_parser$UrlParser$Parser = function (a) {
		return {ctor: 'Parser', _0: a};
	};
	var _evancz$url_parser$UrlParser$s = function (str) {
		return _evancz$url_parser$UrlParser$Parser(
			function (_p10) {
				var _p11 = _p10;
				var _p12 = _p11.unvisited;
				if (_p12.ctor === '[]') {
					return {ctor: '[]'};
				} else {
					var _p13 = _p12._0;
					return _elm_lang$core$Native_Utils.eq(_p13, str) ? {
						ctor: '::',
						_0: A4(
							_evancz$url_parser$UrlParser$State,
							{ctor: '::', _0: _p13, _1: _p11.visited},
							_p12._1,
							_p11.params,
							_p11.value),
						_1: {ctor: '[]'}
					} : {ctor: '[]'};
				}
			});
	};
	var _evancz$url_parser$UrlParser$custom = F2(
		function (tipe, stringToSomething) {
			return _evancz$url_parser$UrlParser$Parser(
				function (_p14) {
					var _p15 = _p14;
					var _p16 = _p15.unvisited;
					if (_p16.ctor === '[]') {
						return {ctor: '[]'};
					} else {
						var _p18 = _p16._0;
						var _p17 = stringToSomething(_p18);
						if (_p17.ctor === 'Ok') {
							return {
								ctor: '::',
								_0: A4(
									_evancz$url_parser$UrlParser$State,
									{ctor: '::', _0: _p18, _1: _p15.visited},
									_p16._1,
									_p15.params,
									_p15.value(_p17._0)),
								_1: {ctor: '[]'}
							};
						} else {
							return {ctor: '[]'};
						}
					}
				});
		});
	var _evancz$url_parser$UrlParser$string = A2(_evancz$url_parser$UrlParser$custom, 'STRING', _elm_lang$core$Result$Ok);
	var _evancz$url_parser$UrlParser$int = A2(_evancz$url_parser$UrlParser$custom, 'NUMBER', _elm_lang$core$String$toInt);
	var _evancz$url_parser$UrlParser_ops = _evancz$url_parser$UrlParser_ops || {};
	_evancz$url_parser$UrlParser_ops['</>'] = F2(
		function (_p20, _p19) {
			var _p21 = _p20;
			var _p22 = _p19;
			return _evancz$url_parser$UrlParser$Parser(
				function (state) {
					return A2(
						_elm_lang$core$List$concatMap,
						_p22._0,
						_p21._0(state));
				});
		});
	var _evancz$url_parser$UrlParser$map = F2(
		function (subValue, _p23) {
			var _p24 = _p23;
			return _evancz$url_parser$UrlParser$Parser(
				function (_p25) {
					var _p26 = _p25;
					return A2(
						_elm_lang$core$List$map,
						_evancz$url_parser$UrlParser$mapHelp(_p26.value),
						_p24._0(
							{visited: _p26.visited, unvisited: _p26.unvisited, params: _p26.params, value: subValue}));
				});
		});
	var _evancz$url_parser$UrlParser$oneOf = function (parsers) {
		return _evancz$url_parser$UrlParser$Parser(
			function (state) {
				return A2(
					_elm_lang$core$List$concatMap,
					function (_p27) {
						var _p28 = _p27;
						return _p28._0(state);
					},
					parsers);
			});
	};
	var _evancz$url_parser$UrlParser$top = _evancz$url_parser$UrlParser$Parser(
		function (state) {
			return {
				ctor: '::',
				_0: state,
				_1: {ctor: '[]'}
			};
		});
	var _evancz$url_parser$UrlParser_ops = _evancz$url_parser$UrlParser_ops || {};
	_evancz$url_parser$UrlParser_ops['<?>'] = F2(
		function (_p30, _p29) {
			var _p31 = _p30;
			var _p32 = _p29;
			return _evancz$url_parser$UrlParser$Parser(
				function (state) {
					return A2(
						_elm_lang$core$List$concatMap,
						_p32._0,
						_p31._0(state));
				});
		});
	var _evancz$url_parser$UrlParser$QueryParser = function (a) {
		return {ctor: 'QueryParser', _0: a};
	};
	var _evancz$url_parser$UrlParser$customParam = F2(
		function (key, func) {
			return _evancz$url_parser$UrlParser$QueryParser(
				function (_p33) {
					var _p34 = _p33;
					var _p35 = _p34.params;
					return {
						ctor: '::',
						_0: A4(
							_evancz$url_parser$UrlParser$State,
							_p34.visited,
							_p34.unvisited,
							_p35,
							_p34.value(
								func(
									A2(_elm_lang$core$Dict$get, key, _p35)))),
						_1: {ctor: '[]'}
					};
				});
		});
	var _evancz$url_parser$UrlParser$stringParam = function (name) {
		return A2(_evancz$url_parser$UrlParser$customParam, name, _elm_lang$core$Basics$identity);
	};
	var _evancz$url_parser$UrlParser$intParam = function (name) {
		return A2(_evancz$url_parser$UrlParser$customParam, name, _evancz$url_parser$UrlParser$intParamHelp);
	};

	var _ccamel$playground_elm$App_Routing$NotFoundRoute = {ctor: 'NotFoundRoute'};
	var _ccamel$playground_elm$App_Routing$Page = function (a) {
		return {ctor: 'Page', _0: a};
	};
	var _ccamel$playground_elm$App_Routing$Home = {ctor: 'Home'};
	var _ccamel$playground_elm$App_Routing$matchers = _evancz$url_parser$UrlParser$oneOf(
		{
			ctor: '::',
			_0: A2(_evancz$url_parser$UrlParser$map, _ccamel$playground_elm$App_Routing$Home, _evancz$url_parser$UrlParser$top),
			_1: {
				ctor: '::',
				_0: A2(
					_evancz$url_parser$UrlParser$map,
					_ccamel$playground_elm$App_Routing$Page(_ccamel$playground_elm$App_Messages$About),
					_evancz$url_parser$UrlParser$s('about')),
				_1: {ctor: '[]'}
			}
		});
	var _ccamel$playground_elm$App_Routing$parseLocation = function (location) {
		var _p0 = A2(_evancz$url_parser$UrlParser$parseHash, _ccamel$playground_elm$App_Routing$matchers, location);
		if (_p0.ctor === 'Just') {
			return _p0._0;
		} else {
			return _ccamel$playground_elm$App_Routing$NotFoundRoute;
		}
	};

	var _ccamel$playground_elm$App_Models$initialModel = function (route) {
		return {
			route: route,
			aboutPage: _elm_lang$core$Maybe$Just(_ccamel$playground_elm$Page_About$initialModel)
		};
	};
	var _ccamel$playground_elm$App_Models$Model = F2(
		function (a, b) {
			return {route: a, aboutPage: b};
		});

	var _ccamel$playground_elm$App_Pages$pages = {
		ctor: '::',
		_0: _ccamel$playground_elm$App_Messages$About,
		_1: {ctor: '[]'}
	};
	var _ccamel$playground_elm$App_Pages$emptyNode = _elm_lang$html$Html$text('');
	var _ccamel$playground_elm$App_Pages$pageSpec = function (page) {
		var toSubscriptions = F4(
			function (pageSubscriptions, pageMsg, modelExtractor, model) {
				return A2(
					_elm_lang$core$Maybe$withDefault,
					_elm_lang$core$Platform_Sub$none,
					A2(
						_elm_lang$core$Maybe$map,
						_elm_lang$core$Platform_Sub$map(pageMsg),
						A2(
							_elm_lang$core$Maybe$map,
							pageSubscriptions,
							modelExtractor(model))));
			});
		var toView = F4(
			function (pageView, pageMsg, modelExtractor, model) {
				return A2(
					_elm_lang$core$Maybe$withDefault,
					_ccamel$playground_elm$App_Pages$emptyNode,
					A2(
						_elm_lang$core$Maybe$map,
						_elm_lang$html$Html$map(pageMsg),
						A2(
							_elm_lang$core$Maybe$map,
							pageView,
							modelExtractor(model))));
			});
		var toSpec = F5(
			function (info, pageView, pageSubscriptions, pageMsg, modelExtractor) {
				return {
					info: _elm_lang$core$Native_Utils.update(
						info,
						{
							description: A2(_elm_lang$html$Html$map, pageMsg, info.description)
						}),
					view: A3(toView, pageView, pageMsg, modelExtractor),
					subscriptions: A3(toSubscriptions, pageSubscriptions, pageMsg, modelExtractor)
				};
			});
		var _p0 = page;
		return A5(
			toSpec,
			_ccamel$playground_elm$Page_About$info,
			_ccamel$playground_elm$Page_About$view,
			_ccamel$playground_elm$Page_About$subscriptions,
			_ccamel$playground_elm$App_Messages$AboutPageMsg,
			function (model) {
				return model.aboutPage;
			});
	};
	var _ccamel$playground_elm$App_Pages$pageName = function (page) {
		return function (_) {
			return _.name;
		}(
			function (_) {
				return _.info;
			}(
				_ccamel$playground_elm$App_Pages$pageSpec(page)));
	};
	var _ccamel$playground_elm$App_Pages$pageDescription = function (page) {
		return function (_) {
			return _.description;
		}(
			function (_) {
				return _.info;
			}(
				_ccamel$playground_elm$App_Pages$pageSpec(page)));
	};
	var _ccamel$playground_elm$App_Pages$pageSrc = function (page) {
		return function (_) {
			return _.srcRel;
		}(
			function (_) {
				return _.info;
			}(
				_ccamel$playground_elm$App_Pages$pageSpec(page)));
	};
	var _ccamel$playground_elm$App_Pages$pageHash = function (page) {
		return function (_) {
			return _.hash;
		}(
			function (_) {
				return _.info;
			}(
				_ccamel$playground_elm$App_Pages$pageSpec(page)));
	};
	var _ccamel$playground_elm$App_Pages$pageView = function (page) {
		return function (_) {
			return _.view;
		}(
			_ccamel$playground_elm$App_Pages$pageSpec(page));
	};
	var _ccamel$playground_elm$App_Pages$pageSubscriptions = function (page) {
		return function (_) {
			return _.subscriptions;
		}(
			_ccamel$playground_elm$App_Pages$pageSpec(page));
	};
	var _ccamel$playground_elm$App_Pages$PageSpec = F3(
		function (a, b, c) {
			return {info: a, view: b, subscriptions: c};
		});

	var _ccamel$playground_elm$App_Subscriptions$mainSubscriptions = function (model) {
		return _elm_lang$core$Platform_Sub$none;
	};
	var _ccamel$playground_elm$App_Subscriptions$subscriptions = function (model) {
		return _elm_lang$core$Platform_Sub$batch(
			{
				ctor: '::',
				_0: _ccamel$playground_elm$App_Subscriptions$mainSubscriptions(model),
				_1: {
					ctor: '::',
					_0: function () {
						var _p0 = model.route;
						switch (_p0.ctor) {
							case 'NotFoundRoute':
								return _elm_lang$core$Platform_Sub$none;
							case 'Home':
								return _elm_lang$core$Platform_Sub$none;
							default:
								return A2(_ccamel$playground_elm$App_Pages$pageSubscriptions, _p0._0, model);
						}
					}(),
					_1: {ctor: '[]'}
				}
			});
	};

	var _ccamel$playground_elm$App_Update$update = F2(
		function (msg, model) {
			var _p0 = msg;
			switch (_p0.ctor) {
				case 'OnLocationChange':
					var clearedModel = _elm_lang$core$Native_Utils.update(
						model,
						{aboutPage: _elm_lang$core$Maybe$Nothing});
					var newRoute = _ccamel$playground_elm$App_Routing$parseLocation(_p0._0);
					var _p1 = newRoute;
					switch (_p1.ctor) {
						case 'NotFoundRoute':
							return {
								ctor: '_Tuple2',
								_0: _elm_lang$core$Native_Utils.update(
									clearedModel,
									{route: newRoute}),
								_1: _elm_lang$core$Platform_Cmd$none
							};
						case 'Home':
							return {
								ctor: '_Tuple2',
								_0: _elm_lang$core$Native_Utils.update(
									clearedModel,
									{route: newRoute}),
								_1: _elm_lang$core$Platform_Cmd$none
							};
						default:
							return {
								ctor: '_Tuple2',
								_0: _elm_lang$core$Native_Utils.update(
									clearedModel,
									{
										route: newRoute,
										aboutPage: _elm_lang$core$Maybe$Just(_ccamel$playground_elm$Page_About$initialModel)
									}),
								_1: _elm_lang$core$Platform_Cmd$none
							};
					}
				case 'GoToPage':
					return {
						ctor: '_Tuple2',
						_0: model,
						_1: _elm_lang$navigation$Navigation$newUrl(
							A2(
								_elm_lang$core$String$cons,
								_elm_lang$core$Native_Utils.chr('#'),
								function (_) {
									return _.hash;
								}(_ccamel$playground_elm$Page_About$info)))
					};
				case 'GoToHome':
					return {
						ctor: '_Tuple2',
						_0: model,
						_1: _elm_lang$navigation$Navigation$newUrl('/')
					};
				default:
					return {
						ctor: '_Tuple2',
						_0: _elm_lang$core$Native_Utils.update(
							model,
							{
								aboutPage: A2(
									_elm_lang$core$Maybe$map,
									_ccamel$playground_elm$Page_About$update(_p0._0),
									model.aboutPage)
							}),
						_1: _elm_lang$core$Platform_Cmd$none
					};
			}
		});

	var _elm_lang$html$Html_Events$keyCode = A2(_elm_lang$core$Json_Decode$field, 'keyCode', _elm_lang$core$Json_Decode$int);
	var _elm_lang$html$Html_Events$targetChecked = A2(
		_elm_lang$core$Json_Decode$at,
		{
			ctor: '::',
			_0: 'target',
			_1: {
				ctor: '::',
				_0: 'checked',
				_1: {ctor: '[]'}
			}
		},
		_elm_lang$core$Json_Decode$bool);
	var _elm_lang$html$Html_Events$targetValue = A2(
		_elm_lang$core$Json_Decode$at,
		{
			ctor: '::',
			_0: 'target',
			_1: {
				ctor: '::',
				_0: 'value',
				_1: {ctor: '[]'}
			}
		},
		_elm_lang$core$Json_Decode$string);
	var _elm_lang$html$Html_Events$defaultOptions = _elm_lang$virtual_dom$VirtualDom$defaultOptions;
	var _elm_lang$html$Html_Events$onWithOptions = _elm_lang$virtual_dom$VirtualDom$onWithOptions;
	var _elm_lang$html$Html_Events$on = _elm_lang$virtual_dom$VirtualDom$on;
	var _elm_lang$html$Html_Events$onFocus = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'focus',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onBlur = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'blur',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onSubmitOptions = _elm_lang$core$Native_Utils.update(
		_elm_lang$html$Html_Events$defaultOptions,
		{preventDefault: true});
	var _elm_lang$html$Html_Events$onSubmit = function (msg) {
		return A3(
			_elm_lang$html$Html_Events$onWithOptions,
			'submit',
			_elm_lang$html$Html_Events$onSubmitOptions,
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onCheck = function (tagger) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'change',
			A2(_elm_lang$core$Json_Decode$map, tagger, _elm_lang$html$Html_Events$targetChecked));
	};
	var _elm_lang$html$Html_Events$onInput = function (tagger) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'input',
			A2(_elm_lang$core$Json_Decode$map, tagger, _elm_lang$html$Html_Events$targetValue));
	};
	var _elm_lang$html$Html_Events$onMouseOut = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'mouseout',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onMouseOver = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'mouseover',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onMouseLeave = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'mouseleave',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onMouseEnter = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'mouseenter',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onMouseUp = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'mouseup',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onMouseDown = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'mousedown',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onDoubleClick = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'dblclick',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$onClick = function (msg) {
		return A2(
			_elm_lang$html$Html_Events$on,
			'click',
			_elm_lang$core$Json_Decode$succeed(msg));
	};
	var _elm_lang$html$Html_Events$Options = F2(
		function (a, b) {
			return {stopPropagation: a, preventDefault: b};
		});

	var _ccamel$playground_elm$App_View$hash = function (route) {
		var _p0 = route;
		switch (_p0.ctor) {
			case 'Home':
				return '';
			case 'Page':
				return _ccamel$playground_elm$App_Pages$pageHash(_p0._0);
			default:
				return '';
		}
	};
	var _ccamel$playground_elm$App_View$contentId = function (route) {
		var _p1 = route;
		switch (_p1.ctor) {
			case 'Home':
				return 'home';
			case 'Page':
				return _ccamel$playground_elm$App_Pages$pageHash(_p1._0);
			default:
				return '?';
		}
	};
	var _ccamel$playground_elm$App_View$linkToGitHub = function (route) {
		var url = 'https://github.com/ccamel/playground-elm/blob/master/src/elm/';
		var link = function () {
			var _p2 = route;
			switch (_p2.ctor) {
				case 'Home':
					return A2(_elm_lang$core$Basics_ops['++'], url, 'App/View.elm');
				case 'Page':
					return A2(
						_elm_lang$core$Basics_ops['++'],
						url,
						_ccamel$playground_elm$App_Pages$pageSrc(_p2._0));
				default:
					return A2(_elm_lang$core$Basics_ops['++'], url, 'Main.elm');
			}
		}();
		return A2(
			_elm_lang$html$Html$a,
			{
				ctor: '::',
				_0: _elm_lang$html$Html_Attributes$href(link),
				_1: {ctor: '[]'}
			},
			{
				ctor: '::',
				_0: _elm_lang$html$Html$text('» Source'),
				_1: {ctor: '[]'}
			});
	};
	var _ccamel$playground_elm$App_View$notFoundView = A2(
		_elm_lang$html$Html$div,
		{
			ctor: '::',
			_0: _elm_lang$html$Html_Attributes$class('container'),
			_1: {ctor: '[]'}
		},
		{
			ctor: '::',
			_0: A2(
				_elm_lang$html$Html$hr,
				{ctor: '[]'},
				{ctor: '[]'}),
			_1: {
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$div,
					{
						ctor: '::',
						_0: _elm_lang$html$Html_Attributes$class('text-muted'),
						_1: {ctor: '[]'}
					},
					{
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$div,
							{
								ctor: '::',
								_0: _elm_lang$html$Html_Attributes$class('container'),
								_1: {ctor: '[]'}
							},
							{
								ctor: '::',
								_0: A2(
									_elm_lang$html$Html$div,
									{
										ctor: '::',
										_0: _elm_lang$html$Html_Attributes$class('row'),
										_1: {ctor: '[]'}
									},
									{
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$div,
											{
												ctor: '::',
												_0: _elm_lang$html$Html_Attributes$class('col-sm-12 text-center'),
												_1: {ctor: '[]'}
											},
											{
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$i,
													{
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$class('fa fa-exclamation-triangle'),
														_1: {ctor: '[]'}
													},
													{ctor: '[]'}),
												_1: {
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$h2,
														{ctor: '[]'},
														{
															ctor: '::',
															_0: _elm_lang$html$Html$text('404'),
															_1: {ctor: '[]'}
														}),
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html$text('not found'),
														_1: {ctor: '[]'}
													}
												}
											}),
										_1: {ctor: '[]'}
									}),
								_1: {ctor: '[]'}
							}),
						_1: {ctor: '[]'}
					}),
				_1: {ctor: '[]'}
			}
		});
	var _ccamel$playground_elm$App_View$pageCard = F2(
		function (model, page) {
			return A2(
				_elm_lang$html$Html$div,
				{
					ctor: '::',
					_0: _elm_lang$html$Html_Attributes$class('col-sm-3'),
					_1: {ctor: '[]'}
				},
				{
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$div,
						{
							ctor: '::',
							_0: _elm_lang$html$Html_Attributes$class('card'),
							_1: {ctor: '[]'}
						},
						{
							ctor: '::',
							_0: A2(
								_elm_lang$html$Html$div,
								{
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$class('card-block'),
									_1: {ctor: '[]'}
								},
								{
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$h3,
										{
											ctor: '::',
											_0: _elm_lang$html$Html_Attributes$class('card-title'),
											_1: {ctor: '[]'}
										},
										{
											ctor: '::',
											_0: _elm_lang$html$Html$text(
												A2(
													_elm_lang$core$Basics_ops['++'],
													'~ ',
													_ccamel$playground_elm$App_Pages$pageName(page))),
											_1: {ctor: '[]'}
										}),
									_1: {
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$p,
											{
												ctor: '::',
												_0: _elm_lang$html$Html_Attributes$class('card-text'),
												_1: {ctor: '[]'}
											},
											{
												ctor: '::',
												_0: _ccamel$playground_elm$App_Pages$pageDescription(page),
												_1: {ctor: '[]'}
											}),
										_1: {
											ctor: '::',
											_0: A2(
												_elm_lang$html$Html$a,
												{
													ctor: '::',
													_0: _elm_lang$html$Html_Attributes$href(
														A2(
															_elm_lang$core$Basics_ops['++'],
															'#',
															_ccamel$playground_elm$App_Pages$pageHash(page))),
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html_Events$onClick(
															_ccamel$playground_elm$App_Messages$GoToPage(page)),
														_1: {ctor: '[]'}
													}
												},
												{
													ctor: '::',
													_0: _elm_lang$html$Html$text('» Go'),
													_1: {ctor: '[]'}
												}),
											_1: {
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$span,
													{
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$style(
															{
																ctor: '::',
																_0: {ctor: '_Tuple2', _0: 'padding-left', _1: '15px'},
																_1: {ctor: '[]'}
															}),
														_1: {ctor: '[]'}
													},
													{ctor: '[]'}),
												_1: {
													ctor: '::',
													_0: _ccamel$playground_elm$App_View$linkToGitHub(
														_ccamel$playground_elm$App_Routing$Page(_ccamel$playground_elm$App_Messages$About)),
													_1: {ctor: '[]'}
												}
											}
										}
									}
								}),
							_1: {ctor: '[]'}
						}),
					_1: {ctor: '[]'}
				});
		});
	var _ccamel$playground_elm$App_View$homePage = function (model) {
		return A2(
			_elm_lang$html$Html$div,
			{
				ctor: '::',
				_0: _elm_lang$html$Html_Attributes$class('text-muted'),
				_1: {ctor: '[]'}
			},
			{
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$div,
					{
						ctor: '::',
						_0: _elm_lang$html$Html_Attributes$class('container'),
						_1: {ctor: '[]'}
					},
					{
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$div,
							{
								ctor: '::',
								_0: _elm_lang$html$Html_Attributes$class('row'),
								_1: {ctor: '[]'}
							},
							A2(
								_elm_lang$core$List$map,
								_ccamel$playground_elm$App_View$pageCard(model),
								_ccamel$playground_elm$App_Pages$pages)),
						_1: {ctor: '[]'}
					}),
				_1: {ctor: '[]'}
			});
	};
	var _ccamel$playground_elm$App_View$content = function (model) {
		var _p3 = model.route;
		switch (_p3.ctor) {
			case 'Home':
				return _ccamel$playground_elm$App_View$homePage(model);
			case 'Page':
				return A2(_ccamel$playground_elm$App_Pages$pageView, _p3._0, model);
			default:
				return _ccamel$playground_elm$App_View$notFoundView;
		}
	};
	var _ccamel$playground_elm$App_View$view = function (model) {
		return A2(
			_elm_lang$html$Html$div,
			{ctor: '[]'},
			{
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$div,
					{
						ctor: '::',
						_0: _elm_lang$html$Html_Attributes$class('navbar navbar-inverse bg-inverse'),
						_1: {ctor: '[]'}
					},
					{
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$div,
							{
								ctor: '::',
								_0: _elm_lang$html$Html_Attributes$class('container d-flex justify-content-between'),
								_1: {ctor: '[]'}
							},
							{
								ctor: '::',
								_0: A2(
									_elm_lang$html$Html$div,
									{
										ctor: '::',
										_0: _elm_lang$html$Html_Attributes$class('navbar-brand'),
										_1: {ctor: '[]'}
									},
									{
										ctor: '::',
										_0: _elm_lang$html$Html$text(
											A2(
												_elm_lang$core$Basics_ops['++'],
												'playground-elm/',
												_ccamel$playground_elm$App_View$hash(model.route))),
										_1: {ctor: '[]'}
									}),
								_1: {
									ctor: '::',
									_0: function () {
										var _p4 = model.route;
										if (_p4.ctor === 'Home') {
											return _ccamel$playground_elm$App_Pages$emptyNode;
										} else {
											return A2(
												_elm_lang$html$Html$ul,
												{
													ctor: '::',
													_0: _elm_lang$html$Html_Attributes$class('nav navbar-nav navbar-right'),
													_1: {ctor: '[]'}
												},
												{
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$li,
														{ctor: '[]'},
														{
															ctor: '::',
															_0: A2(
																_elm_lang$html$Html$a,
																{
																	ctor: '::',
																	_0: _elm_lang$html$Html_Attributes$href('#'),
																	_1: {
																		ctor: '::',
																		_0: _elm_lang$html$Html_Events$onClick(_ccamel$playground_elm$App_Messages$GoToHome),
																		_1: {ctor: '[]'}
																	}
																},
																{
																	ctor: '::',
																	_0: _elm_lang$html$Html$text('Home'),
																	_1: {ctor: '[]'}
																}),
															_1: {ctor: '[]'}
														}),
													_1: {ctor: '[]'}
												});
										}
									}(),
									_1: {ctor: '[]'}
								}
							}),
						_1: {
							ctor: '::',
							_0: A2(
								_elm_lang$html$Html$a,
								{
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$href('https://github.com/ccamel/playground-elm'),
									_1: {ctor: '[]'}
								},
								{
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$img,
										{
											ctor: '::',
											_0: _elm_lang$html$Html_Attributes$alt('Fork me on GitHub'),
											_1: {
												ctor: '::',
												_0: A2(_elm_lang$html$Html_Attributes$attribute, 'data:data-canonical-src', 'https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png'),
												_1: {
													ctor: '::',
													_0: _elm_lang$html$Html_Attributes$src('https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67'),
													_1: {
														ctor: '::',
														_0: A2(_elm_lang$html$Html_Attributes$attribute, 'style', 'position: absolute; top: 0; right: 0; border: 0;'),
														_1: {ctor: '[]'}
													}
												}
											}
										},
										{ctor: '[]'}),
									_1: {
										ctor: '::',
										_0: _elm_lang$html$Html$text(''),
										_1: {ctor: '[]'}
									}
								}),
							_1: {ctor: '[]'}
						}
					}),
				_1: {
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$section,
						{
							ctor: '::',
							_0: _elm_lang$html$Html_Attributes$class('jumbotron text-center'),
							_1: {ctor: '[]'}
						},
						{
							ctor: '::',
							_0: A2(
								_elm_lang$html$Html$div,
								{
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$class('container'),
									_1: {ctor: '[]'}
								},
								{
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$h1,
										{
											ctor: '::',
											_0: _elm_lang$html$Html_Attributes$class('jumbotron-heading'),
											_1: {ctor: '[]'}
										},
										{
											ctor: '::',
											_0: A2(
												_elm_lang$html$Html$i,
												{
													ctor: '::',
													_0: _elm_lang$html$Html_Attributes$class('fa fa-quote-left text-muted'),
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$style(
															{
																ctor: '::',
																_0: {ctor: '_Tuple2', _0: 'padding-right', _1: '1em'},
																_1: {ctor: '[]'}
															}),
														_1: {ctor: '[]'}
													}
												},
												{ctor: '[]'}),
											_1: {
												ctor: '::',
												_0: _elm_lang$html$Html$text('playground'),
												_1: {
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$span,
														{
															ctor: '::',
															_0: _elm_lang$html$Html_Attributes$class('text-muted'),
															_1: {ctor: '[]'}
														},
														{
															ctor: '::',
															_0: _elm_lang$html$Html$text('-'),
															_1: {ctor: '[]'}
														}),
													_1: {
														ctor: '::',
														_0: A2(
															_elm_lang$html$Html$a,
															{
																ctor: '::',
																_0: _elm_lang$html$Html_Attributes$href('http://elm-lang.org/'),
																_1: {ctor: '[]'}
															},
															{
																ctor: '::',
																_0: _elm_lang$html$Html$text('elm'),
																_1: {ctor: '[]'}
															}),
														_1: {
															ctor: '::',
															_0: A2(
																_elm_lang$html$Html$i,
																{
																	ctor: '::',
																	_0: _elm_lang$html$Html_Attributes$class('fa fa-quote-right text-muted'),
																	_1: {
																		ctor: '::',
																		_0: _elm_lang$html$Html_Attributes$style(
																			{
																				ctor: '::',
																				_0: {ctor: '_Tuple2', _0: 'padding-left', _1: '1em'},
																				_1: {ctor: '[]'}
																			}),
																		_1: {ctor: '[]'}
																	}
																},
																{ctor: '[]'}),
															_1: {ctor: '[]'}
														}
													}
												}
											}
										}),
									_1: {
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$p,
											{
												ctor: '::',
												_0: _elm_lang$html$Html_Attributes$class('lead text-muted'),
												_1: {ctor: '[]'}
											},
											{
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$p,
													{ctor: '[]'},
													{
														ctor: '::',
														_0: _elm_lang$html$Html$text('My playground I use for playing with fancy and exciting technologies.'),
														_1: {ctor: '[]'}
													}),
												_1: {
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$p,
														{ctor: '[]'},
														{
															ctor: '::',
															_0: _elm_lang$html$Html$text('§'),
															_1: {ctor: '[]'}
														}),
													_1: {
														ctor: '::',
														_0: A2(
															_elm_lang$html$Html$p,
															{ctor: '[]'},
															{
																ctor: '::',
																_0: _elm_lang$html$Html$text('This one\'s for '),
																_1: {
																	ctor: '::',
																	_0: A2(
																		_elm_lang$html$Html$a,
																		{
																			ctor: '::',
																			_0: _elm_lang$html$Html_Attributes$href('http://elm-lang.org/'),
																			_1: {ctor: '[]'}
																		},
																		{
																			ctor: '::',
																			_0: _elm_lang$html$Html$text('elm'),
																			_1: {ctor: '[]'}
																		}),
																	_1: {
																		ctor: '::',
																		_0: _elm_lang$html$Html$text(' and '),
																		_1: {
																			ctor: '::',
																			_0: A2(
																				_elm_lang$html$Html$a,
																				{
																					ctor: '::',
																					_0: _elm_lang$html$Html_Attributes$href('https://getbootstrap.com/'),
																					_1: {ctor: '[]'}
																				},
																				{
																					ctor: '::',
																					_0: _elm_lang$html$Html$text('bootstrap'),
																					_1: {ctor: '[]'}
																				}),
																			_1: {ctor: '[]'}
																		}
																	}
																}
															}),
														_1: {ctor: '[]'}
													}
												}
											}),
										_1: {ctor: '[]'}
									}
								}),
							_1: {ctor: '[]'}
						}),
					_1: {
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$div,
							{
								ctor: '::',
								_0: _elm_lang$html$Html_Attributes$id(
									_ccamel$playground_elm$App_View$contentId(model.route)),
								_1: {ctor: '[]'}
							},
							{
								ctor: '::',
								_0: _ccamel$playground_elm$App_View$content(model),
								_1: {ctor: '[]'}
							}),
						_1: {ctor: '[]'}
					}
				}
			});
	};

	var _ccamel$playground_elm$Main$init = function (location) {
		var currentRoute = _ccamel$playground_elm$App_Routing$parseLocation(location);
		return {
			ctor: '_Tuple2',
			_0: _ccamel$playground_elm$App_Models$initialModel(currentRoute),
			_1: _elm_lang$core$Platform_Cmd$none
		};
	};
	var _ccamel$playground_elm$Main$main = A2(
		_elm_lang$navigation$Navigation$program,
		_ccamel$playground_elm$App_Messages$OnLocationChange,
		{init: _ccamel$playground_elm$Main$init, view: _ccamel$playground_elm$App_View$view, update: _ccamel$playground_elm$App_Update$update, subscriptions: _ccamel$playground_elm$App_Subscriptions$subscriptions})();

	var Elm = {};
	Elm['Main'] = Elm['Main'] || {};
	if (typeof _ccamel$playground_elm$Main$main !== 'undefined') {
	    _ccamel$playground_elm$Main$main(Elm['Main'], 'Main', undefined);
	}

	if (typeof define === "function" && define['amd'])
	{
	  define([], function() { return Elm; });
	  return;
	}

	if (typeof module === "object")
	{
	  module['exports'] = Elm;
	  return;
	}

	var globalElm = this['Elm'];
	if (typeof globalElm === "undefined")
	{
	  this['Elm'] = Elm;
	  return;
	}

	for (var publicModule in Elm)
	{
	  if (publicModule in globalElm)
	  {
	    throw new Error('There are two Elm modules called `' + publicModule + '` on this page! Rename one of them.');
	  }
	  globalElm[publicModule] = Elm[publicModule];
	}

	}).call(this);



/***/ })
/******/ ]);