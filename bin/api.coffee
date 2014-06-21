'use strict'

express = require('express')
# routes = require('./routes')
http = require('http')
path = require('path')

app = express()
app.set('port', process.env.PORT || 3000)

app.get '/api/10152176102187555/mail/100003301174641/high', (req, res) ->
  console.log 'high'
  res.send 'true'

app.get '/api/10152176102187555/mail/100003301174641/middle', (req, res) ->
  console.log 'middle'
  res.send 'true'

app.get '/api/10152176102187555/mail/100003301174641/low', (req, res) ->
  console.log 'low'
  res.send 'true'

app.get '/api/10152176102187555/mail/100003301174641/zero', (req, res) ->
  console.log 'zero'
  res.send 'true'

app.get '/api/10152176102187555/mail/100003301174641/null', (req, res) ->
  console.log 'null'
  res.send 'true'

http.createServer(app).listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))
