import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_aliyun_number_auth/src/extension.dart';

class UIFont {
  /// 字体大小
  final int? size;

  /// 字体 Wight
  final UIFontWeight? weight;

  /// 是否使用系统加粗 默认不加粗
  /// [true] weight 无效
  final bool? isSystemBold;

  const UIFont({this.size, this.weight, this.isSystemBold});

  Map<String, dynamic> toMap() => {
        'size': size,
        'weight': weight?.value,
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
        'color': color?.toHex(),
        'backgroundColor': backgroundColor?.toHex(),
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
        'color': color?.toHex(),
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

typedef ViewFrameBlockCallbackForIOS = void Function(
    Size screenSize, Size superViewSize, Rect frame);

class ViewFrameBlockForIOS {
  /// 构建frame，view布局或布局发生变化时调用，不实现则按默认处理，不能超出父视图content view，width不能小于父视图宽度的一半。
  final ViewFrameBlockCallbackForIOS? frameBlock;

  /// 通过[frameBlock]构建frame
  /// 如果不传递则使用默认
  final Rect? frame;

  /// 通过[frameBlock]构建size
  /// [frame] 优先 [size]
  final Size? size;

  const ViewFrameBlockForIOS({
    this.frameBlock,
    this.frame,
    this.size,
  });

  Map<String, dynamic> toMap() => {
        'frameBlock': frameBlock != null,
        'frame': frame?.toMap(),
        'size': size?.toMap(),
      };
}
