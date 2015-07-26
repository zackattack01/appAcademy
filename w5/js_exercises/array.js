Array.prototype.uniq = function () {
  var occurrenceHash = {};
  var result = [];
  for (var i = 0; i < this.length; i++) {
    if (!occurrenceHash[this[i]]) {
        occurrenceHash[this[i]] = true;
        result.push(this[i]);
    }
  }
  return result;
}

Array.prototype.twoSum = function () {
  var result = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[j] === -this[i]) {
        result.push([i, j]);
      }
    }
  }
  return result;
};

Array.prototype.transpose = function () {
  var result = []
  for (var row = 0; row < this.length; row++) {
    for (var col = 0; col < this[0].length; col++) {
      if (!result[col]) {
        result[col] = [this[row][col]]
      } else {
        result[col].push(this[row][col])
      }
    }
  }
  return result;
}
