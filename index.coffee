async = require 'async'

module.exports = (Impromptu, register, self) ->
  register 'info',
    update: (done) ->
      Impromptu.exec 'svn info', (err, result) ->
        done null, result

  register 'url',
    update: (done) ->
      self.info (err, info) ->
        return done err, false if err

        url = info?.match(/URL: (.+)/)?.pop?()
        done err, url

  register 'isRepo',
    update: (done) ->
      self.info (err, result) ->
        done err, !!result

  register 'trunk',
    update: (done) ->
      self.url (err, url) ->
        trunk = !! url?.match?(/\/trunk(\/|$)/)
        done err, trunk

  register 'tag',
    update: (done) ->
      self.url (err, url) ->
        return done err, false if err

        tag = url?.match(/tags\/([^\/]+)/)?.pop?()
        done err, tag

  register 'branch',
    update: (done) ->
      self.url (err, url) ->
        return done err, false if err

        branch = url?.match(/branches\/([^\/]+)/)?.pop?()
        done err, branch

  register 'revision',
    update: (done) ->
      self.info (err, info) ->
        return done err, false unless info

        rev = info.match(/Revision: ([0-9]+)/).pop?()
        return done err, false unless rev

        done err, parseInt(rev, 10)
