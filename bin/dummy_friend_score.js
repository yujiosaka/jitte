'use strict';
var async, config, end_at, graph, moment, mongo, start_at, user;

graph = require('fbgraph');

async = require('async');

moment = require('moment');

config = require('ynconf');

mongo = require('mongo');

start_at = moment().subtract('hours', 1).startOf('hour').toDate();

end_at = moment().subtract('hours', 1).endOf('hour').toDate();

console.log('Start.');

user = {
  id: '10152176102187555',
  name: 'Yuji Isobe'
};

graph.setAccessToken(config.graph_api.access_token);

graph.get("" + user.id + "/friends", function(err, res) {
  if (err) {
    console.log(err);
    process.exit(1);
  }
  return async.map(res.data, function(friend, done) {
    return graph.get("" + user.id + "/mutualfriends/" + friend.id, function(err, res) {
      if (err) {
        console.log(err);
        return done(err);
      }
      return done(null, {
        id: friend.id,
        name: friend.name,
        mutual_friends: res.data,
        score: Math.floor(Math.random() * 100)
      });
    });
  }, function(err, friends) {
    var user_score;
    user_score = new mongo.FriendScore({
      id: user.id,
      name: user.name,
      friends: friends,
      start_at: start_at,
      end_at: end_at
    });
    return user_score.save(function(err) {
      if (err) {
        console.log(err);
        process.exit(1);
      }
      console.log('End.');
      return process.exit(0);
    });
  });
});