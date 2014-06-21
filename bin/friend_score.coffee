#!/usr/bin/env coffee
'use strict'

config   = require 'ynconf'
mongo    = require 'mongo'


console.log 'Start.'
user = config.graph_api.user

for friend in user.friends
  friend.score = friend.average + Math.floor((Math.random() - 0.5) * 40)

mongo.FriendScore.update
  id: user.id
,
  name: user.name
  friends: user.friends
,
  upsert: true
, (err) ->
  if err
    console.log err
    process.exit 1
  console.log 'End.'
  process.exit 0
