import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

/// 配置授权页隐私栏
class PrivacyUiModel {
  /// 设置开发者隐私条款1名称和URL（名称，URL）。
  final String? privacyOne;

  /// 设置开发者隐私条款1名称和URL（名称，URL）。
  final String? privacyOneUrl;

  /// 设置开发者隐私条款2名称和URL（名称，URL）。
  final String? privacyTwo;

  /// 设置开发者隐私条款2名称和URL（名称，URL）。
  final String? privacyTwoUrl;

  /// 设置开发者隐私条款3名称和URL（名称，URL）。
  final String? privacyThree;

  /// 设置开发者隐私条款3名称和URL（名称，URL）。
  final String? privacyThreeUrl;

  /// 设置隐私条款名称颜色（基础文字颜色，协议文字颜色）。
  final Color? privacyColor;

  /// 设置隐私条款名称颜色（基础文字颜色，协议文字颜色）。
  final Color? privacyUrlColor;

  /// 设置隐私条款相对导航栏顶部的位移（单位：dp）。
  final int? privacyOffsetY;

  /// 设置隐私条款相对底部的位移（单位：dp）。
  final int? privacyOffsetYB;

  /// 设置隐私条款是否默认勾选。
  final bool? privacyState;

  /// 设置隐私条款文字对齐方式（单位：Gravity.xxx）
  final Gravity? protocolGravity;

  /// 设置隐私条款文字大小（单位：dp）。
  final int? privacyTextSize;

  /// 设置隐私条款距离手机左右边缘的边距（单位：dp）。
  final int? privacyMargin;

  /// 设置开发者隐私条款前置自定义文案。
  final String? privacyBefore;

  /// 设置开发者隐私条款尾部自定义文案。
  final String? privacyEnd;

  /// 设置复选框是否隐藏。取值：
  /// true：表示隐藏。
  /// false：表示显示
  final bool? checkboxHidden;

  /// 设置复选框未选中时图片路径。
  final String? uncheckedImgPath;

  /// 设置复选框选中时图片路径。
  final String? checkedImgPath;

  /// 设置协议复选框上边距。
  final int? checkBoxMarginTop;

  /// 设置运营商协议前缀符号，只能设置一个字符，且只能设置<>、()、《》、【】、『』、[]、（）中的一个。
  final String? vendorPrivacyPrefix;

  /// 设置运营商协议后缀符号，只能设置一个字符，且只能设置<>、()、《》、【】、『』、[]、（）中的一个。
  final String? vendorPrivacySuffix;

  /// 设置隐私栏的布局对齐方式。支持以下对齐方式：
  /// Gravity.start：左对齐
  /// Gravity.end：右对齐
  /// 说明
  /// 该参数控制了整个隐私栏（包含check box）在其父布局中的对齐方式，而setProtocolGravity控制的是隐私协议文字内容在文本框中的对齐方式。
  final Gravity? protocolLayoutGravity;

  /// 设置隐私栏X轴偏移量（单位：dp）。
  final int? privacyOffsetX;

  /// 设置check box未勾选时，点击登录按钮toast是否显示。
  final bool? logBtnToastHidden;

  /// Drawable
  /// 设置复选框未选中时的图片的drawable对象。
  final String? uncheckedImgDrawable;

  /// Drawable
  /// 设置复选框选中时的图片的drawable对象。
  final String? checkedImgDrawable;

  /// 设置协议文本使用字体。
  final Typeface? protocolTypeface;

  /// 设置授权页协议1文本颜色。
  final Color? privacyOneColor;

  /// 设置授权页协议2文本颜色。
  final Color? privacyTwoColor;

  /// 设置授权页协议3文本颜色。
  final Color? privacyThreeColor;

  /// 设置授权页运营商协议文本颜色
  final Color? privacyOperatorColor;

  /// 设置隐私协议栏复选框宽度（单位：dp）。
  final int? checkBoxWidth;

  /// 设置隐私协议栏复选框高度（单位：dp）。
  final int? checkBoxHeight;

  PrivacyUiModel({
    this.privacyOne,
    this.privacyOneUrl,
    this.privacyTwo,
    this.privacyTwoUrl,
    this.privacyThree,
    this.privacyThreeUrl,
    this.privacyColor,
    this.privacyUrlColor,
    this.privacyOffsetY,
    this.privacyOffsetYB,
    this.privacyState,
    this.protocolGravity,
    this.privacyTextSize,
    this.privacyMargin,
    this.privacyBefore,
    this.privacyEnd,
    this.checkboxHidden,
    this.uncheckedImgPath,
    this.checkedImgPath,
    this.checkBoxMarginTop,
    this.vendorPrivacyPrefix,
    this.vendorPrivacySuffix,
    this.protocolLayoutGravity,
    this.privacyOffsetX,
    this.logBtnToastHidden,
    this.uncheckedImgDrawable,
    this.checkedImgDrawable,
    this.protocolTypeface,
    this.privacyOneColor,
    this.privacyTwoColor,
    this.privacyThreeColor,
    this.privacyOperatorColor,
    this.checkBoxWidth,
    this.checkBoxHeight,
  });

  Map<String, dynamic> toMap() => {
        'privacyOne': privacyOne,
        'privacyOneUrl': privacyOneUrl,
        'privacyTwo': privacyTwo,
        'privacyTwoUrl': privacyTwoUrl,
        'privacyThree': privacyThree,
        'privacyThreeUrl': privacyThreeUrl,
        'privacyColor': privacyColor?.value,
        'privacyUrlColor': privacyUrlColor?.value,
        'privacyOffsetY': privacyOffsetY,
        'privacyOffsetYB': privacyOffsetYB,
        'privacyState': privacyState,
        'protocolGravity': protocolGravity?.index,
        'privacyTextSize': privacyTextSize,
        'privacyMargin': privacyMargin,
        'privacyBefore': privacyBefore,
        'privacyEnd': privacyEnd,
        'checkboxHidden': checkboxHidden,
        'uncheckedImgPath': uncheckedImgPath,
        'checkedImgPath': checkedImgPath,
        'checkBoxMarginTop': checkBoxMarginTop,
        'vendorPrivacyPrefix': vendorPrivacyPrefix,
        'vendorPrivacySuffix': vendorPrivacySuffix,
        'protocolLayoutGravity': protocolLayoutGravity?.index,
        'privacyOffsetX': privacyOffsetX,
        'logBtnToastHidden': logBtnToastHidden,
        'uncheckedImgDrawable': uncheckedImgDrawable,
        'checkedImgDrawable': checkedImgDrawable,
        'protocolTypeface': protocolTypeface?.index,
        'privacyOneColor': privacyOneColor?.value,
        'privacyTwoColor': privacyTwoColor?.value,
        'privacyThreeColor': privacyThreeColor?.value,
        'privacyOperatorColor': privacyOperatorColor?.value,
        'checkBoxWidth': checkBoxWidth,
        'checkBoxHeight': checkBoxHeight,
      };
}
