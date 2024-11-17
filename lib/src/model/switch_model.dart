import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

/// 配置切换控件方式
class SwitchUiModelForAndroid {
  /// 设置切换按钮点是否可见。
  final bool? switchAccHidden;

  /// 设置切换按钮文字内容。
  final String? switchAccText;

  /// 设置切换按钮文字颜色。
  final Color? switchAccTextColor;

  /// 设置切换按钮文字大小。
  final int? switchAccTextSize;

  /// 设置切换按钮相对导航栏顶部的位移（单位：dp）。
  final int? switchOffsetY;

  /// 设置切换按钮相对底部的位移（单位：dp）。
  final int? switchOffsetYB;

  /// 设置切换按钮文本使用字体。
  final Typeface? switchTypeface;

  const SwitchUiModelForAndroid({
    this.switchAccHidden,
    this.switchAccText,
    this.switchAccTextColor,
    this.switchAccTextSize,
    this.switchOffsetY,
    this.switchOffsetYB,
    this.switchTypeface,
  });

  Map<String, dynamic> toMap() => {
        'switchAccHidden': switchAccHidden,
        'switchAccText': switchAccText,
        'switchAccTextColor': switchAccTextColor?.value,
        'switchAccTextSize': switchAccTextSize,
        'switchOffsetY': switchOffsetY,
        'switchOffsetYB': switchOffsetYB,
        'switchTypeface': switchTypeface?.index,
      };
}

/// 配置切换控件方式
class SwitchUiModelForIOS {
  const SwitchUiModelForIOS();

  Map<String, dynamic> toMap() => {};
}
