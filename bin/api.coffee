'use strict'

express = require('express')
# routes = require('./routes')
http = require('http')
path = require('path')

app = express()
app.set('port', process.env.PORT || 3000)

app.get '/api/10152176102187555/mail/100003301174641/high', (req, res) ->
  res.send 'true'

app.get '/api/10152176102187555/mail/100003301174641/middle', (req, res) ->
  res.send 'true'

app.get '/api/10152176102187555/mail/100003301174641/low', (req, res) ->
  res.send 'true'

app.get '/api/10152176102187555/mail/100003301174641/zero', (req, res) ->
  res.send 'true'

app.get '/api/10152176102187555/mail/100003301174641/null', (req, res) ->
  res.send 'true'

http.createServer(app).listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))
