import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/material.dart';

typedef ViewFrameBlockForIOS = void Function(
    Size screenSize, Size superViewSize, Rect frame);

class UIFont {
  /// 字体大小
  final int? size;

  /// 字体 Wight
  final int? weight;

  /// 是否使用系统加粗 默认不加粗
  /// [true] weight 无效
  final bool? isSystemBold;

  const UIFont({this.size, this.weight, this.isSystemBold});

  Map<String, dynamic> toMap() => {
        'size': size,
        'weight': weight,
        'isSystemBold': isSystemBold,
      };
}

class NSAttributedString {
  const NSAttributedString({
    required this.text,
    this.color,
    this.backgroundColor,
    this.wordSpacing,
    this.font,
  });

  /// 文本
  final String text;

  /// 文本颜色
  final Color? color;

  /// 背景色
  final Color? backgroundColor;

  /// 文本间距
  final double? wordSpacing;

  /// 字体
  final UIFont? font;

  Map<String, dynamic> toMap() => {
        'text': text,
        'color': color?.value,
        'backgroundColor': backgroundColor?.value,
        'wordSpacing': wordSpacing,
        'font': font?.toMap(),
      };
}

enum UIViewType {
  /// UILabel：用于显示文本信息。你可以设置文本的字体、颜色
  label,

  /// UIImageView：用于显示图像。你可以设置图像的来源（如本地文件、网络URL等）、显示模式等属性。
  image,
}

class UIView {
  final UIViewType type;

  const UIView({required this.type});

  Map<String, dynamic> toMap() => {'type': type.index};
}

class UILabel extends UIView {
  /// 文本
  final String text;

  /// 文本颜色
  final Color? color;

  /// 文本字体
  final UIFont? font;

  const UILabel(
    this.text, {
    this.color,
    this.font,
  }) : super(type: UIViewType.label);

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'text': text,
        'color': color?.value,
        'font': font?.toMap(),
      };
}

class UIImageView extends UIView {
  const UIImageView(
    this.path, {
    this.size,
    this.contentMode,
  }) : super(type: UIViewType.image);

  /// 图片路径 仅支持 flutter 资源路径
  final String path;

  /// 图片大小
  final Size? size;

  /// 图片显示方式
  final UIViewContentMode? contentMode;

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'width': size?.width,
        'height': size?.height,
        'contentMode': contentMode?.index,
      };
}
