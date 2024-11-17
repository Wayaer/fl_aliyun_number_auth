import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

/// 配置授权页Slogan
class SloganUiModelForAndroid {
  /// 设置Slogan文字内容。
  final String? sloganText;

  /// 设置Slogan文字颜色。
  final Color? sloganTextColor;

  /// 设置Slogan文字大小。
  final int? sloganTextSize;

  /// 设置Slogan相对导航栏顶部的位移（单位：dp）。
  final int? sloganOffsetY;

  /// 设置Slogan相对底部的位移（单位：dp）。
  final int? sloganOffsetYB;

  /// 设置slogan文本使用字体。
  final Typeface? sloganTypeface;

  const SloganUiModelForAndroid({
    this.sloganText,
    this.sloganTextColor,
    this.sloganTextSize,
    this.sloganOffsetY,
    this.sloganOffsetYB,
    this.sloganTypeface,
  });

  Map<String, dynamic> toMap() => {
        'sloganText': sloganText,
        'sloganTextColor': sloganTextColor?.value,
        'sloganTextSize': sloganTextSize,
        'sloganOffsetY': sloganOffsetY,
        'sloganOffsetYB': sloganOffsetYB,
        'sloganTypeface': sloganTypeface?.index,
      };
}

/// 配置授权页Slogan
class SloganUiModelForIOS {
  const SloganUiModelForIOS();

  Map<String, dynamic> toMap() => {};
}