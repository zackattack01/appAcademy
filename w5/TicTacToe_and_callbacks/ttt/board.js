function Board () {
  this.grid = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]];
}

Board.prototype.render = function () {
  for (var i = 0; i < this.grid.length; i++) {
    console.log( JSON.stringify(this.grid[i]) );
  }
}

Board.prototype.placeMark = function (row, col, mark) {
  this.grid[row][col] = mark;
}

Board.prototype.isWon = function (mark) {
  var cols = this._columns();
  var diags = this._diags();
  for (var i = 0; i < 3; i++) {
    if (
         this._winningLine(this.grid[i]) ||
         this.winningLine(cols[i])       ||
         this.winningLine(diags[i])
       ) {
      return true;
    }
  }
  return false;
};

Board.prototype.validMove = function (row, col, mark) {
  if ( this.onBard(row, col) && this.isEmpty(row, col) ) {
    this.placeMark(row, col, mark);
    return true;
  } else {
    return false;
  }
}

Board.prototype.isEmpty = function (row, col) {
  return this.grid[row][col] === " ";
}

Board.prototype.onBoard = function (row, col) {
  return (
    row < 3 && row >= 0 &&
    col < 3 && col >= 0
  )
}

Board.prototype._winningLine = function (mark, row) {
  for (var i = 0; i < row.length; i++) {
    if ( row[i] !== mark) {
      return false;
    }
  }
  return true;
}

Board.prototype._diags = function () {
  var grid = this.grid;
  return [
            [grid[0][0], grid[1][1], grid[2][2]],
            [grid[0][2], grid[1][1], grid[2][0]],
            [NaN, NaN, NaN]
         ];
}

Board.prototype._columns = function () {
  var transposed = [[], [], []];
  for (var row = 0; row < this.grid.length; row++) {
    for (var col = 0; col < this.grid.length; col++) {
      transposed[col].push(this.grid[row][col]);
    }
  }
  return transposed;
}

module.exports = Board
