var express = require('express');
var app = express();
var path = require('path');

//var path = __dirname + '/public';

var newpath = path.join(__dirname, '..', 'index.html');
console.log(newpath);
var port = 8080;

app.use(express.static(newpath));
app.get('*', function(req, res) {
    res.sendFile(newpath);
});
app.listen(port);
