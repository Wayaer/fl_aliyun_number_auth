import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';

/// 配置授权页Logo
class LogoUIModelForAndroid {
  /// 设置Logo是否隐藏。取值：
  /// true：表示隐藏。
  /// false：表示显示。
  final bool? logoHidden;

  /// 设置Logo图片路径。
  final String? logoImgPath;

  /// 设置Logo控件宽度（单位：px）。
  final int? logoWidth;

  /// 设置Logo控件高度（单位：px）。
  final int? logoHeight;

  /// 设置Logo控件相对导航栏顶部的位移（单位：px）。
  final int? logoOffsetY;

  /// 设置Logo控件相对底部的位移（单位：px）。
  final int? logoOffsetYB;

  /// 设置Logo图片缩放模式。模式类型：
  final ImageScaleType? logoScaleType;

  const LogoUIModelForAndroid({
    this.logoHidden,
    this.logoImgPath,
    this.logoWidth,
    this.logoHeight,
    this.logoOffsetY,
    this.logoOffsetYB,
    this.logoScaleType,
  });

  Map<String, dynamic> toMap() => {
        'logoHidden': logoHidden,
        'logoImgPath': logoImgPath,
        'logoWidth': logoWidth,
        'logoHeight': logoHeight,
        'logoOffsetY': logoOffsetY,
        'logoOffsetYB': logoOffsetYB,
        'logoScaleType': logoScaleType?.index,
      };
}

/// 配置授权页Logo
class LogoUIModelForIOS {
  /// logo图片设置
  final String? logoImage;

  /// logo是否隐藏，默认NO
  final bool? logoIsHidden;

  /// 构建logo的frame，view布局或布局发生变化时调用，不实现则按默认处理
  final ViewFrameBlockForIOS? logoFrameBlock;

  /// 通过[logoFrameBlock]构建frame
  /// 如果不传递则使用默认
  final Rect? logoFrame;
  /// 通过[logoFrameBlock]构建size
  /// [logoFrame] 优先 [logoSize]
  final Size? logoSize;
  /// 构造函数，提供默认值
  const LogoUIModelForIOS({
    this.logoImage,
    this.logoIsHidden,
    this.logoFrameBlock,
    this.logoFrame,
  });

  Map<String, dynamic> toMap() => {
        'logoImage': logoImage,
        'logoIsHidden': logoIsHidden,
        'logoFrameBlock': logoFrameBlock != null,
        'logoFrame': logoFrame?.toMap(),
      };
}
