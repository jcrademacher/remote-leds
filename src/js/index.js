'use strict';

require('../css/main.scss');

import iro from "@jaames/iro";

// Require index.html so it gets copied to dist

var Elm = require('../elm/Main.elm');
var mountNode = document.getElementById('main');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);

var colorPicker;

app.ports.mountColorPicker.subscribe(() => {
  colorPicker = colorPicker || new iro.ColorPicker("#color-picker-container", {
   width: 600,
   height: 600
 });
});

app.ports.getHSV.subscribe(() => {
  return colorPicker ? colorPicker.color.hsv : { h: 0, s: 0, v: 0};
});
