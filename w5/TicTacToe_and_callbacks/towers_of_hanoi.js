var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame(difficulty) {
  var stack = [];
  for (var i = difficulty; i > 0; i--) {
    stack.push(i)
  };
  this.stacks = [stack, [], []];
};

HanoiGame.prototype.isWon = function () {
  return (this.stacks[0].length === 0 &&
    (this.stacks[1].length === 0 || this.stacks[2].length === 0))
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  if (startTowerIdx < 0 || startTowerIdx > 2 || endTowerIdx < 0 || endTowerIdx > 2) {
    return false;
  } else if ( this.stacks[startTowerIdx].length === 0 ) {
    return false;
  } else if ( this.stacks[endTowerIdx].length === 0 ) {
    return true;
  } else {
    var startTower = this.stacks[startTowerIdx];
    var disk = startTower[startTower.length - 1];
    var endTower = this.stacks[endTowerIdx];
    var disk2 = endTower[endTower.length - 1];
    return ( disk < disk2 );
  }
}

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx)  { //assume we can do this
  this.stacks[endTowerIdx].push( this.stacks[startTowerIdx].pop() )
}

HanoiGame.prototype.print = function () {
  for (var i = 0; i < this.stacks.length; i++) {
    console.log( i + " " + JSON.stringify(this.stacks[i]) ) ;
  }
}

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("From which stack do you want to take?  ", function (startIdx) {
    reader.question("To which stack do you want to place?  ", function (endIdx) {
      callback(parseInt(startIdx), parseInt(endIdx));
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  if (this.isWon()) {
    reader.close();
    completionCallback();
  } else {
    this.promptMove(function (startTowerIdx, endTowerIdx) {
      if (this.isValidMove(startTowerIdx, endTowerIdx)) {
        this.move(startTowerIdx, endTowerIdx);
      } else {
        console.log("Invalid move!");
      }
      this.run(completionCallback);
    }.bind(this));
  }
};

var game = new HanoiGame(4);
game.run(function () {
  game.print();
  console.log("Congrats!");
})


// unused method
// HanoiGame.prototype._ordered = function (stack) {
//   if (stack.length <= 1) {
//     return true;
//   } else {
//     if (stack[0] > stack[1]) {
//       return this._ordered(stack.slice(1));
//     } else {
//       return false;
//     }
//   }
// };
