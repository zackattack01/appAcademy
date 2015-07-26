function Cat(owner, name) {
  this.name = name;
  this.owner = owner;
  this.cuteStatement = function () {
    return this.owner + " loves " + this.name;
  }
};

var gizmo = new Cat("me", "gizmo");
console.log(gizmo);
