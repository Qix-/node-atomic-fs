fs = require 'fs'
path = require 'path'
should = require 'should'
atomicFs = require '../'

Error.stackTraceLimit = Infinity

filename = path.join __dirname, 'foo'

afterEach (done)-> fs.unlink filename, -> done()

it 'should be able to write before-hand', ->
  (->
    fs.writeFileSync filename, 'hello'
  ).should.not.throw()

it 'should lock the file', (done)->
  atomicFs filename
    , (cb)->
      (->
        fs.writeFileSync filename, 'hello'
      ).should.not.throw()

      atomicFs filename
        , (cb)->
          cb()
        , (err)->
          (should err).be.ok()
          (should err.code).equal 'EEXIST'
          cb()
    , (err)->
      return done err if err
      atomicFs filename
        , (cb)->
          cb()
        , (err)->
          (should err).not.be.ok()
          done()
