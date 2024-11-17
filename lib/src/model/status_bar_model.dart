import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/services.dart';

/// 配置授权页状态栏
class StatusBarUiModelForAndroid {
  /// 设置状态栏颜色（系统版本5.0以上可设置）。
  final Color? statusBarColor;

  /// 设置状态栏字体颜色（系统版本6.0以上可设置黑色、白色，默认为黑色）。取值：
  /// true：表示字体颜色为黑色。
  /// false：表示字体颜色为白色。
  final bool? lightColor;

  /// 设置状态栏是否隐藏。取值：
  /// true：表示隐藏。
  /// false：表示显示。
  final bool? statusBarHidden;

  /// 设置状态栏UI属性，属性类型：
  final SystemUiFlag? statusBarUIFlag;

  /// 设置协议页状态栏颜色（系统版本5.0以上可设置），不设置则与授权页设置一致。
  final Color? webViewStatusBarColor;

  const StatusBarUiModelForAndroid({
    this.statusBarColor,
    this.lightColor,
    this.statusBarHidden,
    this.statusBarUIFlag,
    this.webViewStatusBarColor,
  });

  Map<String, dynamic> toMap() => {
        'statusBarColor': statusBarColor?.value,
        'lightColor': lightColor,
        'statusBarHidden': statusBarHidden,
        'statusBarUIFlag': statusBarUIFlag?.index,
        'webViewStatusBarColor': webViewStatusBarColor?.value,
      };
}

/// 配置授权页状态栏
class StatusBarUiModelForIOS {
  /// 状态栏是否隐藏，默认为NO
  final bool? prefersStatusBarHidden;

  /// 状态栏主题风格，默认UIStatusBarStyleDefault
  final UIStatusBarStyle? preferredStatusBarStyle;

  const StatusBarUiModelForIOS(
      {this.prefersStatusBarHidden, this.preferredStatusBarStyle});

  Map<String, dynamic> toMap() => {
        'prefersStatusBarHidden': prefersStatusBarHidden,
        'preferredStatusBarStyle': preferredStatusBarStyle?.value
      };
}
