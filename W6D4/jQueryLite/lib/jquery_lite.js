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
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.l = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };

/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};

/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};

/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);
const coreFunction = function (selector) {
  let htmlElementsArray;
  if (typeof(selector) === "string") {
    htmlElementsArray = Array.from(document.querySelectorAll(selector));
  } else if (selector instanceof HTMLElement) {
    htmlElementsArray = Array.from(selector);
    if (htmlElementsArray.length === 0) {
      htmlElementsArray = [selector];
    }
  }
  return new DOMNodeCollection(htmlElementsArray);
};
window.$l = coreFunction;

module.exports = coreFunction;


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor (htmlElementsArray) {
    this.$elements = htmlElementsArray;
  }

  empty () {
    for (let i = 0; i < this.$elements.length; i++) {
      this.$elements[i].innerHTML = "";
    }
  }

  append (content) {
    if (typeof(content) === "string") {
      for (let i = 0; i < this.$elements.length; i++) {
        this.$elements[i].innerHTML += content;
      }
    } else if (content instanceof HTMLElement) {
      for (let i = 0; i < this.$elements.length; i++) {
        this.$elements[i].innerHTML += content.outerHTML;
      }
    } else if (content instanceof DOMNodeCollection) {
      for (let i = 0; i < this.$elements.length; i++) {
        for (let j = 0; j < content.$elements.length; j++) {
          this.$elements[i].innerHTML += content.$elements[j].outerHTML;
        }
      }
    }
  }

  remove () {

  }

  attr (attributeName, value) {
    if (value) {
      this.$elements[0].setAttribute(attributeName, value);
    } else {
      return this.$elements[0].getAttribute(attributeName);
    }
  }

  addClass (className, value) {
    if (value) {
      this.$elements[0].className = value;
      return this.$elements[0].className;
    }
  }

  removeClass (className) {
    if (this.$elements[0].className === className) {
      this.$elements[0].className = "";
      return this.$elements[0].className;
    }
  }

  html (string) {
    if (typeof(string) === "string") {
      for (let i = 0; i < this.$elements.length; i++) {
        this.$elements[i].innerHTML = string;
      }
    } else {
      return this.$elements[0].innerHTML;
    }
  }

  find () {

  }

  children () {

  }

  parent () {

  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);