class AuthInfo {
  final AuthInfoForAndroid android;
  final AuthInfoForIOS ios;

  AuthInfo({required this.android, required this.ios});

  Map<String, dynamic> toMap() => {...android.toMap(), ...ios.toMap()};
}

class AuthInfoForAndroid {
  /// 启用 授权页返回监听
  final bool enableActivityResultListener;

  /// 启用授权页UI控件点击监听
  final bool enableAuthUIControlClickListener;

  /// 启用日志
  final bool enableLogger;

  /// 上传日志
  final bool enableUploadLogger;

  /// 启用自定义日志处理器
  final bool enableLoggerHandler;

  /// 密钥
  final String secret;

  AuthInfoForAndroid(
      {this.enableActivityResultListener = false,
      this.enableAuthUIControlClickListener = false,
      this.enableLogger = false,
      this.enableUploadLogger = false,
      this.enableLoggerHandler = false,
      required this.secret});

  Map<String, dynamic> toMap() => {
        'enableActivityResultListener': enableActivityResultListener,
        'enableAuthUIControlClickListener': enableAuthUIControlClickListener,
        'enableLogger': enableLogger,
        'enableUploadLogger': enableUploadLogger,
        'enableLoggerHandler': enableLoggerHandler,
        'secret': secret
      };
}

class AuthInfoForIOS {
  /// 密钥
  final String secret;

  AuthInfoForIOS({required this.secret});

  Map<String, dynamic> toMap() => {'secret': secret};
}
