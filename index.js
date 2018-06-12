const express = require('express');

const app = express();

const server = require('http').createServer(app);

app.get('/', function (req, res) {
    res.end("hello, docker + nodejs");
});

app.get('/welcome', function (req, res) {
    res.end("hello, world!");
});

let port = process.env.HTTP_PORT || 9000;

server.listen(port);

console.log('Listening on port %s', port);