require 'coffee-script/register'
sentc = require './lib/sentiment'
fs = require 'fs'
express = require 'express'
app = express()

file = './data/data.db'
sqlite3 = require('sqlite3').verbose()
db = new sqlite3.Database(file)

if !fs.existsSync(file)
	console.log('sqlite file(s) NOT found, creating fresh')
	db.parallelize( () ->
	db.run('CREATE TABLE watches(id INT, keyword VARCHAR(max), PRIMARY KEY(id)') #VARCHAR(max) yolo
	db.run('CREATE TABLE pings(id INT, watch_Id INT, tweet VARCHAR(144), sender VARCHAR(max), PRIMARY KEY(id), FOREIGN KEY(watch_Id) REFERENCES watches(id)')
	, (err, data) ->
	console.log('Err: ' + err + '\ndata' + data)
	s)

middleware = (req, res, next) ->
	#res.setHeader('Content-Type', 'application/json')
	console.log('request to: ' + req.url)
	next();

app.post('/watch/add', (req, res) ->
	console.log('ye')
)

app.get('/watch/getAll', (req, res) ->
	console.log('ye')
)

app.get('/ping/getForWatch/:id', (req, res) ->
	console.log('ye')
)

app.get('/ping/getAll', (req, res) ->
	console.log('ye')
)

app.get('*', (req, res) ->
	res.status(404).send('path -> checkit')
)

server = app.listen 3000, () ->
	console.log('Listening at http://%s:%s', server.address().address, server.address().port)
