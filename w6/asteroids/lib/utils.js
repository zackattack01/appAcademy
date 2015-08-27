(function (){
  var Util = window.Asteroids.Util = window.Asteroids.Util || {};

  Asteroids.Util.inherits = function (ChildClass, ParentClass) {
    var Surrogate = function (){};
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
    ChildClass.prototype.constructor = ChildClass;
  }

  Asteroids.Util.randomVec = function (length) {
    x = (Math.random() - 0.5) * 2 * length;
    y = (Math.random() - 0.5) * 2 * length;
    return [x,y];
  }

})();
