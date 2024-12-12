import 'package:flutter/material.dart';

extension ExtensionRect on Rect {
  Map<String, dynamic> toMap() =>
      {'x': left, 'y': top, 'width': width, 'height': height};
}

extension ExtensionSize on Size {
  Map<String, dynamic> toMap() => {'width': width, 'height': height};
}

extension ExtensionOffset on Offset {
  Map<String, dynamic> toMap() => {'x': dx, 'y': dy};
}

extension ExtensionColor on Color {
  Map<String, dynamic> toMap() => {
        'a': a,
        'r': r,
        'g': g,
        'b': b,
        'colorSpace': [0, 2, 7][colorSpace.index],
      };
}
