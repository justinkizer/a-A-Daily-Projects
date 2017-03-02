const APIUtil = require("./api_util.js");

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
