require 'coffee-script/register'
credentials = require '../data/credentials'
Twitter = require('twit');

class exports.Watcher
	T = {}
	stream = {}
	constructor: () ->

	onTweet: (tweet) =>
		#process.stdout.write("[t]")
		console.log(tweet.text)

	start: (keywords) =>
		T = new Twitter { #recreating object each time to prevent stream update fuckery
			consumer_key: credentials.creds.consumer_key
			consumer_secret: credentials.creds.consumer_secret,
			access_token: credentials.creds.access_token_key,
			access_token_secret: credentials.creds.access_token_secret
		}

		console.log("(re)starting server")
		str = ""

		if keywords.length == 0
			console.log('no watches, watching for /placeholder/ ')
			str = "asdasdaipjiuwghergiuergerophgeiuwgnwehiruerw;hu" #OH MY GOD SO HACK EY
		else
			str += word + "," for word in keywords
			str = str.slice(0, -1)

		#str = "'" + str + "'"
		console.log("word:" + str)
		stream = T.stream('statuses/filter', { track: str})
		stream.on('tweet', (tweet) => this.onTweet(tweet))

	restart: (keywords) =>
		stream.stop()
		this.start(keywords)
		stream.start()

		###
		console.log("Started watcher")
		interval = setInterval(this.tick, 10000)
	tick: () ->
		console.log("ticked")
		###
