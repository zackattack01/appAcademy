(function () {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  // Game.DIM_X = 10;
  // Game.DIM_y = 10;

  var Game = Asteroids.Game = function (dimX, dimY) {
    this.dimX = dimX;
    this.dimY = dimY;
    this.asteroids = [];
    this.addAsteroids();
    shipPos = this.randomPos()
    this.ship = new Asteroids.Ship(shipPos, this)
    this.bullets = []
  }

    Game.NUM_ASTEROIDS = 10;

  Game.prototype.addAsteroids = function (first_argument) {
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      this.asteroids.push(new Asteroids.Asteroid(this.randomPos(), this))
    }
  };

  Game.prototype.allObjects = function (){
  return this.asteroids.concat([this.ship], this.bullets);
  };

  Game.prototype.randomPos = function () {
    var x = Math.random() * this.dimX;
    var y = Math.random() * this.dimY;
    return [x, y];
  };

  Game.prototype.moveObjects = function () {
    var objects = this.allObjects();
    for (var i = 0; i < this.allObjects().length; i++) {
      objects[i].move();
    };
  };

  Game.prototype.draw = function (ctx, img) {
    //ctx.clearRect(0, 0, this.dimX, this.dimY);
    ctx.drawImage(img, 0, 0);
    for (var i = 0; i < this.allObjects().length; i++) {
      var object = this.allObjects()[i]
      object.draw(ctx);
    };
  };

  Game.prototype.wrap = function (pos) {
    pos[0] = mod(pos[0], this.dimX);
    pos[1] = mod(pos[1], this.dimY);
    return pos;
  };

  Game.prototype.checkCollisions = function () {
    allObjectsX = this.allObjects()
    for (var i = 0; i < allObjectsX.length; i++) {
      for (var j = 0; j < allObjectsX.length; j++) {
        if (!(i === j) && allObjectsX[i].isCollidedWith(allObjectsX[j])){
          allObjectsX[i].collideWith(allObjectsX[j])
        }
      }
    }
  };


  Game.prototype.remove = function (object) {
    if (object instanceof Asteroids.Asteroid){
      var idx = this.asteroids.indexOf(object);
      this.asteroids.splice(idx, 1);
    } else if (object instanceof Asteroids.Bullet){
      var idx = this.bullets.indexOf(object);
      this.bullets.splice(idx, 1);
    }
  };

  Game.prototype.add = function (object) {
    if (object instanceof Asteroids.Asteroid){
      this.asteroids.push(object);
    } else if (object instanceof Asteroids.Bullet){
      this.bullets.push(object);
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.outOfBounds = function (pos) {
  xOutOfBounds = pos[0] < 0 || pos[0] > this.dimX;
  yOutOfBounds = pos[1] < 0 || pos[1] > this.dimY;
  return xOutOfBounds || yOutOfBounds;
  };

  function mod(n,x){
    if (n <= x && n >= 0 ){
      return n;
    } else if (n > x) {
      return mod(n-x, x);
    } else if (n < 0) {
      //console.log(n);
      return mod(n+x, x);
    }
  }

})();
