require 'coffee-script/register'
sentc = require './lib/sentiment'
express = require 'express'
app = express();

middleware = (req, res, next) ->
	#åååres.setHeader('Content-Type', 'application/json')
	console.log("request to: " + req.url)
	next();

app.post('/watch/add') ->

app.get('/watch/getAll') ->

app.get('/ping/getForWatch/:id') ->

app.get('/ping/getAll') ->


server = app.listen 3000, () ->
	console.log('Listening at http://%s:%s', server.address().address, server.address().port)
