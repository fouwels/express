require 'coffee-script/register'
sentc = require './lib/sentiment'

class exports.Server
	start: () ->
		console.log("loaded into coffeescript")
