/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
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
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);

$(function () {
  $("button.follow-toggle").each((i, el) => { new FollowToggle(el, {}); });
  $("nav.users-search").each((i, el) => { new UsersSearch(el, {}); });
 } );


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class FollowToggle {
  constructor (el, params) {
    this.$el = $(el);
    this.userId = (this.$el.data("user-id") || params.userId);
    this.followState = (this.$el.data("initial-follow-state") || params.followState);
    this.render();
    this.$el.on("click", this.handleClick.bind(this));
  }

  render () {
    if (this.followState === "following" || this.followState === "unfollowing") {
      this.$el.prop("disabled", true);
    } else if (this.followState === "unfollowed") {
      this.$el.html("Follow!");
      this.$el.prop("disabled", false);
    } else if (this.followState === "followed") {
      this.$el.html("Unfollow!");
      this.$el.prop("disabled", false);
    }
  }

  handleClick (evt) {
    let that = this;
    evt.preventDefault();
    if (that.followState === "unfollowed") {
      that.followState = "following";
      that.render();
      APIUtil.followUser(that.userId).then(() => {
        that.followState = "followed";
        that.render();
      });
    } else {
      that.followState = "unfollowing";
      that.render();
      APIUtil.unfollowUser(that.userId).then(() => {
        that.followState = "unfollowed";
        that.render();
      });
    }
  }
}

module.exports = FollowToggle;


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: id => (
    $.ajax({
      type: 'POST',
      dataType: "json",
      url: `/users/${id}/follow`,
    })
  ),

  unfollowUser: id => (
    $.ajax({
      type: 'DELETE',
      dataType: "json",
      url: `/users/${id}/follow`,
    })
  ),

  searchUsers: query => (
    $.ajax({
      type: 'GET',
      dataType: "json",
      url: "/users/search",
      data: { query }
    })
  ),

  createTweet: data => (
    $.ajax({
      type: 'POST',
      dataType: "json",
      url: "/tweets",
      data: { data }
    })
  )

};

module.exports = APIUtil;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

class UsersSearch {
  constructor (el) {
    this.$el = $(el);
    this.$input = this.$el.find("input[name=username]");
    this.$ul = this.$el.find(".users");
    this.$input.on("input", this.handleInput.bind(this));
  }

  handleInput (evt) {
    evt.preventDefault();
    APIUtil.searchUsers(this.$input.val()).then((users) => {this.renderResults(users);});
  }

  renderResults (users) {
    this.$ul.empty();
    for (var i = 0; i < users.length; i++) {
      let user = users[i];
      let $li = $(`<li><a href="${user.id}">${user.username}</a></li>`);
      let $followToggle = $("<button></button>");
      new FollowToggle($followToggle, {userId: user.id, followState: user.followed ? "followed" : "unfollowed"});
      $li.append($followToggle);
      this.$ul.append($li);
    }
  }
}

module.exports = UsersSearch;


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map