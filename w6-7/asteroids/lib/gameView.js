(function () {
  var Asteroids = window.Asteroids = window.Asteroids || {};
  var GameView = Asteroids.GameView = function (ctx, game) {
    this.game = game;
    this.ctx = ctx;
  }

  GameView.prototype.start = function () {
    var that = this;
    var ctx = canvasEl.getContext("2d");
    this.bindViewMethods();
    var img = new Image();
    img.src = 'Space-Picture-Desktop.jpg';
    setInterval(function () {
      ctx.drawImage(img,0, 0);
      console.log("doing a thing")
      that.game.step();
      that.game.draw(ctx, img);
    }, 1000 / 60)
  };

  GameView.prototype.bindViewMethods = function (first_argument) {
    var that = this;
    key('up', function() {
      that.game.ship.power([0, -1]);
    });
    key('left', function() {
      that.game.ship.power([-1, 0]);
    });
    key('down', function() {
      that.game.ship.power([0, 1]);
    });
    key('right', function() {
      that.game.ship.power([1, 0]);
    });
    key('space', function() {
      console.log("FIRED")
      that.game.ship.fireBullet();
    });
  };
})();
