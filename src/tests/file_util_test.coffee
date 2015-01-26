###
# test for file_util
###

## Module dependencies
should = require "should"
file_util = require "../utils/file_util"
fs = require 'fs'
crypto = require 'crypto'
debuglog = require("debug")("gama-www::test::file_util_test")

## Test cases
describe "test file_util", ->

  before () ->
    # before test happen

  describe "checksum", ->

    it "should generate correct sum", (done) ->

      sampleContent = "just some sample conent"
      pathToFile = "/tmp/#{Date.now()}"

      fs.writeFileSync pathToFile, sampleContent

      originSum = crypto.createHash('md5').update(sampleContent).digest('hex')

      file_util.checksum pathToFile, (err, sum)->
        console.log "[file_util_test] err:#{err}, sum:#{sum}"
        should.not.exist err
        sum.should.eql(originSum)
        done()


    it "should return error message when file not exist", (done) ->

      file_util.checksum "#{Date.now()}_not_even_exist_#{Date.now()}", (err, sum)->
        console.log "[file_util_test] err:#{err}, sum:#{sum}"
        should.exist err
        should.not.exist sum
        done()


    it "should return error message when path isn't a file", (done) ->

      file_util.checksum "/tmp", (err, sum)->
        console.log "[file_util_test] err:#{err}, sum:#{sum}"
        should.exist err
        should.not.exist sum
        done()

  describe "writeToTemp ", ->

    it "should work", (done)->
      content = "good-day"
      file_util.writeToTemp content, (err, pathToFile)->
        debuglog "[writeToTemp] pathToFile:#{pathToFile}"

        fs.readFileSync(pathToFile, {encoding:"utf8"}).should.eql(content)
        done()
        return





