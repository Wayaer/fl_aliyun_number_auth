import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

class AuthUiForAndroidModel {
  /// 配置授权页状态栏
  final StatusBarUiModelForAndroid? statusBarUi;

  /// 配置授权页导航栏
  final NavUiModelForAndroid? navUi;

  /// 配置授权页Logo
  final LogoUiModelForAndroid? logoUi;

  /// 配置授权页Slogan
  final SloganUiModelForAndroid? sloganUi;

  /// 配置授权页号码栏
  final NumberUiModelForAndroid? numberUi;

  /// 配置授权页登录按钮
  final LoginBtnUiModelForAndroid? loginBtnUi;

  /// 配置授权页隐私栏
  final PrivacyUiModelForAndroid? privacyUi;

  /// 配置切换控件方式
  final SwitchUiModelForAndroid? switchUi;

  /// 配置页面相关函数
  final PageUiModelForAndroid? pageUi;

  /// 二次隐私协议弹窗页面
  final PrivacyAlertUiModelForAndroid? privacyAlertUi;

  AuthUiForAndroidModel({
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
}

class AuthUiForIOSModel {
  /// 配置授权页状态栏
  final StatusBarUiModelForIOS? statusBarUi;

  /// 配置授权页导航栏
  final NavUiModelForIOS? navUi;

  /// 配置授权页Logo
  final LogoUiModelForIOS? logoUi;

  /// 配置授权页Slogan
  final SloganUiModelForIOS? sloganUi;

  /// 配置授权页号码栏
  final NumberUiModelForIOS? numberUi;

  /// 配置授权页登录按钮
  final LoginBtnUiModelForIOS? loginBtnUi;

  /// 配置授权页隐私栏
  final PrivacyUiModelForIOS? privacyUi;

  /// 配置切换控件方式
  final SwitchUiModelForIOS? switchUi;

  /// 配置页面相关函数
  final PageUiModelForIOS? pageUi;

  /// 二次隐私协议弹窗页面
  final PrivacyAlertUiModelForIOS? privacyAlertUi;

  AuthUiForIOSModel({
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
}
