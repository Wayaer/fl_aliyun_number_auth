import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

/// 配置授权页导航栏
class NavUiModel {
  /// 设置状态栏颜色（系统版本5.0以上可设置）。
  final Color? statusBarColor;

  /// 设置状态栏字体颜色（系统版本6.0以上可设置黑色、白色，默认为黑色）。取值：
  /// true：表示字体颜色为黑色。
  /// false：表示字体颜色为白色。
  final bool? lightColor;

  /// 设置导航栏颜色。
  final Color? navColor;

  /// 设置导航栏标题文字。
  final String? navText;

  /// 设置导航栏标题文字颜色。
  final Color? navTextColor;

  /// 设置导航栏标题文字大小。
  final int? navTextSize;

  /// 设置导航栏文本使用字体。
  /// 参数包含：Typeface.sansSerif、Typeface.serif、Typeface.monospace。
  final Typeface? navTypeface;

  /// 设置导航栏返回键图片路径（即drawable下文件名称，但无需带文件格式）。
  final String? navReturnImgPath;

  /// 设置导航栏返回按钮隐藏。取值：
  /// true：表示隐藏。
  /// false：表示显示。
  final bool? navReturnHidden;

  /// 设置默认导航栏是否隐藏。取值：
  /// true：表示隐藏。
  /// false：表示显示。
  final bool? navHidden;

  /// 设置状态栏是否隐藏。取值：
  /// true：表示隐藏。
  /// false：表示显示。
  final bool? statusBarHidden;

  /// 设置状态栏UI属性，属性类型：
  final SystemUiFlag? statusBarUIFlag;

  /// 设置协议页状态栏颜色（系统版本5.0以上可设置），不设置则与授权页设置一致。
  final Color? webViewStatusBarColor;

  /// 设置协议页顶部导航栏背景色，不设置则与授权页设置一致。
  final Color? webNavColor;

  /// 设置协议页顶部导航栏标题颜色，不设置则与授权页设置一致。
  final Color? webNavTextColor;

  /// 设置协议页顶部导航栏文字大小，不设置则与授权页设置一致。
  final int? webNavTextSize;

  /// 设置协议页导航栏返回按钮图片路径，不设置则与授权页设置一致。
  final String? webNavReturnImgPath;

  /// 设置底部虚拟按键背景色（系统版本5.0以上可设置）。
  final Color? bottomNavColor;

  /// Drawable
  final String? navReturnImgDrawable;

  NavUiModel({
    this.statusBarColor,
    this.lightColor,
    this.navColor,
    this.navText,
    this.navTextColor,
    this.navTextSize,
    this.navTypeface,
    this.navReturnImgPath,
    this.navReturnHidden,
    this.navHidden,
    this.statusBarHidden,
    this.statusBarUIFlag,
    this.webViewStatusBarColor,
    this.webNavColor,
    this.webNavTextColor,
    this.webNavTextSize,
    this.webNavReturnImgPath,
    this.bottomNavColor,
    this.navReturnImgDrawable,
  });

  Map<String, dynamic> toMap() => {
        'statusBarColor': statusBarColor?.value,
        'lightColor': lightColor,
        'navColor': navColor?.value,
        'navText': navText,
        'navTextColor': navTextColor?.value,
        'navTextSize': navTextSize,
        'navTypeface': navTypeface?.index,
        'navReturnImgPath': navReturnImgPath,
        'navReturnHidden': navReturnHidden,
        'navHidden': navHidden,
        'statusBarHidden': statusBarHidden,
        'statusBarUIFlag': statusBarUIFlag?.index,
        'webViewStatusBarColor': webViewStatusBarColor?.value,
        'webNavColor': webNavColor?.value,
        'webNavTextColor': webNavTextColor?.value,
        'webNavTextSize': webNavTextSize,
        'webNavReturnImgPath': webNavReturnImgPath,
        'bottomNavColor': bottomNavColor?.value,
        'navReturnImgDrawable': navReturnImgDrawable,
      };
}
