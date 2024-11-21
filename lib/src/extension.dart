import 'package:flutter/material.dart';

extension ExtensionRect on Rect {
  Map<String, dynamic> toMap() =>
      {'x': left, 'y': top, 'width': width, 'height': height};
}

extension ExtensionOffset on Offset {
  Map<String, dynamic> toMap() => {'x': dx, 'y': dy};
}
