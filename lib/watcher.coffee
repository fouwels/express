require 'coffee-script/register'
credentials = require '../data/credentials'
Twitter = require('twitter');

class exports.Watcher
	t = {}
	constructor: () ->
		t = new Twitter {
			consumer_key: credentials.creds.consumer_key
			consumer_secret: credentials.creds.consumer_secret,
			access_token_key: credentials.creds.access_token_key,
			access_token_secret: credentials.creds.access_token_secret
		}

	onTweet: (tweet) =>
		#if (tweet.text != undefined)
		process.stdout.write("[t]")

	start: (keywords) =>
		console.log("(re)starting server")
		str = ""
		if keywords.length == 0
			console.log('no watches, starting null keyword stream')
			str = "oighaeiorhgeroiHJGERIOG" #OH MY GOD SO HACK EY
		else
			str += word + "," for word in keywords
		console.log("word:" + str)
		t.stream('statuses/filter', {track: str}, (stream) =>
			stream.on('data', (tweet) => this.onTweet(tweet)
			)
		)


		###
		console.log("Started watcher")
		interval = setInterval(this.tick, 10000)
	tick: () ->
		console.log("ticked")
		###
