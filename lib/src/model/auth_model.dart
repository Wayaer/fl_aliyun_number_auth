import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

typedef ActivityResultCallbackForAndroid = void Function(
    int requestCode, int resultCode, dynamic data);

typedef AuthUIClickCallbackForAndroid = void Function(
    String? code, String? jsonString);

typedef LoggerHandlerForAndroid = void Function(String level, String msg);

class AuthUIModelForAndroid {
  /// 配置授权页状态栏
  final StatusBarUIModelForAndroid? statusBarUi;

  /// 配置授权页导航栏
  final NavUIModelForAndroid? navUi;

  /// 配置授权页Logo
  final LogoUIModelForAndroid? logoUi;

  /// 配置授权页Slogan
  final SloganUIModelForAndroid? sloganUi;

  /// 配置授权页号码栏
  final NumberUIModelForAndroid? numberUi;

  /// 配置授权页登录按钮
  final LoginBtnUIModelForAndroid? loginBtnUi;

  /// 配置授权页隐私栏
  final PrivacyUIModelForAndroid? privacyUi;

  /// 配置切换控件方式
  final SwitchUIModelForAndroid? switchUi;

  /// 配置页面相关函数
  final PageUIModelForAndroid? pageUi;

  /// 二次隐私协议弹窗页面
  final PrivacyAlertUIModelForAndroid? privacyAlertUi;

  /// onActivityResult
  final ActivityResultCallbackForAndroid? onActivityResult;

  /// 授权页UI点击回调
  final AuthUIClickCallbackForAndroid? onAuthUIClick;

  /// logger handler
  final LoggerHandlerForAndroid? onLogger;

  const AuthUIModelForAndroid({
    this.statusBarUi,
    this.navUi,
    this.logoUi,
    this.sloganUi,
    this.numberUi,
    this.privacyUi,
    this.loginBtnUi,
    this.switchUi,
    this.pageUi,
    this.privacyAlertUi,
    this.onActivityResult,
    this.onAuthUIClick,
    this.onLogger,
  });

  Map<String, dynamic> toMap() => {
        'statusBarUi': statusBarUi?.toMap(),
        'navUi': navUi?.toMap(),
        'logoUi': logoUi?.toMap(),
        'sloganUi': sloganUi?.toMap(),
        'numberUi': numberUi?.toMap(),
        'privacyUi': privacyUi?.toMap(),
        'loginBtnUi': loginBtnUi?.toMap(),
        'switchUi': switchUi?.toMap(),
        'pageUi': pageUi?.toMap(),
        'privacyAlertUi': privacyAlertUi?.toMap(),
      };

  void onActivityResultHandler(Map<String, dynamic> args) {
    onActivityResult?.call(args['requestCode'] as int,
        args['resultCode'] as int, args['data'] as dynamic);
  }

  void onAuthUIClickHandler(Map<String, dynamic> args) {
    onAuthUIClick?.call(args['code'] as String?, args['json'] as String?);
  }

  void onLoggerHandler(Map<String, dynamic> args) {
    onLogger?.call(args['level'] as String, args['msg'] as String);
  }
}

class AuthUIModelForIOS {
  /// 配置授权页状态栏
  final StatusBarUIModelForIOS? statusBarUi;

  /// 配置授权页导航栏
  final NavUIModelForIOS? navUi;

  /// 配置授权页Logo
  final LogoUIModelForIOS? logoUi;

  /// 配置授权页Slogan
  final SloganUIModelForIOS? sloganUi;

  /// 配置授权页号码栏
  final NumberUIModelForIOS? numberUi;

  /// 配置授权页登录按钮
  final LoginBtnUIModelForIOS? loginBtnUi;

  /// 配置授权页隐私栏
  final PrivacyUIModelForIOS? privacyUi;

  /// 配置切换控件方式
  final SwitchUIModelForIOS? switchUi;

  /// 配置页面相关函数
  final PageUIModelForIOS? pageUi;

  /// 二次隐私协议弹窗页面
  final PrivacyAlertUIModelForIOS? privacyAlertUi;

  const AuthUIModelForIOS({
    this.statusBarUi,
    this.navUi,
    this.logoUi,
    this.sloganUi,
    this.numberUi,
    this.privacyUi,
    this.loginBtnUi,
    this.switchUi,
    this.pageUi,
    this.privacyAlertUi,
  });

  Map<String, dynamic> toMap() => {
        'statusBarUi': statusBarUi?.toMap(),
        'navUi': navUi?.toMap(),
        'logoUi': logoUi?.toMap(),
        'sloganUi': sloganUi?.toMap(),
        'numberUi': numberUi?.toMap(),
        'privacyUi': privacyUi?.toMap(),
        'loginBtnUi': loginBtnUi?.toMap(),
        'switchUi': switchUi?.toMap(),
        'pageUi': pageUi?.toMap(),
        'privacyAlertUi': privacyAlertUi?.toMap(),
      };

  void onViewFrameBlock(Map<String, dynamic> args) {}
}

class AuthResultModel {
  /// result code
  final String? resultCode;

  /// result msg
  final String? msg;

  /// 仅在android返回
  final bool? isFailed;

  AuthResultModel.fromMap(Map<String, dynamic> map)
      : resultCode = map['resultCode'] as String?,
        msg = map['msg'] as String?,
        isFailed = map['isFailed'] as bool?;
}
