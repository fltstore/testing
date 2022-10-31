import 'package:flutter/material.dart';

/// 检测状态
enum SamplingStatus {
  /// 已采样(最近几个小时以内)
  last,

  /// 24小时内
  l24,

  /// 48小时内
  l48,

  /// 72小时内
  l72,

  /// 7天内
  lD7,
}

extension SamplingStatusExt on SamplingStatus {
  String get payloadText {
    switch (this) {
      case SamplingStatus.last:
        return '已采样';
      case SamplingStatus.l24:
        return '24';
      case SamplingStatus.l48:
        return '48';
      case SamplingStatus.l72:
        return '72';
      case SamplingStatus.lD7:
        return '7';
    }
  }

  String get payloadHumanText {
    if (payloadText != '7' && payloadText != '已采样') {
      return '$payloadText小时';
    }
    if (payloadText == '7') {
      return '7天';
    }
    return '已采样';
  }

  Color get transColor {
    if (this == SamplingStatus.last) {
      return const Color.fromRGBO(94, 167, 248, 1);
    }
    return const Color.fromRGBO(67, 151, 78, 1);
  }
}

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
      return const Color.fromRGBO(57, 105, 31, 1);
    } else if (this == CodeType.red) {
      return const Color.fromRGBO(223, 61, 35, 1);
    }
    return const Color.fromRGBO(240, 147, 54, 1);
  }
}
