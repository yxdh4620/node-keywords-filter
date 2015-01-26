# Created in project Keyword Filter.
# User: acer
# Date: 12-9-1
# Time: 下午8:50
# keyword Filter 的主文件

_ = require "underscore"
NodeTree = require "./module/node_tree"
infor = require "./data/information"
change_case = require "./util/change_case"

rootNode = NodeTree.getInstance()
IS_CHANGE = true

#可复用变量
tempNode = null
subNode = null
rollback = 0
position = 0

replaceIndexChar = (str,index,char) ->
  #console.log "[keyword_filter.replaceIndexChar] str :#{str}  index:#{index}  char:#{char}"
  return str if index<0 or index+1>str.length
  return str.substring(0,index)+char+str.substring(index+1,str.length)

replaceIndexStr = (str, start, end, scdStr) ->
  firstStr = str.substring 0, start
  endStr = str.substring end, str.length
  return "#{firstStr}#{scdStr}#{endStr}"

module.exports =

  # 初始化屏蔽词
  # param keyArray: Array 屏蔽词数组
  # param isChange: Boolean 是否对敏感词做小写转换, 默认为true
  # return undefined
  init: (keyArray,isChange=true) ->
    infor.initData(keyArray)
    this.createNodeTree(isChange)
    return

  # 创建敏感词节点树, (一般由init内部调用， 公开出来是防止有手动刷新节点树的情况出现)
  # param isChange: Boolean 是否对敏感词做小写转换, 默认为true
  # return undefined
  createNodeTree: (isChange=true) ->
    console.log "[createNodeTree start]"
    IS_CHANGE = isChange
    keyArray = infor.getKeyArray()
    for key,i in keyArray
      if isChange
        key = change_case.change key
      tempNode = rootNode
      for char,j in key
        subNode = tempNode.getNode(char)
        if subNode == undefined
          subNode = NodeTree.getInstance()
          tempNode.setNode(char,subNode)
        tempNode = subNode
        if j  == key.length - 1
          subNode.setEnd(true)
    return

  # 判断所给的文字中是否包含敏感词
  # param str: String 需要过滤的文字
  # param isChange: Boolean 是否对需要过滤的文字做小写转换, 默认为true
  isContainKeyword : (str, isChange) ->
    tempNode = rootNode
    rollback = 0
    position = 0
    isChange = IS_CHANGE unless isChange?
    if isChange
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

  # 按照字符替换敏感词
  # param str: String 需要过滤的文字
  # param isChange: Boolean 是否对需要过滤的文字做大写转换, 默认为true
  # param reChar: 替换的字符， 默认'*'
  # return 返回替换后的文字
  replaceKeyword : (str, isChange=true, reChar='*') ->
    tempNode = rootNode
    rollback = 0
    position = 0
    if _.isString(isChange)
      reChar = isChange
      isChange = IS_CHANGE
    if isChange
      str = change_case.change(str)
    #console.dir tempNode
    while position < str.length
      tempNode = tempNode.getNode(str.charAt(position))
      #console.log "charAt:#{str.charAt(position)} position:#{position} rollback:#{rollback}"
      #console.dir tempNode
      if tempNode==undefined
        position = position - rollback
        rollback = 0
        tempNode = rootNode
      else if tempNode.isEnd()
        #console.log "start:#{position-rollback} end: #{position+1}"
        for i in[(position-rollback)...position+1]
          str = replaceIndexChar(str, i, reChar)
        rollback = 1
      else
        rollback++
      position++
    return str

  # 替换整个敏感词字符串
  # param str: String 需要过滤的文字
  # param isChange: Boolean 是否对需要过滤的文字做大写转换, 默认为true
  # param reStr: 替换的字符串， 默认'敏感词'
  # return 返回替换后的文字
  replaceStrKeyword : (str, isChange=true, reStr='敏感词') ->
    tempNode = rootNode
    start = 0
    end = 0
    len = 0
    isEnd = false
    if _.isString(isChange)
      reStr= isChange
      isChange = IS_CHANGE
    if isChange
      str = change_case.change(str)
    filters = []
    while start+len<str.length
      tempNode = tempNode.getNode(str.charAt(start+len))
      if tempNode==undefined
        if isEnd
          #console.log "start:#{start} end:#{start+len} isEnd:#{isEnd}"
          filters.push [start, start+len]
          start = start+len
        else
          start++
        isEnd = false
        len = 0
        tempNode = rootNode
        #console.log "2start:#{start} end:#{start+len} isEnd:#{isEnd}"
      else if tempNode.isEnd()
        isEnd = true
        len++
      else
        len++
    if isEnd
      filters.push [start, start+len]
    #console.dir filters
    filter = null
    while filters.length>0
      work = filters.pop()
      #console.log "start:#{work[0]} end:#{work[1]} sub:#{str.substring(work[0], work[1])}"
      str = replaceIndexStr str, work[0], work[1], reStr
    return str

  # 计算字符串所含敏感词数量
  #
  calcCount: (str, isChange) ->
    tempNode = rootNode
    start = 0
    end = 0
    len = 0
    isEnd = false
    unless isChange?
      isChange = IS_CHANGE
    if isChange
      str = change_case.change(str)
    i = 0
    while start+len<str.length
      tempNode = tempNode.getNode(str.charAt(start+len))
      if tempNode==undefined
        if isEnd
          #console.log "start:#{start} end:#{start+len} isEnd:#{isEnd}"
          start = start+len
          i++
        else
          start++
        isEnd = false
        len = 0
        tempNode = rootNode
        #console.log "2start:#{start} end:#{start+len} isEnd:#{isEnd}"
      else if tempNode.isEnd()
        isEnd = true
        len++
      else
        len++
    i++ if isEnd
    return i

#module.exports.createNodeTree()
