import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

/// 配置页面相关函数
class PageUiModelForAndroid {
  /// 设置授权页进场动画（即anim下文件名称，但无需带文件格式）。
  final String? authPageActIn;

  /// 设置授权页退出动画（即anim下文件名称，但无需带文件格式）。
  final String? authPageActOut;

  /// 设置屏幕方向。
  final PageOrientation? screenOrientation;

  /// 设置授权页背景图。
  /// 说明
  /// drawable资源的目录，不需要加后缀，如图片在drawable中的存放目录是res/drawable-xxhdpi/loading.png,则传入参数为"loading"，setPageBackgroundPath("loading")。
  final String? pageBackgroundPath;

  /// 设置弹窗模式授权页宽度（单位：dp）,设置大于0，即为弹窗模式。
  final int? dialogWidth;

  /// 设置弹窗模式授权页高度（单位：dp），设置大于0，即为弹窗模式。
  final int? dialogHeight;

  /// 设置弹窗授权页的蒙层透明度，取值：0~1。
  /// 值为0时，表示完全透明。
  /// 值为1时，表示完全不透明。
  /// 介于0和1之间的值，表示不同程度的半透明。
  final double? dialogAlpha;

  /// 设置弹窗模式授权页X轴偏移（单位：dp）。
  final int? dialogOffsetX;

  /// 设置弹窗模式授权页Y轴偏移（单位：dp）。
  final int? dialogOffsetY;

  /// 设置授权页弹窗模式，点击非弹窗区域关闭授权页。
  /// true：关闭。
  /// false：不关闭
  final bool? tapAuthPageMaskClosePage;

  /// 设置授权页是否居于底部。
  final bool? dialogBottom;

  /// Drawable
  /// 设置授权页背景图的drawable对象。
  final String? pageBackgroundDrawable;

  /// 自定义协议页跳转Action。
  final String? protocolAction;

  /// 配置自定义协议页跳转Action必须配置这个属性，值为App的包名。
  final String? packageName;

  /// 设置内置协议展示页webview缓存模式。
  final int? webCacheMode;

  const PageUiModelForAndroid({
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
    this.pageBackgroundDrawable,
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
        'pageBackgroundDrawable': pageBackgroundDrawable,
        'protocolAction': protocolAction,
        'packageName': packageName,
        'webCacheMode': webCacheMode,
      };
}

/// 配置页面相关函数
class PageUiModelForIOS {
  const PageUiModelForIOS();

  Map<String, dynamic> toMap() => {};
}
