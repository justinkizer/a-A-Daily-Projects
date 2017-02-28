class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;

    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    $("li").on("click", (e) => {
      const currentTarget = $(e.currentTarget);
      let currentPlayer = this.game.currentPlayer;
      try { this.game.playMove(currentTarget.data("pos"));
    } catch (error) {
      alert("Invalid move!");
      return;
    }
      currentTarget.addClass(`${currentPlayer}`);
      currentTarget.addClass("marked");
      currentTarget.html(currentPlayer);
      let that = this;
      if(this.game.isOver()){
        $("li").off("click");
        const winner = that.game.board.winner();
        $("li").each(function(i, li){
          if ($(li).hasClass(winner)) {
            $(li).addClass("winner");
          } else {
            $(li).addClass("loser");
          }
        });
        
        setTimeout(function() {if(winner){
          alert(`${winner} wins!`);
          return;
        } else {
          alert("Cat's game.");
          return;
        }}, 0);
      }
    });
  }
  makeMove($square) {

  }

  setupBoard() {
    const $ul = $("<ul>");

    for (let i = 0; i < 3; i++) {
      for (let j = 0; j < 3; j++) {
        let pos = [i, j];
        let $li = $("<li>");
        $li.data("pos", pos);
        $ul.append($li);
      }
    }
    this.$el.append($ul);

  }
}

module.exports = View;
