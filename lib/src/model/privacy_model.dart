import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';

class PrivacyTextUrl {
  /// 名称
  final String text;

  /// url
  final String url;

  const PrivacyTextUrl({required this.text, required this.url});

  Map<String, dynamic> toMap() => {'text': text, 'url': url};
}

/// 配置授权页隐私栏
class PrivacyUIModelForAndroid {
  /// 设置开发者隐私条款1名称和URL（名称，URL）。
  final PrivacyTextUrl? privacyOne;

  /// 设置开发者隐私条款2名称和URL（名称，URL）。
  final PrivacyTextUrl? privacyTwo;

  /// 设置开发者隐私条款3名称和URL（名称，URL）。
  final PrivacyTextUrl? privacyThree;

  /// 设置隐私条款名称颜色（基础文字颜色，协议文字颜色）。
  final Color? privacyColor;

  /// 设置隐私条款名称颜色（基础文字颜色，协议文字颜色）。
  final Color? privacyUrlColor;

  /// 设置隐私条款相对导航栏顶部的位移（单位：px）。
  final int? privacyOffsetY;

  /// 设置隐私条款相对底部的位移（单位：px）。
  final int? privacyOffsetYB;

  /// 设置隐私条款是否默认勾选。
  final bool? privacyState;

  /// 设置隐私条款文字对齐方式（单位：Gravity.xxx）
  final Gravity? protocolGravity;

  /// 设置隐私条款文字大小（单位：px）。
  final int? privacyTextSize;

  /// 设置隐私条款距离手机左右边缘的边距（单位：px）。
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

  /// 设置隐私栏X轴偏移量（单位：px）。
  final int? privacyOffsetX;

  /// 设置check box未勾选时，点击登录按钮toast是否显示。
  final bool? logBtnToastHidden;

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

  /// 设置隐私协议栏复选框宽度（单位：px）。
  final int? checkBoxWidth;

  /// 设置隐私协议栏复选框高度（单位：px）。
  final int? checkBoxHeight;

  const PrivacyUIModelForAndroid({
    this.privacyOne,
    this.privacyTwo,
    this.privacyThree,
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
    this.protocolTypeface,
    this.privacyOneColor,
    this.privacyTwoColor,
    this.privacyThreeColor,
    this.privacyOperatorColor,
    this.checkBoxWidth,
    this.checkBoxHeight,
  });

  Map<String, dynamic> toMap() => {
        'privacyOne': privacyOne?.toMap(),
        'privacyTwo': privacyTwo?.toMap(),
        'privacyThree': privacyThree?.toMap(),
        'privacyColor': privacyColor?.toHex(),
        'privacyUrlColor': privacyUrlColor?.toHex(),
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
        'protocolTypeface': protocolTypeface?.index,
        'privacyOneColor': privacyOneColor?.toHex(),
        'privacyTwoColor': privacyTwoColor?.toHex(),
        'privacyThreeColor': privacyThreeColor?.toHex(),
        'privacyOperatorColor': privacyOperatorColor?.toHex(),
        'checkBoxWidth': checkBoxWidth,
        'checkBoxHeight': checkBoxHeight,
      };
}

/// 配置授权页隐私栏
class PrivacyUIModelForIOS {
  /// 设置checkBox图片组，[uncheckedImg, checkedImg]
  final List<String>? checkBoxImages;

  /// checkBox是否勾选，默认NO
  final bool? checkBoxIsChecked;

  /// checkBox是否隐藏，默认NO
  final bool? checkBoxIsHidden;

  /// checkBox大小，高宽一样，必须大于0
  final double? checkBoxWH;

  /// 协议1，[协议名称，协议Url]，注：三个协议名称不能相同
  final PrivacyTextUrl? privacyOne;

  /// 协议2，[协议名称，协议Url]，注：三个协议名称不能相同
  final PrivacyTextUrl? privacyTwo;

  /// 协议3，[协议名称，协议Url]，注：三个协议名称不能相同
  final PrivacyTextUrl? privacyThree;

  /// 协议内容颜色数组，[非点击文案颜色，点击文案颜色]
  final List<Color>? privacyColors;

  /// 协议文案支持居中，居左设置，默认居左
  final NSTextAlignment? privacyAlignment;

  /// 协议整体文案，前缀部分文案
  final String? privacyPreText;

  /// 协议整体文案，后缀部分文案
  final String? privacySufText;

  /// 运营商协议名称前缀文案，仅支持<、(、[、{、（、【、『、。
  final String? privacyOperatorPreText;

  /// 运营商协议 >、)、]、}、）、】、』
  final String? privacyOperatorSufText;

  /// 协议整体文案字体大小，小于12.0 不生效
  final UIFont? privacyFont;

  /// 构建协议整体（包括checkBox）的frame，view布局或布局发生变化时调用，不实现则按默认处理，如果设置的width小于checkBox的宽度则不生效，最小值为0，最大width，height为父视图宽高，最终会根据设置进来的width对协议文本进行自适应，得到的size是协议空间的最终大小。
  final ViewFrameBlockForIOS? privacyFrameBlock;

  /// 运营商协议内容颜色 ，优先级最高，如果privacyOperatorColors不设置，则取privacyColors中的点击文案颜色，privacyColors不设置，则是默认色
  final Color? privacyOperatorColor;

  /// 协议1内容颜色，优先级最高，如果privacyOneColors不设置，则取privacyColors中的点击文案颜色，privacyColors不设置，则是默认色
  final Color? privacyOneColor;

  /// 协议2内容颜色，优先级最高，如果privacyTwoColors不设置，则取privacyColors中的点击文案颜色，privacyColors不设置，则是默认色
  final Color? privacyTwoColor;

  /// 协议3内容颜色，优先级最高，如果privacyThreeColors不设置，则取privacyColors中的点击文案颜色，privacyColors不设置，则是默认色
  final Color? privacyThreeColor;

  const PrivacyUIModelForIOS(
      {this.checkBoxImages,
      this.checkBoxIsChecked,
      this.checkBoxIsHidden,
      this.checkBoxWH,
      this.privacyOne,
      this.privacyTwo,
      this.privacyThree,
      this.privacyColors,
      this.privacyAlignment,
      this.privacyPreText,
      this.privacySufText,
      this.privacyOperatorPreText,
      this.privacyOperatorSufText,
      this.privacyFont,
      this.privacyFrameBlock,
      this.privacyOperatorColor,
      this.privacyOneColor,
      this.privacyTwoColor,
      this.privacyThreeColor});

  Map<String, dynamic> toMap() => {
        'checkBoxImages': checkBoxImages,
        'checkBoxIsChecked': checkBoxIsChecked,
        'checkBoxIsHidden': checkBoxIsHidden,
        'checkBoxWH': checkBoxWH,
        'privacyOne': privacyOne?.toMap(),
        'privacyTwo': privacyTwo?.toMap(),
        'privacyThree': privacyThree?.toMap(),
        'privacyColors': privacyColors?.map((e) => e.toHex()).toList(),
        'privacyAlignment': privacyAlignment?.index,
        'privacyPreText': privacyPreText,
        'privacySufText': privacySufText,
        'privacyOperatorPreText': privacyOperatorPreText,
        'privacyOperatorSufText': privacyOperatorSufText,
        'privacyFont': privacyFont?.toMap(),
        'privacyFrameBlock': privacyFrameBlock?.toMap(),
        'privacyOperatorColor': privacyOperatorColor?.toHex(),
        'privacyOneColor': privacyOneColor?.toHex(),
        'privacyTwoColor': privacyTwoColor?.toHex(),
        'privacyThreeColor': privacyThreeColor?.toHex(),
      };
}
