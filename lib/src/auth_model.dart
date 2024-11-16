import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';

class AuthUiModel {
  final AuthUiForAndroidModel android;
  final AuthUiForIOSModel ios;

  AuthUiModel({required this.android, required this.ios});

  Map<String, dynamic> toMap() => {...android.toMap(), ...ios.toMap()};
}

class AuthUiForAndroidModel {
  /// 配置授权页导航栏
  final NavUiModel? navUi;

  /// 配置授权页Logo
  final LogoUiModel? logoUi;

  /// 配置授权页Slogan
  final SloganUiModel? sloganUi;

  /// 配置授权页号码栏
  final NumberUiModel? numberUi;

  /// 配置授权页登录按钮
  final LoginBtnUiModel? loginBtnUi;

  /// 配置授权页隐私栏
  final PrivacyUiModel? privacyUi;

  /// 配置切换控件方式
  final SwitchUiModel? switchUi;

  /// 配置页面相关函数
  final PageUiModel? pageUi;

  /// 二次隐私协议弹窗页面
  final PrivacyAlertUiModel? privacyAlertUi;

  AuthUiForAndroidModel({
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
  Map<String, dynamic> toMap() => {};
}
