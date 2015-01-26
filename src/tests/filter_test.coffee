###
# test for filter
###

## Module dependencies
should = require "should"
keyword_filter = require "../keyword_filter"


array = ['sM', '大小', '枪支', '枪', 'a', '枪支弹药', '大人']
keyword_filter.init array
str1 = 'afadfaSmsmsM, dadfafd大小大人大的强制枪支枪支弹药手枪'
str2 = '枪支枪支弹药枪afbadakfja8sm阿达撒开了房哈覅大小人'
strs = ['枪', str1, str2]
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
        console.log keyword_filter.replaceKeyword str
      done()

    it "keyword_filter replaceIndexChar", (done) ->
      strs.map (str) ->
        console.log str
        console.log keyword_filter.replaceStrKeyword str
      done()


