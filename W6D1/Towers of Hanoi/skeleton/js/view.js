class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;

    this.setupTowers();
    this.render();
  }

  setupTowers() {

    for (let i = 0; i < 3; i++){
      const $ul = $("<ul>");
        for (let j = 0; j < 3; j++) {
          let $li = $("<li>");
          $ul.append($li);
        }
        this.$el.append($ul);
      }
  }


  render() {
    const towers = this.game.towers;
    const $stacks = $("ul");
    $stacks.each((i, ul) => {
      $(ul).children().each((j, li) => {
        let discVal = towers[i][j];
        if (discVal === 1) {
          $(li).toggleClass("disc-1");
        } else if (discVal === 2) {
          $(li).toggleClass("disc-2");
        } else if (discVal === 3) {
          $(li).toggleClass("disc-3");
        } else {
          $(li).removeClass();
        }
      });
    });
  }
}

module.exports = View;
