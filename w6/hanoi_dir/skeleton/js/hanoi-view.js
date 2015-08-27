(function () {
  if (typeof Hanoi === 'undefined') {
    window.Hanoi = {};
  }

  var View = window.Hanoi.View = function (game, $el) {
    this.game = game;
    this.setupTowers();
    this.render();
    this.selectedTower = null;
    this.clickTower();
  };

  View.prototype.setupTowers = function () {
    for (var i = 0; i < 3; i++) {
      var $tower = $("<div class='tower'></div>");
      $tower.data("i", i);
      $el.append($tower);
      for (var j = 0; j < 3; j++) {
        var $disc = $("<div class='disc'></div>");
        $disc.data("i", i);
        $disc.data("j", j);
        $tower.append($disc);
      }
    }
  };

  View.prototype.render = function () {
    var currentTowers = this.game.towers;
    var $discSpaces = $(".disc");
    $discSpaces.removeClass("emptyDisc big medium small");
    for (var idx = 0; idx < $discSpaces.length; idx++) {
      var $disc = $($discSpaces[idx]);
      var i = $disc.data("i");
      var j = $disc.data("j");
      if (currentTowers[i][j]) {
        if (currentTowers[i][j] === 3) {
          $disc.addClass("big");
        } else if (currentTowers[i][j] === 2) {
          $disc.addClass("medium");
        } else if (currentTowers[i][j] === 1) {
          $disc.addClass("small");
        }
      } else {
        $disc.addClass("emptyDisc");
      }
    }
    };

    View.prototype.clickTower = function () {
      var that = this;
      $(".tower").on("click", function (event) {
        var $tower = $(event.currentTarget);
        var towerNum = $tower.data("i");
        if (that.selectedTower !== null) {
          var $selectedTower = $(".selected");
          if (that.game.move(that.selectedTower, towerNum)) {
            that.selectedTower = null;
            $selectedTower.removeClass("selected");
          } else {
            alert("invalid move");
          }
          if (that.game.isWon()) {
            $el.append("<div class='congrats'>Congratulations!</div>");
          }
        } else {
          that.selectedTower = towerNum;
          $tower.addClass("selected");
        }
        that.render();
      })
    };

})();
