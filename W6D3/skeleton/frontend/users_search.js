const APIUtil = require("./api_util.js");
const FollowToggle = require("./follow_toggle.js");

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
