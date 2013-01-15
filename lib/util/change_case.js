// Generated by CoffeeScript 1.3.3

/*
  # 英文字符的大小写转换工具
*/


(function() {
  var ChangeCase, lower, upper;

  upper = function(str) {
    console.log('[ChangeCase::upper] start');
    return str.toUpperCase();
  };

  lower = function(str) {
    return str.toLowerCase();
  };

  ChangeCase = {
    change: function(str) {
      return this.toCBDString(lower(str));
    },
    toCBDChange: function(char) {
      if (char === 12288) {
        char = 32;
      }
      if (char > 65248 && char < 65375) {
        char = char - 65248;
      }
      return char;
    },
    toCBDString: function(str) {
      var i, tmp, _i, _ref;
      tmp = '';
      for (i = _i = 0, _ref = str.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        tmp += String.fromCharCode(this.toCBDChange(str.charCodeAt(i)));
      }
      return tmp;
    }
  };

  module.exports = ChangeCase;

}).call(this);