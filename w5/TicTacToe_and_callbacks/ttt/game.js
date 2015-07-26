var tttBoard = require("./board.js");

function Game (reader) {
  this.reader = reader;
  this.board = new tttBoard ();
  this.markers = ["x", "o"];
}

Game.prototype.currentPlayer = function () {
  this.markers[0];
};

Game.prototype.rotatePlayers = function () {
  this.markers.unshift( this.markers.pop() );
};


Game.prototype.run = function (completionCallback) {
  if ( this.board.isWon(this.markers[1]) ) {
    console.log("Congratulations " + this.markers[1] + " won!")
    //todo callback
  } else if (this.board.draw()) {
    console.log("DRAW");
    //todo write draw and callback
  }
  this.board.render()
  console.log ( "the current player is " + this.currentPlayer())
  reader.question(" Where would you like to move? (row)", function (userInput1) {
    reader.question(" Where would you like to move? (col)", function (userInput2) {
      if ( this.board.validMove(parseInt(userInput1), parseInt(userInput2), this.currentPlayer() ) ) {
        this.rotatePlayers();
      } else {
        console.log("invalid move!");
      }
    }
    this.run(completionCallback);
  }

};
