'use strict';

require('../css/main.scss');

// Require index.html so it gets copied to dist

var Elm = require('../elm/Main.elm');
var mountNode = document.getElementById('main');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);
