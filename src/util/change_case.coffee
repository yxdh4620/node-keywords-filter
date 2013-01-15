###
  # 英文字符的大小写转换工具
###

# Created with Project node-keyword-filter0.2.0
# User  YuanXiangDong
# Date  13-1-4
# To change this template use File | Settings | File Templates.

#大写转换
upper = (str) ->
  console.log '[ChangeCase::upper] start'
  return str.toUpperCase()

#小写转换
lower = (str) ->
  return str.toLowerCase()


ChangeCase =

  #字符转换
  change :(str) ->
    return this.toCBDString(lower(str))

  toCBDChange : (char) ->
    if(char==12288)
      char = 32
    if(char > 65248 && char < 65375)
      char = char-65248
    return char

  toCBDString:(str) ->
    tmp = ''
    for i in[0...str.length]
      tmp   +=   String.fromCharCode(this.toCBDChange(str.charCodeAt(i)))
    return tmp

module.exports = ChangeCase

#do ->
#  console.log ChangeCase.upper('aaaabbb')
