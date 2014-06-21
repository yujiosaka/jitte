'use strict'

config   = require 'ynconf'
mongoose = require 'mongoose'

uri = "mongodb://#{config.mongo.host}:#{config.mongo.port}/#{config.mongo.database}"
db = mongoose.createConnection uri

friend_score = new mongoose.Schema
  id             : { type: String, required: true, index: true }
  name           : { type: String, required: true }
  friends        : [
    id             : { type: String, required: true }
    name           : { type: String, required: true }
    score          : { type: Number, required: true }
    mutual_friends : [
      id             : { type: String, required: true }
      name           : { type: String, required: true }
    ]
  ]

exports.FriendScore = db.model "friend_score", friend_score
