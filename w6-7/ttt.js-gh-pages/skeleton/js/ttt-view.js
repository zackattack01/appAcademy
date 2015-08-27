(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = window.TTT.View = function (game, $el) {
    this.game = game;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $(".square").on("click", function (event) {
      var $square = $(event.currentTarget);
      var pos = [$square.data("i"), $square.data("j")];
      that.game.playMove(pos);
      that.makeMove($square);
    });
  };

  View.prototype.makeMove = function ($square) {
    $square.addClass("selected");
    if (this.game.currentPlayer === "x") {
      $square.addClass("o");
      $square.text("O");
    } else {
      $square.addClass("x");
      $square.text("X");
    }
    if (this.game.isOver()) {
      var winner = this.game.winner();
      var $congrats = $("<div></div>");
      var message = "Congrats, " + winner + "!";
      $congrats.text(message);
      $congrats.addClass("congrats");
      $el.append("<br>");
      $el.append($congrats);
    }
  };

  View.prototype.setupBoard = function () {
    for (var i = 0; i < 3; i++) {
      var $row = $("<div></div>");
      $row.addClass("row");
      $el.append($row);
      for (var j = 0; j < 3; j++) {
        var $square = $("<div></div>");
        $square.addClass("square group");
        $square.data("i", i);
        $square.data("j", j);

        $row.append($square);
      }
    }
  };
})();
