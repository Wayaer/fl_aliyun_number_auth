import 'package:flutter/material.dart';

extension ExtensionRect on Rect {
  Map<String, dynamic> toMap() =>
      {'x': left, 'y': top, 'width': width, 'height': height};
}

extension ExtensionOffset on Offset {
  Map<String, dynamic> toMap() => {'x': dx, 'y': dy};
}

extension ExtensionColor on Color {
  String toHex() {
    // 获取颜色的 ARGB 分量，转换为十六进制并填充到 8 位
    String hexColor = value.toRadixString(16).padLeft(8, '0');
    // 直接返回 #AARRGGBB 格式
    return '#${hexColor.toUpperCase()}';
  }
}
