import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

/// 配置授权页导航栏
class NavUIModelForAndroid {
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

  const NavUIModelForAndroid({
    this.navColor,
    this.navText,
    this.navTextColor,
    this.navTextSize,
    this.navTypeface,
    this.navReturnImgPath,
    this.navReturnHidden,
    this.navHidden,
    this.webNavColor,
    this.webNavTextColor,
    this.webNavTextSize,
    this.webNavReturnImgPath,
    this.bottomNavColor,
    this.navReturnImgDrawable,
  });

  Map<String, dynamic> toMap() => {
        'navColor': navColor?.value,
        'navText': navText,
        'navTextColor': navTextColor?.value,
        'navTextSize': navTextSize,
        'navTypeface': navTypeface?.index,
        'navReturnImgPath': navReturnImgPath,
        'navReturnHidden': navReturnHidden,
        'navHidden': navHidden,
        'webNavColor': webNavColor?.value,
        'webNavTextColor': webNavTextColor?.value,
        'webNavTextSize': webNavTextSize,
        'webNavReturnImgPath': webNavReturnImgPath,
        'bottomNavColor': bottomNavColor?.value,
        'navReturnImgDrawable': navReturnImgDrawable,
      };
}

/// 配置授权页导航栏
class NavUIModelForIOS {
  /// 设置导航栏是否隐藏
  final bool? navIsHidden;

  /// 设置导航栏的主题色
  final Color? navColor;

  /// 设置导航栏标题内容、文字大小、颜色
  /// 包含标题内容、文字大小和颜色等
  final NSAttributedString? navTitle;

  /// 设置导航栏返回图片
  final String? navBackImage;

  /// 设置导航栏返回按钮是否隐藏
  final bool? hideNavBackItem;

  /// 导航栏右侧自定义控件，可以包含手势操作或按钮
  final UIView? navMoreView;

  // /// 构建导航栏返回按钮的frame（布局）
  // final Function? navBackButtonFrameBlock;
  //
  // /// 构建导航栏标题的frame（布局）
  // final Function? navTitleFrameBlock;
  //
  // /// 构建导航栏右侧more view的frame（布局）
  // final Function? navMoreViewFrameBlock;

  /// 协议详情页导航栏背景颜色设置
  final String? privacyNavColor;

  /// 协议详情页导航栏标题字体、大小
  final UIFont? privacyNavTitleFont;

  /// 协议详情页导航栏标题颜色
  final String? privacyNavTitleColor;

  /// 协议详情页导航栏返回图片
  final UIImage? privacyNavBackImage;

  const NavUIModelForIOS({
    this.navIsHidden,
    this.navColor,
    this.navTitle,
    this.navBackImage,
    this.hideNavBackItem,
    this.navMoreView,
    // this.navBackButtonFrameBlock,
    // this.navTitleFrameBlock,
    // this.navMoreViewFrameBlock,
    this.privacyNavColor,
    this.privacyNavTitleFont,
    this.privacyNavTitleColor,
    this.privacyNavBackImage,
  });

  Map<String, dynamic> toMap() => {
        'navIsHidden': navIsHidden,
        'navColor': navColor,
        'navTitle': navTitle,
        'navBackImage': navBackImage,
        'hideNavBackItem': hideNavBackItem,
        'navMoreView': navMoreView,
        // 'navBackButtonFrameBlock': navBackButtonFrameBlock,
        // 'navTitleFrameBlock': navTitleFrameBlock,
        // 'navMoreViewFrameBlock': navMoreViewFrameBlock,
        'privacyNavColor': privacyNavColor,
        'privacyNavTitleFont': privacyNavTitleFont,
        'privacyNavTitleColor': privacyNavTitleColor,
        'privacyNavBackImage': privacyNavBackImage,
      };
}

class NSAttributedString {}

class UIImage {}

class UIFont {}

class UIView {}
