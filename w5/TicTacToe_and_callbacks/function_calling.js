

Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    fn.apply(context);
  }
}

function Cat (name) {
  this.name = name;
}

Cat.prototype.meow = function () {
      console.log (this.name + " meows")
    }

Cat.prototype.delayed_meow = function () {
  var boundMeow = this.meow.myBind(this)
  setTimeout(
    boundMeow
    ,
    2000
  )
}

var gizmo = new Cat ("Gizmo")

console.log (gizmo.meow())
console.log (gizmo.delayed_meow())
