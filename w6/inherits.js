Function.prototype.inherits = function (parentClass) {
      var Surrogate = function(){};
      Surrogate.prototype = parentClass.prototype;
      this.prototype = new Surrogate();
      this.prototype.constructor = this;
};

function MovingObject () {};

function Ship () {};
Ship.inherits(MovingObject);

function Asteroid () {};
Asteroid.inherits(MovingObject);

MovingObject.prototype.goRight = function () {
  console.log("moved to the right");
};

Ship.prototype.useRockets = function () {
  console.log("rockets are on");
};

Asteroid.prototype.collide = function () {
  console.log("Hit something");
};

ship = new Ship()
asteroid = new Asteroid()
bird = new MovingObject()



asteroid.collide()

//ship.collide()

//bird.collide()
