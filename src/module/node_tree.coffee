# Created with Keyword Filter.
# User: YuanXiangDong
# Date: 12-9-1
# Time: 下午2:10
# 敏感词的节点树

#NodeArray = {}

class NodeTree
#  @NodeArray = {}


  @getInstance = () ->
    return new NodeTree()

  constructor:() ->
    this.NodeArray = {}
    this.is_end = false
    return

  setNode:(value,subNode)->
    this.NodeArray[value] = subNode
    return

  getNode:(value)->
    this.NodeArray[value]

  setEnd: (val)->
    this.is_end = val
    return

  isEnd: ()->
    return this.is_end

  getNodeArray:()->
    return this.NodeArray
module.exports = NodeTree

