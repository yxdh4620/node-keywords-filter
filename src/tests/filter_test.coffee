###
# test for filter
###

## Module dependencies
should = require "should"
keyword_filter = require "../keyword_filter"
fs = require "fs"

array = ['sM', '大小', '枪支', '枪', 'a', '枪支弹药', '大人']
keyword_filter.init array
str1 = 'afadfaSmsmsM, dadfafd大小大人大的强制枪支枪支弹药手枪'
str2 = '枪支枪支弹药枪afbadakfja8sm阿达撒开了房哈覅大小人'
str3 = 'asfdja adfja;skf dsafowre较大；烧开后覅回复哈的骄傲饭卡地方发大水发回复哈佛'
str4 = 'dsgfsdtresfdrnemr较大；烧开后覅回复哈的骄傲饭卡地方发大水发回复哈佛'
strs = ['枪', str1, str2, str3, str4]
## Test cases
describe "test keyword_filter", ->

  before () ->
    # before test happen

  describe "checksum", ->

    it "keyword_filter isContainKeyword", (done) ->
      strs.map (str) ->
        console.log keyword_filter.isContainKeyword str
      done()

    it "keyword_filter replaceKeyword", (done) ->
      strs.map (str) ->
        console.log str
        console.log keyword_filter.replaceKeyword str, false
      done()

    it "keyword_filter replaceStrKeyword", (done) ->
      strs.map (str) ->
        console.log str
        console.log keyword_filter.replaceStrKeyword str, false
      done()

    it "keyword_filter calcCount", (done) ->
      strs.map (str) ->
        console.log str
        console.log keyword_filter.calcCount str, false
      done()

  #效率测试
  describe "effciency test", ->
    it "keyword_filter isContainKeyword", (done) ->
      data = fs.readFileSync '../../files/test1.txt',"utf8"
      console.log data.length
      start = Date.now()
      console.log keyword_filter.isContainKeyword data
      console.log " times: #{Date.now()-start}"
      done()

    it "keyword_filter replaceKeyword", (done) ->
      data = fs.readFileSync '../../files/test1.txt',"utf8"
      console.log data.length
      start = Date.now()
      str = keyword_filter.replaceKeyword data
      console.log str
      console.log " times: #{Date.now()-start}"
      done()

    it "keyword_filter replaceStrKeyword", (done) ->
      data = fs.readFileSync '../../files/test1.txt',"utf8"
      console.log data.length
      start = Date.now()
      str = keyword_filter.replaceStrKeyword data
      #console.log str
      console.log " times: #{Date.now()-start}"
      done()

    it "keyword_filter calcCount", (done) ->
      data = fs.readFileSync '../../files/test1.txt',"utf8"
      console.log data.length
      start = Date.now()
      count = keyword_filter.calcCount data
      console.log count
      console.log " times: #{Date.now()-start}"
      done()


