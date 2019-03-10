'use strict';
const os = require('os');
const delaySeconds = 1;
const decimals = 2;
function loop() {
  console.log(cpuLoad());
  setTimeout(loop, delaySeconds * 1000);
}
function cpuLoad() {
  let cpuLoad = os.loadavg()[0] * 100;
  return cpuLoad.toFixed(decimals);
}
loop();
