
Function.prototype.inherits = function (parent, child) {
  let Surrogate = function () {};
  Surrogate.prototype = parent.prototype;
  child.prototype = new Surrogate();
  child.prototype.constructor = child;
};

function MovingObject () {
}

Asteroid.inherits(MovingObject, Asteroid);
Ship.inherits(MovingObject, Ship);

MovingObject.prototype.move = function () {
  console.log("Move!");
};

function Ship (type) {
  this.type = type;
}

function Asteroid () {}

Asteroid.prototype.explode = function () {
  console.log("explode!");
};

// Ship.prototype = Object.create(MovingObject.prototype);
// Asteroid.prototype = Object.create(MovingObject.prototype);

const s = new Ship ("spaceship");
s.move();

const ast = new Asteroid ();
ast.explode();
