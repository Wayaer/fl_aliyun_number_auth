import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';

/// 配置授权页号码栏
class NumberUIModelForAndroid {
  /// 设置手机号码字体颜色。
  final Color? numberColor;

  /// 设置手机号码字体大小（单位：px，字体大小不随系统变化）。
  final int? numberTextSize;

  /// 设置号码栏控件相对导航栏顶部的位移（单位：px）。
  final int? numFieldOffsetY;

  /// 设置号码栏控件相对底部的位移（单位：px）。
  final int? numFieldOffsetYB;

  /// 设置号码栏相对于默认位置的X 轴偏移量（单位：px）。
  final int? numberFieldOffsetX;

  /// 设置手机号掩码的布局对齐方式，支持以下三种对齐方式：
  /// [Gravity.start]、[Gravity.centerHorizontal]、[Gravity.end]
  final Gravity? numberLayoutGravity;

  /// 设置手机号码文本使用字体
  final Typeface? numberTypeface;

  /// 设置手机号码显示水平间距。
  final double? numberTextSpace;

  const NumberUIModelForAndroid({
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
        'numberColor': numberColor?.toHex(),
        'numberTextSize': numberTextSize,
        'numFieldOffsetY': numFieldOffsetY,
        'numFieldOffsetYB': numFieldOffsetYB,
        'numberFieldOffsetX': numberFieldOffsetX,
        'numberLayoutGravity': numberLayoutGravity?.index,
        'numberTypeface': numberTypeface?.index,
        'numberTextSpace': numberTextSpace,
      };
}

/// 配置授权页号码栏
class NumberUIModelForIOS {
  /// 设置掩码颜色
  final Color? numberColor;

  /// 设置掩码字体大小设置，<16则不生效
  final UIFont? numberFont;

  /// 构建号码的frame，view布局或布局发生变化时调用，只有x，y生效，不实现则按默认处理，设置不能超出父视图content view
  final ViewFrameBlockForIOS? numberFrameBlock;

  /// 通过[numberFrameBlock]构建frame
  /// 如果不传递则使用默认
  final Rect? numberFrame;
  /// 通过[numberFrameBlock]构建size
  /// [numberFrame] 优先 [numberSize]
  final Size? numberSize;

  const NumberUIModelForIOS({
    this.numberColor,
    this.numberFont,
    this.numberFrameBlock,
    this.numberFrame,
  });

  Map<String, dynamic> toMap() => {
        'numberColor': numberColor?.toHex(),
        'numberFont': numberFont?.toMap(),
        'numberFrameBlock': numberFrameBlock != null,
        'numberFrame': numberFrame?.toMap(),
      };
}
