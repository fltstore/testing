import 'package:flutter/material.dart';

enum CodeType {
  /// 绿码
  green,

  /// 黄码
  yellow,

  /// 红码
  red,
}

extension CodeTypeWithExtension on CodeType {
  String get humanString {
    if (this == CodeType.green) {
      return '绿码';
    } else if (this == CodeType.red) {
      return '红码';
    }
    return '黄码';
  }
  Color get transColor {
    if (this == CodeType.green) {
      return Colors.green;
    } else if (this == CodeType.red) {
      return Colors.red;
    }
    return Colors.yellow;
  }
}
