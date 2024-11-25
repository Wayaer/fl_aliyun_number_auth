import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';
import 'package:flutter/material.dart';

/// 配置页面相关函数
class PageUIModelForAndroid {
  /// 设置授权页进场动画（即anim下文件名称，但无需带文件格式）。
  final String? authPageActIn;

  /// 设置授权页退出动画（即anim下文件名称，但无需带文件格式）。
  final String? authPageActOut;

  /// 设置屏幕方向。
  final PageOrientation? screenOrientation;

  /// 设置授权页背景图。
  final String? pageBackgroundPath;

  /// 设置弹窗模式授权页宽度（单位：px）,设置大于0，即为弹窗模式。
  final int? dialogWidth;

  /// 设置弹窗模式授权页高度（单位：px），设置大于0，即为弹窗模式。
  final int? dialogHeight;

  /// 设置弹窗授权页的蒙层透明度，取值：0~1。
  /// 值为0时，表示完全透明。
  /// 值为1时，表示完全不透明。
  /// 介于0和1之间的值，表示不同程度的半透明。
  final double? dialogAlpha;

  /// 设置弹窗模式授权页X轴偏移（单位：px）。
  final int? dialogOffsetX;

  /// 设置弹窗模式授权页Y轴偏移（单位：px）。
  final int? dialogOffsetY;

  /// 设置授权页弹窗模式，点击非弹窗区域关闭授权页。
  /// true：关闭。
  /// false：不关闭
  final bool? tapAuthPageMaskClosePage;

  /// 设置授权页是否居于底部。
  final bool? dialogBottom;

  /// 设置授权页是否居于中。
  final bool? dialogCenter;

  /// 自定义协议页跳转Action。
  final String? protocolAction;

  /// 配置自定义协议页跳转Action必须配置这个属性，值为App的包名。
  final String? packageName;

  /// 设置内置协议展示页webview缓存模式。
  final int? webCacheMode;

  const PageUIModelForAndroid({
    this.authPageActIn,
    this.authPageActOut,
    this.screenOrientation,
    this.pageBackgroundPath,
    this.dialogWidth,
    this.dialogHeight,
    this.dialogAlpha,
    this.dialogOffsetX,
    this.dialogOffsetY,
    this.tapAuthPageMaskClosePage,
    this.dialogBottom,
    this.dialogCenter,
    this.protocolAction,
    this.packageName,
    this.webCacheMode,
  });

  Map<String, dynamic> toMap() => {
        'authPageActIn': authPageActIn,
        'authPageActOut': authPageActOut,
        'screenOrientation': screenOrientation?.index,
        'pageBackgroundPath': pageBackgroundPath,
        'dialogWidth': dialogWidth,
        'dialogHeight': dialogHeight,
        'dialogAlpha': dialogAlpha,
        'dialogOffsetX': dialogOffsetX,
        'dialogOffsetY': dialogOffsetY,
        'tapAuthPageMaskClosePage': tapAuthPageMaskClosePage,
        'dialogBottom': dialogBottom,
        'dialogCenter': dialogCenter,
        'protocolAction': protocolAction,
        'packageName': packageName,
        'webCacheMode': webCacheMode,
      };
}

/// 配置页面相关函数
class PageUIModelForIOS {
  /// 全屏、弹窗模式设置，授权页面中，渲染并显示所有空间的view，称为content view，不实现该block默认为全屏模式。* 实现弹窗的方案 x > 0 || y > 0, width < 屏幕宽度 || height < 屏幕高度。
  final ViewFrameBlockForIOS? contentViewFrameBlock;

  /// 横屏、竖屏模式设置，注意：在刘海屏，UIInterfaceOrientationMaskPortraitUpsideDown 属性慎用！
  final UIInterfaceOrientationMask? supportedInterfaceOrientations;

  /// 授权页面弹出方向，默认PNSPresentationDirectionBottom。
  final PNSPresentationDirection? presentDirection;

  /// 自定义控件添加，注意：自定义视图的创建初始化和添加到父视图都需要在主线程中。
  final Function? customViewBlock;

  /// 每次授权页布局完成时会调用该block，可以在该block实现里面设置自定义添加控件的frame。
  /// 您可以在除了协议、掩码、登录按钮之外的区域添加自定义控件。
  final Function? customViewLayoutBlock;

  const PageUIModelForIOS({
    this.contentViewFrameBlock,
    this.supportedInterfaceOrientations,
    this.presentDirection,
    this.customViewBlock,
    this.customViewLayoutBlock,
  });

  Map<String, dynamic> toMap() => {
        'contentViewFrameBlock': contentViewFrameBlock?.toMap(),
        'supportedInterfaceOrientations': supportedInterfaceOrientations?.index,
        'presentDirection': presentDirection?.index,
        'customViewBlock': customViewBlock != null,
        'customViewLayoutBlock': customViewLayoutBlock != null,
      };
}
