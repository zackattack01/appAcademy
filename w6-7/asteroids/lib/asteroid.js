(function () {
  var Asteroids = window.Asteroids = window.Asteroids || {};


var Asteroid = Asteroids.Asteroid = function (pos, game) {
    var vel = Asteroids.Util.randomVec(Asteroid.LENGTH)
    var color = randomGreen();
    options = {pos: pos, color: color, radius: Asteroid.RADIUS, vel: vel, game: game}
    Asteroids.MovingObject.call(this, options)
  };

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject)

  Asteroid.RADIUS = 40;
  //todo
  Asteroid.LENGTH = 5;
  Asteroid.COLOR = "#66FF66"

  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Ship){
      otherObject.relocate();
    }
  };

  var HEX_DIGITS = "0123456789ABCDEF"
  function randomGreen(){
    var color = "#66F"
    for (var i = 0; i < 3; i++) {
      color += HEX_DIGITS[Math.floor((Math.random() * 16))];
    }
    return color;
  }

})();
