import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';

/// 配置切换控件方式
class SwitchUIModelForAndroid {
  /// 设置切换按钮点是否可见。
  final bool? switchAccHidden;

  /// 设置切换按钮文字内容。
  final String? switchAccText;

  /// 设置切换按钮文字颜色。
  final Color? switchAccTextColor;

  /// 设置切换按钮文字大小。
  final int? switchAccTextSize;

  /// 设置切换按钮相对导航栏顶部的位移（单位：px）。
  final int? switchOffsetY;

  /// 设置切换按钮相对底部的位移（单位：px）。
  final int? switchOffsetYB;

  /// 设置切换按钮文本使用字体。
  final Typeface? switchTypeface;

  const SwitchUIModelForAndroid({
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
        'switchAccTextColor': switchAccTextColor?.toMap(),
        'switchAccTextSize': switchAccTextSize,
        'switchOffsetY': switchOffsetY,
        'switchOffsetYB': switchOffsetYB,
        'switchTypeface': switchTypeface?.index,
      };
}

/// 配置切换控件方式
class SwitchUIModelForIOS {
  /// changeBtn标题，内容，大小，颜色
  final NSAttributedString? changeBtnTitle;

  /// changeBtn是否隐藏，默认NO
  final bool? changeBtnIsHidden;

  /// 构建changeBtn的frame，view布局或布局发生变化时调用，不实现则按默认处理
  final ViewFrameBlockForIOS? changeBtnFrameBlock;

  const SwitchUIModelForIOS({
    this.changeBtnTitle,
    this.changeBtnIsHidden,
    this.changeBtnFrameBlock,
  });

  Map<String, dynamic> toMap() => {
        'changeBtnTitle': changeBtnTitle?.toMap(),
        'changeBtnIsHidden': changeBtnIsHidden,
        'changeBtnFrameBlock': changeBtnFrameBlock?.toMap(),
      };
}
