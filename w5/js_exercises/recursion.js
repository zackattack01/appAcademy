function rangeLoop(start, fin, arr) {
  if (start === fin) {
    return arr;
  } else {
    arr.push(start);
    return rangeLoop(start + 1, fin, arr);
  }
};

function range(start, fin) {
  return rangeLoop(start + 1, fin, []);
};

// console.log(range(4, 17))

function sum(arr) {
  if (arr.length === 0) {
    return 0;
  } else {
    return arr[0] + sum(arr.slice(1));
  }
};

var arr = [1,2,3];

// console.log(sum(arr)

function exp1(b, e) {
  if (e === 0) {
      return 1;
  }
  else {
    return b * exp1(b, e - 1);
  }
};

// console.log(exp1(2,3));

function exp2(b, e) {
  if (e === 0) {
    return 1;
  }
  else if (e === 1) {
    return b;
  } else if (e % 2 === 0) {
    var squareRoot = exp2(b, (e / 2));
    return squareRoot * squareRoot;
  } else {
    var squareRoot = exp2(b, ((e - 1) / 2));
    return (b * squareRoot * squareRoot);
  }
};

// console.log(exp2(2, 3));

function fibs(n) {
  if (n === 0) {
      return [];
  }
  else if (n === 1) {
      return [0];
  }
  else if (n === 2) {
    return [0, 1];
  }
  else {
  var prev_fibs = fibs(n - 1);
  prev_fibs.push(prev_fibs[prev_fibs.length - 1] + prev_fibs[prev_fibs.length - 2]);
  return prev_fibs;
  }
};

// console.log(fibs(100));



function binarySearch(arr, target) {
  var pivot = Math.floor(arr.length / 2);
  if (arr.length <= 1 && arr[0] !== target) {
    return null;
    console.log("null");
  } else {

    if (arr[pivot] === target) {
      return pivot;
    }
    else if (arr[pivot] < target) {
      return (pivot + 1 + binarySearch(arr.slice(pivot + 1), target));
    } else {
      return binarySearch(arr.slice(0, pivot), target);
    }
  }
};

// console.log(binarySearch([1, 2, 3, 4, 5], 3))
Array.prototype.mySelect = function(condition) {
    var result = [];
    this.forEach(function (el) {
      if (condition(el)) {
        result.push(el);
      }
    }
  );
  return result;
};

// var arr = [1,2,3,4,5];
// console.log(arr.mySelect(function (el) {
//   return el % 2 == 0;
// }));

Array.prototype.includes = function(el) {
  var notSeen = true;
  for (var i = 0; i < this.length; i++) {
    if (this[i] === el) {
        return true
    }
  }
  return false;
};


function bestWayToMakeChange(coins, sum) {
  if (coins.includes(sum)) {
    return [sum];
  }
  else {
    var bestCombo = null;
    var remCoins = coins.mySelect(function(coin) {
      return coin < sum;
    });
    remCoins.forEach(function (coin) {
      currentCombo = [coin].concat(bestWayToMakeChange(remCoins, sum - coin));
      if (!bestCombo || currentCombo.length < bestCombo.length) {
          bestCombo = currentCombo;
      }
    });
  }
  return bestCombo;
};

// console.log(bestWayToMakeChange([10, 7, 1], 14));

function merge(left, right) {
  var merged = []
  while(left.length !== 0 && right.length !== 0) {
      if (left[0] <= right[0]) {
        merged.push(left.shift());
      }
      else {
        merged.push(right.shift());
      }
    };
    return merged.concat(left).concat(right);
}

// console.log(merge([1,3,5,7], [0,2,4,6]));

Array.prototype.mergeSort = function () {
  if (this.length <= 1) {
    return this;
  }
  else {
    var pivot = Math.floor(this.length / 2)
    var left = this.slice(0, pivot).mergeSort();
    var right = this.slice(pivot).mergeSort();
    return merge(left, right);
  }
}

// console.log([5,4,3,2,1].mergeSort());

function subsets(arr) {
  if (arr.length === 0) {
    return [[]];
  }
  else {
    var prevSubs = subsets(arr.slice(1));

    return prevSubs.concat(prevSubs.map(function (sub) {
      return sub.concat([arr[0]]);
    }));
  };
};

console.log(subsets(String([1,2,3,4,5])));
