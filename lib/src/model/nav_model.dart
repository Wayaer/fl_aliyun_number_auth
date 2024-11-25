import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';

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

  /// 设置导航栏返回键图片路径。
  final String? navReturnImgPath;

  /// 设置导航栏返回键图片控件宽度（单位：px）。
  final int? navReturnImgWidth;

  /// 设置导航栏返回键图片控件高度（单位：px）。
  final int? navReturnImgHeight;

  /// 设置导航栏返回键图片图片缩放模式。模式类型：
  final ImageScaleType? navReturnImgScaleType;

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

  /// 设置webview是否隐藏进度条
  final bool? webHiddeProgress;

  /// 设置webview是否支持javascript
  final bool? webSupportedJavascript;

  ///  设置webview 状态栏颜色
  final Color? webViewStatusBarColor;

  /// 设置底部虚拟按键背景色（系统版本5.0以上可设置）。
  final Color? bottomNavColor;

  const NavUIModelForAndroid({
    this.navColor,
    this.navText,
    this.navTextColor,
    this.navTextSize,
    this.navTypeface,
    this.navReturnImgPath,
    this.navReturnImgWidth,
    this.navReturnImgHeight,
    this.navReturnImgScaleType,
    this.navReturnHidden,
    this.navHidden,
    this.webNavColor,
    this.webNavTextColor,
    this.webNavTextSize,
    this.webNavReturnImgPath,
    this.webHiddeProgress,
    this.webSupportedJavascript,
    this.webViewStatusBarColor,
    this.bottomNavColor,
  });

  Map<String, dynamic> toMap() => {
        'navColor': navColor?.toHex(),
        'navText': navText,
        'navTextColor': navTextColor?.toHex(),
        'navTextSize': navTextSize,
        'navTypeface': navTypeface?.index,
        'navReturnImgPath': navReturnImgPath,
        'navReturnImgWidth': navReturnImgWidth,
        'navReturnImgHeight': navReturnImgHeight,
        'navReturnImgScaleType': navReturnImgScaleType?.index,
        'navReturnHidden': navReturnHidden,
        'navHidden': navHidden,
        'webNavColor': webNavColor?.toHex(),
        'webNavTextColor': webNavTextColor?.toHex(),
        'webNavTextSize': webNavTextSize,
        'webNavReturnImgPath': webNavReturnImgPath,
        'webHiddeProgress': webHiddeProgress,
        'webSupportedJavascript': webSupportedJavascript,
        'webViewStatusBarColor': webViewStatusBarColor?.toHex(),
        'bottomNavColor': bottomNavColor?.toHex(),
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

  /// 构建导航栏返回按钮的frame（布局）
  final ViewFrameBlockForIOS? navBackButtonFrameBlock;

  /// 通过[navBackButtonFrameBlock]构建frame
  /// 如果不传递则使用默认
  final Rect? navBackButtonFrame;

  /// 通过[navBackButtonFrameBlock]构建size
  /// [navBackButtonFrame] 优先 [navBackButtonSize]
  final Size? navBackButtonSize;

  /// 构建导航栏标题的frame（布局）
  final ViewFrameBlockForIOS? navTitleFrameBlock;

  /// 通过[navTitleFrameBlock]构建frame
  /// 如果不传递则使用默认
  final Rect? navTitleFrame;
  /// 通过[navTitleFrameBlock]构建size
  /// [navTitleFrame] 优先 [navTitleSize]
  final Size? navTitleSize;
  /// 构建导航栏右侧more view的frame（布局）
  final ViewFrameBlockForIOS? navMoreViewFrameBlock;

  /// 通过[navMoreViewFrameBlock]构建frame
  /// 如果不传递则使用默认
  final Rect? navMoreViewFrame;
  /// 通过[navMoreViewFrameBlock]构建size
  /// [navMoreViewFrame] 优先 [navMoreViewSize]
  final Size? navMoreViewSize;
  /// 协议详情页导航栏背景颜色设置
  final Color? privacyNavColor;

  /// 协议详情页导航栏标题字体、大小
  final UIFont? privacyNavTitleFont;

  /// 协议详情页导航栏标题颜色
  final Color? privacyNavTitleColor;

  /// 协议详情页导航栏返回图片 仅支持 flutter 资源路径
  final String? privacyNavBackImage;

  const NavUIModelForIOS({
    this.navIsHidden,
    this.navColor,
    this.navTitle,
    this.navBackImage,
    this.hideNavBackItem,
    this.navMoreView,
    this.navBackButtonFrameBlock,
    this.navBackButtonFrame,
    this.navTitleFrameBlock,
    this.navTitleFrame,
    this.navMoreViewFrameBlock,
    this.navMoreViewFrame,
    this.privacyNavColor,
    this.privacyNavTitleFont,
    this.privacyNavTitleColor,
    this.privacyNavBackImage,
  });

  Map<String, dynamic> toMap() => {
        'navIsHidden': navIsHidden,
        'navColor': navColor?.toHex(),
        'navTitle': navTitle?.toMap(),
        'navBackImage': navBackImage,
        'hideNavBackItem': hideNavBackItem,
        'navMoreView': navMoreView?.toMap(),
        'navBackButtonFrameBlock': navBackButtonFrameBlock != null,
        'navBackButtonFrame': navBackButtonFrame?.toMap(),
        'navTitleFrameBlock': navTitleFrameBlock != null,
        'navTitleFrame': navTitleFrame?.toMap(),
        'navMoreViewFrameBlock': navMoreViewFrameBlock != null,
        'navMoreViewFrame': navMoreViewFrame?.toMap(),
        'privacyNavColor': privacyNavColor?.toHex(),
        'privacyNavTitleFont': privacyNavTitleFont?.toMap(),
        'privacyNavTitleColor': privacyNavTitleColor?.toHex(),
        'privacyNavBackImage': privacyNavBackImage,
      };
}
