const APIUtil = require("./api_util.js");

class TweetCompose {
  constructor (el) {
    this.$el = $(el);
    this.$input = this.$el.find("textarea[name=tweet\\[content\\]]");
    this.$input.on("input", this.handleInput.bind(this));
    this.$el.on("submit", this.submit.bind(this));
  }

  submit (evt) {
    evt.preventDefault();
    let data = this.$el.serializeJSON();
    this.$el.find(":input").prop("disabled", true);
    APIUtil.createTweet(data).then((tweet) => { this.handleSuccess(tweet);});
  }

  clearInput () {
    this.$input.val("");
    this.$el.find(":input").prop("disabled", false);
    this.$el.find(".chars-left").empty();
  }

  handleInput (evt) {
    let inputLength = this.$input.val().length;
    this.$el.find(".chars-left").text(`You have ${140 - inputLength} characters remaining...`);
  }

  handleSuccess (data) {
    let $li = $("<li>");
    $li.text(this.$el.data.JSON.stringify);
    $("ul#feed").append($li);
    this.clearInput();
  }
}

module.exports = TweetCompose;
