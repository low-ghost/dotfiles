const fs = require('fs');
const path = require('path');

const repl = require('repl').start({ignoreUndefined: true, useGlobal:true,completer:console.log.bind(console)});
