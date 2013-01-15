node-keywords-filter
====================

a string keywords filter module for nodejs


main class : keyword_filter.js


example:

keyword_filter = require '../keyword_filter'

keyArrays = [
          ' SM','violence','cruel']

testContents = “SM or violence or cruel is sensitive.”

befor = () ->
  #init Data
  keyword_filter.init(keyArrays)

test = () ->
  #keyword filter is TRUE or FALSE
  keyword_filter.isKeyword(testContents)

  #replace char
  #return replace after String
  keyword_filter.replaceKeyword(testContents,'x')

  #replace word
  #return replace after String
  keyword_filter.replaceStrKeyword(testContents,'sensitive')



