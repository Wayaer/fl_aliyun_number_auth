import 'dart:ui';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';

/// 二次隐私协议弹窗页面
class PrivacyAlertUIModelForAndroid {
  /// 设置二次隐私协议弹窗是否需要显示。取值：
  /// true：表示显示。
  /// false（默认值）：表示不显示。
  final bool? privacyAlertIsNeedShow;

  /// 设置二次隐私协议弹窗点击按钮是否需要执行登录。取值：
  /// true（默认值）：表示需要执行。
  /// false：表示不需要执行。
  final bool? privacyAlertIsNeedAutoLogin;

  /// 设置二次隐私协议弹窗背景蒙层是否显示。
  /// true（默认值）：表示显示。
  /// false：表示不显示。
  final bool? privacyAlertMaskIsNeedShow;

  /// 设置二次隐私协议弹窗蒙层透明度。默认值0.3。
  /// 说明
  /// 取值范围0.3~1.0。
  final double? privacyAlertMaskAlpha;

  /// 设置二次隐私协议弹窗透明度。默认值1.0。
  /// 说明
  /// 取值范围0.3~1.0。
  final double? privacyAlertAlpha;

  /// 设置二次隐私协议弹窗背景色（同意并继续按钮区域）。
  final Color? privacyAlertBackgroundColor;

  /// 设置二次隐私协议弹窗显示自定义动画。
  final String? privacyAlertEntryAnimation;

  /// 设置二次隐私协议弹窗隐藏自定义动画。
  final String? privacyAlertExitAnimation;

  /// 设置二次隐私协议弹窗的四个圆角值。
  /// 说明
  /// 顺序为左上、右上、右下、左下，需要填充4个值，不足4个值则无效，如果值小于等于0则为直角。
  final List<int>? privacyAlertCornerRadiusArray;

  /// 设置屏幕居中、居上、居下、居左、居右，默认居中显示。
  final Gravity? privacyAlertAlignment;

  /// 设置弹窗宽度。
  final int? privacyAlertWidth;

  /// 设置弹窗高度。
  final int? privacyAlertHeight;

  /// 设置弹窗水平偏移量。（单位：px）
  final int? privacyAlertOffsetX;

  /// 设置弹窗竖直偏移量。（单位：px）
  final int? privacyAlertOffsetY;

  /// 设置二次隐私协议弹窗标题背景颜色。
  final Color? privacyAlertTitleBackgroundColor;

  /// 设置二次隐私协议弹窗标题支持居中、居左，默认居中显示。
  final Gravity? privacyAlertTitleAlignment;

  /// 设置标题文字水平偏移量。（单位：px）
  final int? privacyAlertTitleOffsetX;

  /// 设置标题文字竖直偏移量。（单位：px）
  final int? privacyAlertTitleOffsetY;

  /// 设置标题文本。
  final String? privacyAlertTitleContent;

  /// 设置标题文字大小，默认值18 sp。
  final int? privacyAlertTitleTextSize;

  /// 设置标题文字颜色。
  final Color? privacyAlertTitleColor;

  /// 设置协议内容背景颜色。
  final Color? privacyAlertContentBackgroundColor;

  /// 设置服务协议文字大小，默认值16 sp。
  final int? privacyAlertContentTextSize;

  /// 设置二次隐私协议弹窗协议文案支持居中、居左，默认居左显示。
  final Gravity? privacyAlertContentAlignment;

  /// 设置服务协议文字颜色。
  final Color? privacyAlertContentColor;

  /// 设置服务协议非协议文字颜色。
  final Color? privacyAlertContentBaseColor;

  /// 设置服务协议左右两侧间距。
  final int? privacyAlertContentHorizontalMargin;

  /// 设置服务协议上下间距。
  final int? privacyAlertContentVerticalMargin;

  /// 设置按钮背景图片路径。
  final String? privacyAlertBtnBackgroundImgPath;

  /// 设置确认按钮文字颜色。
  final Color? privacyAlertBtnTextColor;

  /// 设置确认按钮文字颜色路径。
  // final String? privacyAlertBtnTextColorPath;

  /// 设置确认按钮文字大小，默认值18 sp。
  final int? privacyAlertBtnTextSize;

  /// 设置确认按钮宽度。（单位：px）
  final int? privacyAlertBtnWidth;

  /// 设置确认按钮高度。（单位：px）
  final int? privacyAlertBtnHeight;

  /// 设置右上角的关闭按钮。
  /// true（默认值）：显示关闭按钮。
  /// false：不显示关闭按钮
  final bool? privacyAlertCloseBtnShow;

  /// 设置关闭按钮图片路径。
  final String? privacyAlertCloseImgPath;

  /// 设置关闭按钮缩放类型
  final ImageScaleType? privacyAlertCloseScaleType;

  /// 设置关闭按钮宽度。（单位：px）
  final int? privacyAlertCloseImgWidth;

  /// 设置关闭按钮高度。（单位：px）
  final int? privacyAlertCloseImgHeight;

  /// 设置确认按钮布局方式。
  final List<Gravity>? privacyAlertBtnGravity;

  /// 设置确认按钮文本。
  final String? privacyAlertBtnContent;

  /// 设置二次弹窗确定按钮横向坐标。
  /// 说明
  /// privacyAlertBtnOffsetX属性优先级高于privacyAlertBtnGravity、privacyAlertBtnHorizontalMargin。
  final int? privacyAlertBtnOffsetX;

  /// 设置二次弹窗确定按钮纵向坐标。
  /// 说明
  /// privacyAlertBtnOffsetY属性优先级高于privacyAlertBtnGravity、privacyAlertBtnVerticalMargin。
  final int? privacyAlertBtnOffsetY;

  /// 设置确认按钮的横向边距。
  final int? privacyAlertBtnHorizontalMargin;

  /// 设置确认按钮的纵向边距。
  final int? privacyAlertBtnVerticalMargin;

  /// 设置二次隐私协议弹窗点击背景蒙层是否关闭弹窗。
  /// true（默认值）：表示关闭。
  /// false：表示不关闭
  final bool? tapPrivacyAlertMaskCloseAlert;

  /// 设置二次弹窗title文本使用字体。
  final Typeface? privacyAlertTitleTypeface;

  /// 设置二次弹窗协议文本使用字体。
  final Typeface? privacyAlertContentTypeface;

  /// 设置二次弹窗确认按钮文本使用字体。
  final Typeface? privacyAlertBtnTypeface;

  /// 二次弹窗协议前缀。
  final String? privacyAlertBefore;

  /// 二次弹窗协议后缀。
  final String? privacyAlertEnd;

  /// 设置授权页协议1文本颜色。
  final Color? privacyAlertOneColor;

  /// 设置授权页协议2文本颜色。
  final Color? privacyAlertTwoColor;

  /// 设置授权页协议3文本颜色。
  final Color? privacyAlertThreeColor;

  /// 设置授权页运营商协议文本颜色。
  final Color? privacyAlertOperatorColor;

  const PrivacyAlertUIModelForAndroid({
    this.privacyAlertIsNeedShow,
    this.privacyAlertIsNeedAutoLogin,
    this.privacyAlertMaskIsNeedShow,
    this.privacyAlertMaskAlpha,
    this.privacyAlertAlpha,
    this.privacyAlertBackgroundColor,
    this.privacyAlertEntryAnimation,
    this.privacyAlertExitAnimation,
    this.privacyAlertCornerRadiusArray,
    this.privacyAlertAlignment,
    this.privacyAlertWidth,
    this.privacyAlertHeight,
    this.privacyAlertOffsetX,
    this.privacyAlertOffsetY,
    this.privacyAlertTitleBackgroundColor,
    this.privacyAlertTitleAlignment,
    this.privacyAlertTitleOffsetX,
    this.privacyAlertTitleOffsetY,
    this.privacyAlertTitleContent,
    this.privacyAlertTitleTextSize,
    this.privacyAlertTitleColor,
    this.privacyAlertContentBackgroundColor,
    this.privacyAlertContentTextSize,
    this.privacyAlertContentAlignment,
    this.privacyAlertContentColor,
    this.privacyAlertContentBaseColor,
    this.privacyAlertContentHorizontalMargin,
    this.privacyAlertContentVerticalMargin,
    this.privacyAlertBtnBackgroundImgPath,
    this.privacyAlertBtnTextColor,
    // this.privacyAlertBtnTextColorPath,
    this.privacyAlertBtnTextSize,
    this.privacyAlertBtnWidth,
    this.privacyAlertBtnHeight,
    this.privacyAlertCloseBtnShow,
    this.privacyAlertCloseImgPath,
    this.privacyAlertCloseScaleType,
    this.privacyAlertCloseImgWidth,
    this.privacyAlertCloseImgHeight,
    this.privacyAlertBtnGravity,
    this.privacyAlertBtnContent,
    this.privacyAlertBtnOffsetX,
    this.privacyAlertBtnOffsetY,
    this.privacyAlertBtnHorizontalMargin,
    this.privacyAlertBtnVerticalMargin,
    this.tapPrivacyAlertMaskCloseAlert,
    this.privacyAlertTitleTypeface,
    this.privacyAlertContentTypeface,
    this.privacyAlertBtnTypeface,
    this.privacyAlertBefore,
    this.privacyAlertEnd,
    this.privacyAlertOneColor,
    this.privacyAlertTwoColor,
    this.privacyAlertThreeColor,
    this.privacyAlertOperatorColor,
  });

  Map<String, dynamic> toMap() => {
        'privacyAlertIsNeedShow': privacyAlertIsNeedShow,
        'privacyAlertIsNeedAutoLogin': privacyAlertIsNeedAutoLogin,
        'privacyAlertMaskIsNeedShow': privacyAlertMaskIsNeedShow,
        'privacyAlertMaskAlpha': privacyAlertMaskAlpha,
        'privacyAlertAlpha': privacyAlertAlpha,
        'privacyAlertBackgroundColor': privacyAlertBackgroundColor?.toMap(),
        'privacyAlertEntryAnimation': privacyAlertEntryAnimation,
        'privacyAlertExitAnimation': privacyAlertExitAnimation,
        'privacyAlertCornerRadiusArray': privacyAlertCornerRadiusArray,
        'privacyAlertAlignment': privacyAlertAlignment?.index,
        'privacyAlertWidth': privacyAlertWidth,
        'privacyAlertHeight': privacyAlertHeight,
        'privacyAlertOffsetX': privacyAlertOffsetX,
        'privacyAlertOffsetY': privacyAlertOffsetY,
        'privacyAlertTitleBackgroundColor':
            privacyAlertTitleBackgroundColor?.toMap(),
        'privacyAlertTitleAlignment': privacyAlertTitleAlignment?.index,
        'privacyAlertTitleOffsetX': privacyAlertTitleOffsetX,
        'privacyAlertTitleOffsetY': privacyAlertTitleOffsetY,
        'privacyAlertTitleContent': privacyAlertTitleContent,
        'privacyAlertTitleTextSize': privacyAlertTitleTextSize,
        'privacyAlertTitleColor': privacyAlertTitleColor?.toMap(),
        'privacyAlertContentBackgroundColor':
            privacyAlertContentBackgroundColor?.toMap(),
        'privacyAlertContentTextSize': privacyAlertContentTextSize,
        'privacyAlertContentAlignment': privacyAlertContentAlignment?.index,
        'privacyAlertContentColor': privacyAlertContentColor?.toMap(),
        'privacyAlertContentBaseColor': privacyAlertContentBaseColor?.toMap(),
        'privacyAlertContentHorizontalMargin':
            privacyAlertContentHorizontalMargin,
        'privacyAlertContentVerticalMargin': privacyAlertContentVerticalMargin,
        'privacyAlertBtnBackgroundImgPath': privacyAlertBtnBackgroundImgPath,
        'privacyAlertBtnTextColor': privacyAlertBtnTextColor?.toMap(),
        // 'privacyAlertBtnTextColorPath': privacyAlertBtnTextColorPath,
        'privacyAlertBtnTextSize': privacyAlertBtnTextSize,
        'privacyAlertBtnWidth': privacyAlertBtnWidth,
        'privacyAlertBtnHeight': privacyAlertBtnHeight,
        'privacyAlertCloseBtnShow': privacyAlertCloseBtnShow,
        'privacyAlertCloseImgPath': privacyAlertCloseImgPath,
        'privacyAlertCloseScaleType': privacyAlertCloseScaleType?.index,
        'privacyAlertCloseImgWidth': privacyAlertCloseImgWidth,
        'privacyAlertCloseImgHeight': privacyAlertCloseImgHeight,
        'privacyAlertBtnGravity':
            privacyAlertBtnGravity?.map((e) => e.index).toList(),
        'privacyAlertBtnContent': privacyAlertBtnContent,
        'privacyAlertBtnOffsetX': privacyAlertBtnOffsetX,
        'privacyAlertBtnOffsetY': privacyAlertBtnOffsetY,
        'privacyAlertBtnHorizontalMargin': privacyAlertBtnHorizontalMargin,
        'privacyAlertBtnVerticalMargin': privacyAlertBtnVerticalMargin,
        'tapPrivacyAlertMaskCloseAlert': tapPrivacyAlertMaskCloseAlert,
        'privacyAlertTitleTypeface': privacyAlertTitleTypeface?.index,
        'privacyAlertContentTypeface': privacyAlertContentTypeface?.index,
        'privacyAlertBtnTypeface': privacyAlertBtnTypeface?.index,
        'privacyAlertBefore': privacyAlertBefore,
        'privacyAlertEnd': privacyAlertEnd,
        'privacyAlertOneColor': privacyAlertOneColor?.toMap(),
        'privacyAlertTwoColor': privacyAlertTwoColor?.toMap(),
        'privacyAlertThreeColor': privacyAlertThreeColor?.toMap(),
        'privacyAlertOperatorColor': privacyAlertOperatorColor?.toMap(),
      };
}

/// 二次隐私协议弹窗页面
class PrivacyAlertUIModelForIOS {
  /// 设置二次隐私协议弹窗是否显示。取值：
  /// NO（默认值）：表示不显示。
  /// YES：表示显示。
  final bool? privacyAlertIsNeedShow;

  /// 设置二次隐私协议弹窗点击按钮是否需要执行登录。取值：
  /// NO：表示不需要执行登录。
  /// YES（默认值）：表示需要执行登录。
  final bool? privacyAlertIsNeedAutoLogin;

  /// 设置二次隐私协议弹窗显示自定义动画，默认从下往上位移动画。
  /// final String? privacyAlertEntryAnimation;

  /// 设置二次隐私协议弹窗隐藏自定义动画，默认从上往下位移动画。
  /// final String? privacyAlertExitAnimation;

  /// 设置二次隐私协议弹窗的四个圆角值。
  /// 顺序为左上，左下，右下，右上，需要填充4个值，不足4个值则无效，如果值小于等于0则为直角。
  final List<int>? privacyAlertCornerRadiusArray;

  /// 设置二次隐私协议弹窗背景颜色。
  final Color? privacyAlertBackgroundColor;

  /// 设置二次隐私协议弹窗透明度，默认值1.0。
  final double? privacyAlertAlpha;

  /// 设置二次隐私协议弹窗标题文字大小。
  final UIFont? privacyAlertTitleFont;

  /// 设置二次隐私协议弹窗标题文字颜色。
  final Color? privacyAlertTitleColor;

  /// 设置二次隐私协议弹窗标题背景颜色。
  final Color? privacyAlertTitleBackgroundColor;

  /// 设置二次隐私协议弹窗标题位置，默认居中。
  final NSTextAlignment? privacyAlertTitleAlignment;

  /// 设置二次隐私协议弹窗协议内容文字大小，默认值13 dp，最小值12 dp。
  final UIFont? privacyAlertContentFont;

  /// 设置二次隐私协议弹窗协议内容背景颜色。
  final Color? privacyAlertContentBackgroundColor;

  /// 设置二次隐私协议弹窗协议内容颜色数组。
  final List<Color>? privacyAlertContentColors;

  /// 设置二次隐私协议弹窗协议内容
  final NSTextAlignment? privacyAlertContentAlignment;

  /// 设置二次隐私协议弹窗按钮背景图片。
  final List<String>? privacyAlertBtnBackgroundImages;

  /// 设置二次隐私协议弹窗按钮文字颜色。
  final List<Color>? privacyAlertButtonTextColors;

  /// 设置二次隐私协议弹窗按钮文字大小，默认值18 dp，最小值10 dp。
  final UIFont? privacyAlertButtonFont;

  /// 设置二次隐私协议弹窗关闭按钮是否显示。
  final bool? privacyAlertCloseButtonIsNeedShow;

  /// 设置二次隐私协议弹窗右侧关闭按钮图片。
  final String? privacyAlertCloseButtonImage;

  /// 设置二次隐私协议弹窗背景蒙层是否显示。
  final bool? privacyAlertMaskIsNeedShow;

  /// 设置二次隐私协议弹窗点击背景蒙层是否关闭弹窗。
  final bool? tapPrivacyAlertMaskCloseAlert;

  /// 设置二次隐私协议弹窗蒙版背景颜色。
  final Color? privacyAlertMaskColor;

  /// 设置二次隐私协议弹窗蒙版透明度，默认值0.5。
  final double? privacyAlertMaskAlpha;

  /// 二次隐私协议弹窗协议运营商协议内容颜色。
  final Color? privacyAlertOperatorColor;

  /// 二次隐私协议弹窗协议1内容颜色。
  final Color? privacyAlertOneColor;

  /// 二次隐私协议弹窗协议2内容颜色。
  final Color? privacyAlertTwoColor;

  /// 二次隐私协议弹窗协议3内容颜色。
  final Color? privacyAlertThreeColor;

  /// 二次隐私协议弹窗协议整体文案，前缀部分文案。
  final String? privacyAlertPreText;

  /// 二次隐私协议弹窗协议整体文案，后缀部分文案。
  final String? privacyAlertSufText;

  /// 设置二次隐私协议弹窗蒙版显示动画，默认渐显动画。
  /// final String? privacyAlertMaskEntryAnimation;

  /// 设置二次隐私协议弹窗蒙版消失动画，默认渐隐动画。
  /// final String? privacyAlertMaskExitAnimation;

  /// 设置二次隐私协议弹窗尺寸。
  final ViewFrameBlockForIOS? privacyAlertFrameBlock;

  /// 设置二次隐私协议弹窗标题尺寸。
  final ViewFrameBlockForIOS? privacyAlertTitleFrameBlock;

  /// 设置二次隐私协议弹窗内容尺寸。
  final ViewFrameBlockForIOS? privacyAlertPrivacyContentFrameBlock;

  /// 设置二次隐私协议弹窗按钮尺寸。
  final ViewFrameBlockForIOS? privacyAlertButtonFrameBlock;

  /// 设置二次隐私协议弹窗右侧关闭按钮尺寸。
  final ViewFrameBlockForIOS? privacyAlertCloseFrameBlock;

  /// 设置二次隐私协议弹窗按钮文字内容。
  final String? privacyAlertBtnContent;

  /// 设置二次隐私协议弹窗标题文字内容。
  final String? privacyAlertTitleContent;

  /// 二次授权页弹窗自定义控件添加。
  final Function? privacyAlertCustomViewBlock;

  /// 二次授权页设置自定义添加控件的frame。
  final Function? privacyAlertCustomViewLayoutBlock;

  const PrivacyAlertUIModelForIOS({
    this.privacyAlertIsNeedShow,
    this.privacyAlertIsNeedAutoLogin,

    /// this.privacyAlertEntryAnimation,
    /// this.privacyAlertExitAnimation,
    this.privacyAlertCornerRadiusArray,
    this.privacyAlertBackgroundColor,
    this.privacyAlertAlpha,
    this.privacyAlertTitleFont,
    this.privacyAlertTitleColor,
    this.privacyAlertTitleBackgroundColor,
    this.privacyAlertTitleAlignment,
    this.privacyAlertContentFont,
    this.privacyAlertContentBackgroundColor,
    this.privacyAlertContentColors,
    this.privacyAlertContentAlignment,
    this.privacyAlertBtnBackgroundImages,
    this.privacyAlertButtonTextColors,
    this.privacyAlertButtonFont,
    this.privacyAlertCloseButtonIsNeedShow,
    this.privacyAlertCloseButtonImage,
    this.privacyAlertMaskIsNeedShow,
    this.tapPrivacyAlertMaskCloseAlert,
    this.privacyAlertMaskColor,
    this.privacyAlertMaskAlpha,
    this.privacyAlertOperatorColor,
    this.privacyAlertOneColor,
    this.privacyAlertTwoColor,
    this.privacyAlertThreeColor,
    this.privacyAlertPreText,
    this.privacyAlertSufText,

    /// this.privacyAlertMaskEntryAnimation,
    /// this.privacyAlertMaskExitAnimation,
    this.privacyAlertFrameBlock,
    this.privacyAlertTitleFrameBlock,
    this.privacyAlertPrivacyContentFrameBlock,
    this.privacyAlertButtonFrameBlock,
    this.privacyAlertCloseFrameBlock,
    this.privacyAlertBtnContent,
    this.privacyAlertTitleContent,
    this.privacyAlertCustomViewBlock,
    this.privacyAlertCustomViewLayoutBlock,
  });

  /// 假设有合适的转换方法，可以将alertTitle和alertCloseImage转换为Dart中的有效类型
  /// 这里仅提供基本框架，具体实现需要根据实际情况进行

  Map<String, dynamic> toMap() => {
        'privacyAlertIsNeedShow': privacyAlertIsNeedShow,
        'privacyAlertIsNeedAutoLogin': privacyAlertIsNeedAutoLogin,

        /// 'privacyAlertEntryAnimation': privacyAlertEntryAnimation,
        /// 'privacyAlertExitAnimation': privacyAlertExitAnimation,
        'privacyAlertCornerRadiusArray': privacyAlertCornerRadiusArray,
        'privacyAlertBackgroundColor': privacyAlertBackgroundColor?.toMap(),
        'privacyAlertAlpha': privacyAlertAlpha,
        'privacyAlertTitleFont': privacyAlertTitleFont?.toMap(),
        'privacyAlertTitleColor': privacyAlertTitleColor?.toMap(),
        'privacyAlertTitleBackgroundColor':
            privacyAlertTitleBackgroundColor?.toMap(),
        'privacyAlertTitleAlignment': privacyAlertTitleAlignment?.index,
        'privacyAlertContentFont': privacyAlertContentFont?.toMap(),
        'privacyAlertContentBackgroundColor':
            privacyAlertContentBackgroundColor?.toMap(),
        'privacyAlertContentColors':
            privacyAlertContentColors?.map((e) => e.toMap()).toList(),
        'privacyAlertContentAlignment': privacyAlertContentAlignment?.index,
        'privacyAlertBtnBackgroundImages': privacyAlertBtnBackgroundImages,
        'privacyAlertButtonTextColors':
            privacyAlertButtonTextColors?.map((e) => e.toMap()).toList(),
        'privacyAlertButtonFont': privacyAlertButtonFont?.toMap(),
        'privacyAlertCloseButtonIsNeedShow': privacyAlertCloseButtonIsNeedShow,
        'privacyAlertCloseButtonImage': privacyAlertCloseButtonImage,
        'privacyAlertMaskIsNeedShow': privacyAlertMaskIsNeedShow,
        'tapPrivacyAlertMaskCloseAlert': tapPrivacyAlertMaskCloseAlert,
        'privacyAlertMaskColor': privacyAlertMaskColor?.toMap(),
        'privacyAlertMaskAlpha': privacyAlertMaskAlpha,
        'privacyAlertOperatorColor': privacyAlertOperatorColor?.toMap(),
        'privacyAlertOneColor': privacyAlertOneColor?.toMap(),
        'privacyAlertTwoColor': privacyAlertTwoColor?.toMap(),
        'privacyAlertThreeColor': privacyAlertThreeColor?.toMap(),
        'privacyAlertPreText': privacyAlertPreText,
        'privacyAlertSufText': privacyAlertSufText,

        /// 'privacyAlertMaskEntryAnimation': privacyAlertMaskEntryAnimation,
        /// 'privacyAlertMaskExitAnimation': privacyAlertMaskExitAnimation,
        'privacyAlertFrameBlock': privacyAlertFrameBlock?.toMap(),
        'privacyAlertTitleFrameBlock': privacyAlertTitleFrameBlock?.toMap(),
        'privacyAlertPrivacyContentFrameBlock':
            privacyAlertPrivacyContentFrameBlock?.toMap(),
        'privacyAlertButtonFrameBlock': privacyAlertButtonFrameBlock?.toMap(),
        'privacyAlertCloseFrameBlock': privacyAlertCloseFrameBlock?.toMap(),
        'privacyAlertBtnContent': privacyAlertBtnContent,
        'privacyAlertTitleContent': privacyAlertTitleContent,
        'privacyAlertCustomViewBlock': privacyAlertCustomViewBlock != null,
        'privacyAlertCustomViewLayoutBlock':
            privacyAlertCustomViewLayoutBlock != null,
      };
}
