http = require "http"
server = http.createServer()
dynamicProxy = require("dynamic-reverse-proxy")()

server.on "request", (req, res) ->

  logReq = ->
    console.log req.connection.remoteAddress + '  ' + req.method + ' ' + req.url

  try
    logReq()
    if req.url.match /^\/register/i
      dynamicProxy.registerRouteRequest req, res
    else if req.url.match /^\/routes/i
      try
        res.write JSON.stringify dynamicProxy.routes
      catch e
        res.write JSON.stringify e
      res.end()
    else
      dynamicProxy.proxyRequest req, res
  catch e
    console.log e

port = process.env.PORT || 80
server.listen port, (err) ->
  console.log err
  console.log "Reverse Proxy started, listening on port " + port
