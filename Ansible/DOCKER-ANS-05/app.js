const http = require('http');
http.createServer((req, res) => {
  res.writeHead(200);
  res.end('Hello from Ansible auto deploy!');
}).listen(3000);
