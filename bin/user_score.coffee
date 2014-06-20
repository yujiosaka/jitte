#!/usr/bin/env coffee
'use strict'

graph    = require 'fbgraph'
async    = require 'async'
config   = require 'ynconf'

mongo    = require 'mongo'


console.log 'Start.'
user = config.graph_api.user

for friend in user.friends
  friend.score = friend.average + Math.floor((Math.random() - 0.5) * 40)

user_score = new mongo.FriendScore user
user_score.save (err) ->
  if err
    console.log err
    process.exit 1
  console.log 'End.'
  process.exit 0