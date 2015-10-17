chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'kerbal-stuff', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/kerbal-stuff')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/ks find(?:\s+(.*))?$/i)
  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/ks top/i)
  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/ks new/i)
  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/ks featured/i)
