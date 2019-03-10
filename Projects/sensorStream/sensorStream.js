'use strict';
var i2c = require('i2c');
var address = 0x21;
var wire = new i2c(address, {device: '/dev/i2c-1'}); // point to your i2c address, debug provides REPL interface

function loop() {

wire.scan(function(err, data) {
	console.log(data);
  setTimeout(loop, 1 * 1000);

  // result contains an array of addresses
});


}
loop();
