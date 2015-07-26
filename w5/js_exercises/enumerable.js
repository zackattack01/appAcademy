Array.prototype.myEach = function (callback) {
  for (var i = 0; i < this.length; i++) {
    callback(this[i]);
  }
  return this;
}

// var arr = [1,2,3];


// arr.myEach(function (el) {
//   console.log(el + 1);
// });

Array.prototype.myMap = function (callback) {
  var result = []
  this.myEach(function (el) {
    result.push(callback(el));
  })
  return result;
}

// console.log(arr.myMap(function (el) {
//   return el * el;
// }));

Array.prototype.inject = function (callback) {
  var accum = this[0];
  this.slice(1).myEach(function (el) {
    accum = callback(accum, el);
  });
  return accum;
};

// var arr = [1, 2, 3, 4, 5];
// console.log(arr.inject(function (accum, el){
//   return accum + el;
// }));
