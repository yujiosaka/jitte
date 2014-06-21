'use strict';
var config, friend, mongo, user, _i, _len, _ref;

config = require('ynconf');

mongo = require('mongo');

console.log('Start.');

user = config.graph_api.user;

_ref = user.friends;
for (_i = 0, _len = _ref.length; _i < _len; _i++) {
  friend = _ref[_i];
  friend.score = friend.average + Math.floor((Math.random() - 0.5) * 40);
}

mongo.FriendScore.update({
  id: user.id
}, {
  name: user.name,
  friends: user.friends
}, {
  upsert: true
}, function(err) {
  if (err) {
    console.log(err);
    process.exit(1);
  }
  console.log('End.');
  return process.exit(0);
});