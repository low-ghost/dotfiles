/**
 * Creates a unix socket server and waits for a python client to interact
 */
const net = require('net');
const fs = require('fs');
const repl = require("repl");

const socketPath = '/tmp/node-vim-repl';
// Callback for socket
const handler = (socket) => {

  // Listen for data from client
  socket.on('data', (bytes) => {

    // Decode byte string
    const msg = bytes.toString();

    console.log(msg);

  });

};

// Remove an existing socket
fs.unlink(
  socketPath,
  // Create the server, give it our callback handler and listen at the path
  () => net.createServer(handler).listen(socketPath)
);

// No prompt so we don't have to filter it out later
repl.start({ ignoreUndefined: true, useGlobal: true, prompt: '' });
