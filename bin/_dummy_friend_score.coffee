'use strict'

graph    = require 'fbgraph'
async    = require 'async'
moment   = require 'moment'

config   = require 'ynconf'
mongo    = require 'mongo'

start_at = moment().subtract('hours', 1).startOf('hour').toDate()
end_at   = moment().subtract('hours', 1).endOf('hour').toDate()

console.log 'Start.'

user =
  id   : '10152176102187555'
  name : 'Yuji Isobe'

graph.setAccessToken config.graph_api.access_token
graph.get "#{user.id}/friends", (err, res) ->
  if err
    console.log err
    process.exit 1
  async.map res.data, (friend, done) ->
    graph.get "#{user.id}/mutualfriends/#{friend.id}", (err, res) ->
      if err
        console.log err
        return done err
      done null,
        id             : friend.id
        name           : friend.name
        mutual_friends : res.data
        score          : Math.floor(Math.random() * 100)
  , (err, friends) ->
    user_score = new mongo.FriendScore
      id       : user.id
      name     : user.name
      friends  : friends
      start_at : start_at
      end_at   : end_at
    user_score.save (err) ->
      if err
        console.log err
        process.exit 1
      console.log 'End.'
      process.exit 0
