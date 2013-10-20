var http = require("http");
var server = http.createServer();
var dynamicProxy = require("dynamic-reverse-proxy")();

server.on("request", function (req, res) {
  console.log(req.method + ' ' + req.url);
  if (req.url.match(/^\/register/i)) {
    dynamicProxy.registerRouteRequest(req, res);
  }
  else {
    dynamicProxy.proxyRequest(req, res);
  }
});

server.listen(80, function (err) {
  console.log(err);
  console.log("Reverse Proxy started, listening on port 80");
});
