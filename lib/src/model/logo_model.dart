import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

/// 配置授权页Logo
class LogoUiModelForAndroid {
  /// 设置Logo是否隐藏。取值：
  /// true：表示隐藏。
  /// false：表示显示。
  final bool? logoHidden;

  /// 设置Logo图片路径（即drawable下文件名称，但无需带文件格式）。
  final String? logoImgPath;

  /// 设置Logo控件宽度（单位：dp）。
  final int? logoWidth;

  /// 设置Logo控件高度（单位：dp）。
  final int? logoHeight;

  /// 设置Logo控件相对导航栏顶部的位移（单位：dp）。
  final int? logoOffsetY;

  /// 设置Logo控件相对底部的位移（单位：dp）。
  final int? logoOffsetYB;

  /// 设置Logo图片缩放模式。模式类型：
  final ImageScaleType? logoScaleType;

  const LogoUiModelForAndroid({
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
class LogoUiModelForIOS {
  const LogoUiModelForIOS();

  Map<String, dynamic> toMap() => {};
}
