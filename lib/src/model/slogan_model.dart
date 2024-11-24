import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';

/// 配置授权页Slogan
class SloganUIModelForAndroid {
  /// 设置Slogan文字内容。
  final String? sloganText;

  /// 设置Slogan文字颜色。
  final Color? sloganTextColor;

  /// 设置Slogan文字大小。
  final int? sloganTextSize;

  /// 设置Slogan相对导航栏顶部的位移（单位：px）。
  final int? sloganOffsetY;

  /// 设置Slogan相对底部的位移（单位：px）。
  final int? sloganOffsetYB;

  /// 设置slogan文本使用字体。
  final Typeface? sloganTypeface;

  const SloganUIModelForAndroid({
    this.sloganText,
    this.sloganTextColor,
    this.sloganTextSize,
    this.sloganOffsetY,
    this.sloganOffsetYB,
    this.sloganTypeface,
  });

  Map<String, dynamic> toMap() => {
        'sloganText': sloganText,
        'sloganTextColor': sloganTextColor?.toHex(),
        'sloganTextSize': sloganTextSize,
        'sloganOffsetY': sloganOffsetY,
        'sloganOffsetYB': sloganOffsetYB,
        'sloganTypeface': sloganTypeface?.index,
      };
}

/// 配置授权页Slogan
class SloganUIModelForIOS {
  /// 设置slogan文案，内容、大小、颜色
  final NSAttributedString? sloganText;

  /// 设置slogan是否隐藏、默认不隐藏
  final bool? sloganIsHidden;

  /// 构建slogan的frame，view布局或者布局发生变化时调用，不实现则按默认处理
  final ViewFrameBlockForIOS? sloganFrameBlock;

  /// 通过[sloganFrameBlock]构建frame
  /// 如果不传递则使用默认
  final Rect? sloganFrame;

  SloganUIModelForIOS({
    this.sloganText,
    this.sloganIsHidden,
    this.sloganFrameBlock,
    this.sloganFrame,
  });

  Map<String, dynamic> toMap() => {
        'sloganText': sloganText?.toMap(),
        'sloganIsHidden': sloganIsHidden,
        'sloganFrameBlock': sloganFrameBlock != null,
        'sloganFrame': sloganFrame?.toMap(),
      };
}
