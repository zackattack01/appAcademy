function Clock () {
  this.currentTime = null;
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  console.log( this.currentTime.getHours() + ":" +
              this.currentTime.getMinutes() + ":" +
              this.currentTime.getSeconds()
    )
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  var self = this;
  var boundTick = this._tick.bind(self)
  boundTick()
  setInterval( function () {
      // self._tick.call(self);
      boundTick();
    }, Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  this.currentTime = new Date();
  this.printTime();
};

var clock = new Clock();
clock.run();
