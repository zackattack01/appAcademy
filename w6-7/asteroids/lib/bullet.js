(function () {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Bullet = Asteroids.Bullet = function (pos, vel, game) {
      options = {pos: pos, color: Bullet.COLOR, radius: Bullet.RADIUS, vel: vel, game: game}
      Asteroids.MovingObject.call(this, options)
    };

    Asteroids.Util.inherits(Bullet, Asteroids.MovingObject)

    Bullet.RADIUS = 5;
    //todo
    Bullet.COLOR = "#FFFF00"

    Bullet.prototype.collideWith = function (otherObject) {
      if (otherObject instanceof Asteroids.Asteroid){
        this.game.remove(otherObject);
      }
    };

    Bullet.prototype.move = function () {
      this.pos[0] += this.vel[0];
      this.pos[1] += this.vel[1];
      if (this.game.outOfBounds(this.pos)){
        this.game.remove(this);
        return null;
      } else {
        return this.pos;
      }
    };
})();
