import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

/// 配置授权页号码栏
class NumberUiModel {
  /// 设置手机号码字体颜色。
  final Color? numberColor;

  /// 设置手机号码字体大小（单位：dp，字体大小不随系统变化）。
  final int? numberTextSize;

  /// 设置号码栏控件相对导航栏顶部的位移（单位：dp）。
  final int? numFieldOffsetY;

  /// 设置号码栏控件相对底部的位移（单位：dp）。
  final int? numFieldOffsetYB;

  /// 设置号码栏相对于默认位置的X 轴偏移量（单位：dp）。
  final int? numberFieldOffsetX;

  /// 设置手机号掩码的布局对齐方式，支持以下三种对齐方式：
  /// [Gravity.start]、[Gravity.centerHorizontal]、[Gravity.end]
  final Gravity? numberLayoutGravity;

  /// 设置手机号码文本使用字体
  final Typeface? numberTypeface;

  /// 设置手机号码显示水平间距。
  final double? numberTextSpace;

  NumberUiModel({
    this.numberColor,
    this.numberTextSize,
    this.numFieldOffsetY,
    this.numFieldOffsetYB,
    this.numberFieldOffsetX,
    this.numberLayoutGravity,
    this.numberTypeface,
    this.numberTextSpace,
  });

  Map<String, dynamic> toMap() => {
        'numberColor': numberColor?.value,
        'numberTextSize': numberTextSize,
        'numFieldOffsetY': numFieldOffsetY,
        'numFieldOffsetYB': numFieldOffsetYB,
        'numberFieldOffsetX': numberFieldOffsetX,
        'numberLayoutGravity': numberLayoutGravity?.index,
        'numberTypeface': numberTypeface?.index,
        'numberTextSpace': numberTextSpace,
      };
}
