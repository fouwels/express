require 'coffee-script/register'
sentc = require './lib/sentiment'
fs = require 'fs'
express = require 'express'
app = express()
bodyParser = require 'body-parser'

file = './data/data.db'
sqlite3 = require('sqlite3').verbose()
db = new sqlite3.Database(file)

if !fs.existsSync(file)
	console.log('sqlite file(s) NOT found, creating fresh')

db.parallelize( () ->
	db.run('CREATE TABLE IF NOT EXISTS Watches(id INTEGER PRIMARY KEY AUTOINCREMENT, keyword VARCHAR(255) NOT NULL);') #VARCHAR(max) yolo
	db.run('CREATE TABLE IF NOT EXISTS Pings(id INTEGER PRIMARY KEY AUTOINCREMENT, watch_Id INTEGER NOT NULL, tweet VARCHAR(144) NOT NULL, sender VARCHAR(255) NOT NULL, FOREIGN KEY(watch_Id) REFERENCES Watches(id));')
	)

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

middleware = (req, res, next) ->
	#res.setHeader('Content-Type', 'application/json')
	console.log('request to: ' + req.url)
	next();
app.use(middleware);

app.get(['/', '/watch/add'], (req, res) ->

)

app.post('/watch/add', (req, res) -> #?keyword=
	keyword = req.body['keyword']
	if keyword == null || keyword == "undefined"
		res.status(400).send("Invalid request")
	else
		db.serialize( () ->
			db.run('INSERT INTO Watches(keyword) VALUES(?);', keyword, (err, data) ->
				console.log("err: " + err + "\ndata: " + data)
			)
			###
					console.log()
					if err != null
						res.status(500).send(JSON.stringify(err))
					else

						db.all('SELECT * FROM Watches', null, (err, rows) ->
							if err != NULL
								res.status(500).send(JSON.stringify(err))
							else
								res.status(200).send(JSON.stringify(rows))
							)
							###
	)
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
