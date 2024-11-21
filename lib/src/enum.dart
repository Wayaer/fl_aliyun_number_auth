enum AuthType {
  /// 本机号码校验
  auth,

  /// 一键登录
  login
}

/// **** 以下为 android 特有 ****
enum Typeface { sansSerif, serif, monospace }

enum SystemUiFlag {
  /// View.SYSTEM_UI_FLAG_LOW_PROFILE：非全屏显示状态，状态栏的部分图标会被隐藏。
  lowProfile,

  /// View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN：全屏显示。
  layoutFullscreen,
}

enum Gravity {
  /// start = left
  start,
  center,

  /// end = right
  end,
  top,
  bottom,
  centerHorizontal,
  centerVertical,
}

enum ImageScaleType {
  /// 不改变原图的大小，从ImageView左上角绘制原图，超过部分裁剪处理。
  matrix,

  /// 原图按照指定的大小在View中显示，拉伸显示图片，不保持原比例，填满ImageView。
  fitXy,

  /// 原图按比例扩大或缩小到ImageView的高度，显示在ImageView的上部分位置。
  fitStart,

  /// 原图按比例扩大或缩小到ImageView的ImageView的高度，居中显示。
  fitCenter,

  /// 原图按比例扩大或缩小到ImageView的高度，显示在ImageView的下部分位置。
  fitEnd,

  /// 保持原图大小，显示在ImageView的中心。当原图的size大于ImageView的size，超过部分裁剪处理。
  center,

  /// 原图的中心对准ImageView的中心，等比例放大原图，直到填满ImageView为止，对原图超过ImageView的部分做裁剪处理。
  centerCrop,

  /// 图片居中显示，按比例缩小原图的size等于或小于ImageView。如果原图的size本身就小于ImageView的size，则原图的size不做任何处理，居中显示在ImageView。
  centerInside,
}

enum PageOrientation {
  /// 传感器
  sensor,

  /// 不指定
  unspecified,

  /// 竖屏
  portrait,

  /// 横屏
  landscape,
}

/// **** 以下为 ios 特有 ****
enum UIStatusBarStyle {
  /// 默认
  defaultStyle(0),

  /// 白色
  lightContent(1),

  /// 黑色
  darkContent(3);

  const UIStatusBarStyle(this.value);

  final int value;
}

enum UIViewContentMode {
  scaleToFill,
  scaleAspectFit,
  scaleAspectFill,
  redraw,
  center,
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

enum NSTextAlignment { left, center, right, justified, natural }

enum PNSPresentationDirection { bottom, right, top, left }

enum UIInterfaceOrientationMask{
  portrait,
  landscapeLeft,
  landscapeRight,
  portraitUpsideDown,
  landscape,
  all,
  allButUpsideDown
}
