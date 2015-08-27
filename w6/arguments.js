var sum = function () {
  var args = [].slice.call(arguments, 0);
  return args.reduce(function (prevEl, nextEl) {
    return prevEl + nextEl;
  });
};



Function.prototype.myBind = function (ctx) {
  var fn = this;
  var args = [].slice.call(arguments, 1);
  return function () {
    if (args.length === 0){
      args = [].slice.call(arguments, 0);
      }
    return fn.apply(ctx, args);
    }
  }


function Cat(name) {
  this.name = name;
};

Cat.prototype.says = function (sound) {
  console.log(this.name + " says " + sound + "!");
}

// markov = new Cat("Markov");
// breakfast = new Cat("Breakfast");
//
// markov.says("meow");
// // Markov says meow!
//
// markov.says.myBind(breakfast, "meow")();
// // Breakfast says meow!
//
// markov.says.myBind(breakfast)("meow");
// // Breakfast says meow!
//
// var notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow");
function curriedSum(numArgs) {
  var numbers = [];
  function _curriedSum(n) {
    numbers.push(n);
    if (numbers.length === numArgs) {
      return numbers.reduce(function(elCurrent, elNext){
        return elCurrent + elNext;
      });
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}

// var sum = curriedSum(4);
// console.log(sum(5)(30)(20));


Function.prototype.curry = function (numArgs) {
  var args = [];
  var that = this;
  return function _curriedFunction(newArg){
    args.push(newArg);
    if (args.length === numArgs) {
      return that.apply(null, [args]);
    } else {
      return _curriedFunction;
    }
  };
  // return _curriedFunction;
};

var sum = function (arr){
  return arr.reduce( function (elCurrent, elNext){
    return elCurrent + elNext;
  });
}

var curriedSumNew = sum.curry(4);
console.log(curriedSumNew(1)(2)(3)(4));
