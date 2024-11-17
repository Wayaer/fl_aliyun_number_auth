class AuthInfo {
  /// android 配置信息
  final AuthInfoForAndroid android;

  /// ios 配置信息
  final AuthInfoForIOS ios;

  AuthInfo({required this.android, required this.ios});

  Map<String, dynamic> toMap() => {...android.toMap(), ...ios.toMap()};
}

class AuthInfoForAndroid {
  /// 启用 授权页返回监听
  /// 仅支持android
  final bool enableActivityResultListener;

  /// 启用授权页UI控件点击监听
  final bool enableAuthUIControlClickListener;

  /// 密钥
  final String secret;

  AuthInfoForAndroid(
      {this.enableActivityResultListener = false,
      this.enableAuthUIControlClickListener = false,
      required this.secret});

  Map<String, dynamic> toMap() => {
        'enableActivityResultListener': enableActivityResultListener,
        'enableAuthUIControlClickListener': enableAuthUIControlClickListener,
        'secret': secret
      };
}

class AuthInfoForIOS {
  /// 密钥
  final String secret;

  AuthInfoForIOS({required this.secret});

  Map<String, dynamic> toMap() => {'secret': secret};
}

/// 日志配置
class LoggerModel {
  /// 启用日志
  final bool enable;

  /// 上传日志
  final bool enableUpload;

  /// 启用自定义日志处理器
  /// 仅支持android
  final bool enableHandler;

  LoggerModel({
    this.enable = true,
    this.enableUpload = false,
    this.enableHandler = false,
  });

  Map<String, dynamic> toMap() => {
        'enable': enable,
        'enableUpload': enableUpload,
        'enableHandler': enableHandler,
      };
}
