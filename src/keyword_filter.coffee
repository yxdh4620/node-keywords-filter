# Created in project Keyword Filter.
# User: acer
# Date: 12-9-1
# Time: 下午8:50
# keyword Filter 的主文件

NodeTree = require "./module/node_tree"
infor = require "./data/information"
change_case = require "./util/change_case"

rootNode = NodeTree.getInstance()
#可复用变量
tempNode = null
subNode = null
rollback = 0
position = 0

replaceIndexChar = (str,index,char) ->
  return str if index<0 or index+1>=str.length
#  console.log "[keyword_filter.replaceIndexChar] str :#{str}  index:#{index}  char:#{char}"
  return str.substring(0,index)+char+str.substring(index+1,str.length)

module.exports =
  init: (keyArray) ->
    infor.initData(keyArray)
    this.createNodeTree()

  createNodeTree: () ->
    console.log "[createNodeTree start]"
    keyArray = infor.getKeyArray()
    for key,i in keyArray
      key = change_case.change key
      tempNode = rootNode
      for char,j in key
        subNode = tempNode.getNode(change_case.toCBDChange(char))
        if subNode == undefined
          subNode = NodeTree.getInstance()
          tempNode.setNode(char,subNode)
        tempNode = subNode
        if j  == key.length - 1
          subNode.setEnd(true)



  isContainKeyword : (str) ->
    tempNode = rootNode
    rollback = 0
    position = 0
    str = change_case.change(str)
    while position<str.length
      char = str.charAt(position)
      tempNode = tempNode.getNode(char)
      if tempNode==undefined
        position = position - rollback
        rollback = 0
        tempNode = rootNode
      else if tempNode.isEnd()
        return true
      else
        rollback++
      position++
    return false

  replaceKeyword : (str,reChar='*') ->
    tempNode = rootNode
    rollback = 0
    position = 0
    str = change_case.change(str)
    while position<str.length
      tempNode = tempNode.getNode(str.charAt(position))
      if tempNode==undefined
        position = position - rollback
        rollback = 0
        tempNode = rootNode
      else if tempNode.isEnd()
        for i in[(position-rollback)...position+1]
          str = replaceIndexChar(str,i,reChar)
        rollback = 1
      else
        rollback++
      position++
    return str

  replaceStrKeyword : (str,reStr='敏感词') ->
    tempNode = rootNode
    rollback = 0
    position = 0
    str = change_case.change(str)
    while position<str.length
      tempNode = tempNode.getNode(str.charAt(position))
      if tempNode==undefined
        position = position - rollback
        rollback = 0
        tempNode = rootNode
      else if tempNode.isEnd()
        str = str.replace(str.substring((position-rollback), position+1), reStr)
        rollback = 1
      else
        rollback++
      position++
    return str

#module.exports.createNodeTree()
