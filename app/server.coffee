app = require('express')()
http = require('http').Server app
io = require('socket.io') http

options = 
  root: "#{__dirname}/../public/",
  dotfiles: 'deny'
  headers:
    'x-timestamp': Date.now()
    'x-sent': true

quips = ['Hasta la vista, baby', 'Bond, James Bond', 'You talkin to me', 'Say hello to my little friend', 'Are you not entertained'];

app.get '/', (req, res) ->
  res.sendFile 'index.html', options

app.get '/css/styles.css', (req, res) ->
  res.sendFile 'styles.css', options

io.on 'connection', (socket) ->
  console.log '\n\nconnected!\n\n'


  socket.on 'quip-request', ->
    quip = quips[Math.floor(Math.random() * quips.length)].toUpperCase()
    socket.emit 'quip-response', quip

  socket.on 'quip-response', (msg) ->
    console.log '\n\n'
    console.log msg
    console.log '\n\n'

    quip = quips[Math.floor(Math.random() * quips.length)].toUpperCase()
    socket.emit 'quip-response', quip

  socket.on 'disconnect', ->
    console.log '\n\noh noes\n\n'

http.listen 3000, ->
  console.log '\n\nlistening on *:3000'
