require 'coffee-script/register'
sentc = require './lib/sentiment'
express = require 'express'
app = express();

middleware = (req, res, next) ->
	res.setHeader('Content-Type', 'application/json')
	console.log("request to: " + req.url)
	next();

server = app.listen 3000, () ->
	console.log('Listening at http://%s:%s', server.address().address, server.address().port)
