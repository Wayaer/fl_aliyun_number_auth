import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:fl_aliyun_number_auth/src/const/extension.dart';

/// 配置授权页登录按钮
class LoginBtnUIModelForAndroid {
  /// 设置登录按钮文字。
  final String? logBtnText;

  /// 设置登录按钮文字颜色。
  final Color? logBtnTextColor;

  /// 设置登录按钮文字大小。
  final int? logBtnTextSize;

  /// 设置登录按钮宽度（单位：dp）。
  final int? logBtnWidth;

  /// 设置登录按钮高度（单位：dp）。
  final int? logBtnHeight;

  /// 设置登录按钮相对于屏幕左右边缘边距（单位：dp）。
  final int? logBtnMarginLeftAndRight;

  /// 设置登录按钮背景图片的路径。
  final String? logBtnBackgroundPath;

  /// 设置登录按钮相对导航栏顶部的位移（单位：dp）。
  final int? logBtnOffsetY;

  /// 设置登录按钮相对底部的位移（单位：dp）。
  final int? logBtnOffsetYB;

  /// 设置登录loading dialog背景图片的路径。
  final String? loadingImgPath;

  /// 说明 如果设置了setLogBtnMarginLeftAndRight，并且布局对齐方式为左对齐或右对齐,则会在margin的基础上再增加offsetX的偏移量，如果是居中对齐，则会在居中的基础上再做offsetX的偏移
  final int? logBtnOffsetX;

  /// 设置手机号掩码的布局对齐方式，支持以下三种对齐方式：
  /// [Gravity.start]、[Gravity.centerHorizontal]、[Gravity.end]
  final Gravity? logBtnLayoutGravity;

  /// Drawable
  /// 设置登录按钮背景图片的drawable对象。
  final String? logBtnBackgroundDrawable;

  /// Drawable
  /// 设置登录loading dialog背景图片的drawable对象。
  final String? loadingImgDrawable;

  /// 设置手机号码文本使用字体
  final Typeface? logBtnTypeface;

  const LoginBtnUIModelForAndroid({
    this.logBtnText,
    this.logBtnTextColor,
    this.logBtnTextSize,
    this.logBtnWidth,
    this.logBtnHeight,
    this.logBtnMarginLeftAndRight,
    this.logBtnBackgroundPath,
    this.logBtnOffsetY,
    this.logBtnOffsetYB,
    this.loadingImgPath,
    this.logBtnOffsetX,
    this.logBtnLayoutGravity,
    this.logBtnBackgroundDrawable,
    this.loadingImgDrawable,
    this.logBtnTypeface,
  });

  Map<String, dynamic> toMap() => {
        'logBtnText': logBtnText,
        'logBtnTextColor': logBtnTextColor?.value,
        'logBtnTextSize': logBtnTextSize,
        'logBtnWidth': logBtnWidth,
        'logBtnHeight': logBtnHeight,
        'logBtnMarginLeftAndRight': logBtnMarginLeftAndRight,
        'logBtnBackgroundPath': logBtnBackgroundPath,
        'logBtnOffsetY': logBtnOffsetY,
        'logBtnOffsetYB': logBtnOffsetYB,
        'loadingImgPath': loadingImgPath,
        'logBtnOffsetX': logBtnOffsetX,
        'logBtnLayoutGravity': logBtnLayoutGravity?.index,
        'logBtnBackgroundDrawable': logBtnBackgroundDrawable,
        'loadingImgDrawable': loadingImgDrawable,
        'logBtnTypeface': logBtnTypeface?.index,
      };
}

/// 配置授权页登录按钮
class LoginBtnUIModelForIOS {
  /// 设置登录按钮文案、内容、大小、颜色
  final NSAttributedString? loginBtnText;

  /// 登录按钮背景图片组，默认高度50.0pt，@[激活状态的图片、失效状态的图片、高亮状态的图片]
  final List<String>? loginBtnBgImgs;

  /// 是否自动隐藏点击登录按钮之后授权页上转圈的loading，默认为YES，在获取登录Token成功后自动隐藏，如果设置为NO，需要自己手动调用[[TXCommonHandler, sharedInstance] hideLoginLoading]隐藏。
  final bool? autoHideLoginLoading;

  /// 构建登录按钮frame，view布局或布局发生变化时调用，不实现则按默认处理，不能超出父视图content view，height不能小于40，width不能小于父视图宽度的一半。
  final ViewFrameBlockForIOS? loginBtnFrameBlock;

  /// 通过[loginBtnFrameBlock]构建frame
  /// 如果不传递则使用默认
  final Rect? loginBtnFrame;

  const LoginBtnUIModelForIOS({
    this.loginBtnText,
    this.loginBtnBgImgs,
    this.autoHideLoginLoading = true,
    this.loginBtnFrameBlock,
    this.loginBtnFrame,
  });

  Map<String, dynamic> toMap() => {
        'loginBtnText': loginBtnText?.toMap(),
        'loginBtnBgImgs': loginBtnBgImgs,
        'autoHideLoginLoading': autoHideLoginLoading,
        'loginBtnFrameBlock': loginBtnFrameBlock != null,
        'loginBtnFrame': loginBtnFrame?.toMap()
      };
}
