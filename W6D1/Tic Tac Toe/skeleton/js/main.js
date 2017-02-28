const View = require("./ttt-view.js"); // require appropriate file
const Game = require("../../solution/game.js"); // require appropriate file

$( () => {
  const rootEl = $(".ttt");
  const game = new Game();
  new View(game, rootEl);
});
