#info = [][]
keyHash = {}
keyArray = []

arrayToHash = (ary) ->
  console.log "[information.arrayToHash] array length #{ary.length}"
  for data in ary
    dataBuf = new Buffer(data)
    keyHash[data] = data.length
#  console.dir keyHash
  keyHash = bySortedValue(keyHash)

bySortedValue = (keyHash) ->
  tempArray = []
  for key,value of keyHash
    tempArray.push [key,value]
  tempArray.sort( (a, b) ->
    return if a[1] < b[1] then 1 else if a[1] > b[1] then -1 else 0
  )
  keyHash = {}
  for val in tempArray
    keyHash[val[0]]=val[1]
  return keyHash

module.exports =
  initData : (defultData) ->
    console.log "[infomation.initData] start"
    arrayToHash(defultData)
    for key,value of keyHash
      keyArray.push key

  getKeyArray : () ->
    return keyArray

