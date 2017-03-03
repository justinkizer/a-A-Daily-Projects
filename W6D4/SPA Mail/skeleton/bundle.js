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

const Router = __webpack_require__(1);
const Inbox = __webpack_require__(2);

document.addEventListener("DOMContentLoaded", addListeners);

function addListeners (event) {
  $(".sidebar-nav li").each((i, el) => {
    el.addEventListener("click", listenerHelper);
  });
}

function listenerHelper (event) {
  event.preventDefault();
  let location = event.target.innerText.toLowerCase();
  window.location.hash = location;
  let router = new Router(document.querySelector(".content"), routes);
  router.start();
}

const routes = {
  compose: undefined,
  inbox: Inbox,
  sent: undefined
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

function Router (node, routes) {
  this.node = node;
  this.routes = routes;
}

Router.prototype.start = function () {
  this.render();
  window.addEventListener("hashchange", this.render.bind(this));
};

Router.prototype.activeRoute = function () {
  console.log(this.routes[`${window.location.hash.slice(1)}`]);
  return window.location.hash.slice(1);
};

Router.prototype.render = function (node) {
  this.node.innerHTML = "";
  let newRoute = this.activeRoute();
  let newNode = document.createElement("p");
  newNode.innerHTML = newRoute;
  this.node.appendChild(newNode);
};

module.exports = Router;
//
// Change activeRoute.
// activeRoute should return the component that matches the current route instead of just returning the name of the route.
//
// Look up the appropriate component for the current route by accessing the this.routes object using the location name you retrieved from the hash. Make sure you have removed "#" from the name.
// Return the component.


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const Inbox = {
  render () {
    let $ul = document.createElement("ul");
    $ul.className = "messages";
    $ul.innerHTML = "An Inbox Message";
    return $ul;
  }
};

module.exports = Inbox;


/***/ })
/******/ ]);