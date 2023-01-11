const http = require('http');

http.createServer((_, res)=>{
    res.write('Hello Pirelli!');
    res.end();
}).listen(4040);