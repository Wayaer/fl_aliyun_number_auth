import 'dart:async';

import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('fl_aliyun_number_auth');

typedef AuthResultCallback = void Function(AuthResultModel? result);

class FlAliYunNumberAuth {
  factory FlAliYunNumberAuth() => _singleton ??= FlAliYunNumberAuth._();

  static FlAliYunNumberAuth? _singleton;

  FlAliYunNumberAuth._() {
    _setMethodCallHandler();
  }

  /// ios 端特有方法
  FlAliYunNumberAuthForIOS get iosMethod => FlAliYunNumberAuthForIOS();

  /// android 端特有方法
  FlAliYunNumberAuthForAndroid get androidMethod =>
      FlAliYunNumberAuthForAndroid();

  /// 结果回调监听
  AuthResultCallback? _authResultCallback;

  /// 添加结果回调
  addCallback(AuthResultCallback callback) {
    _authResultCallback = callback;
  }

  /// 移除结果回调
  removeCallback() {
    _authResultCallback = null;
  }

  /// 初始化设置
  Future<AuthResultModel?> setAuthInfo({
    required AuthInfoForAndroid android,
    required AuthInfoForIOS ios,
  }) async {
    if (!_supported) return null;
    final result =
        await _channel.invokeMethod<Map<dynamic, dynamic>>('setAuthSDKInfo', {
      if (_isAndroid) ...android.toMap(),
      if (_isIOS) ...ios.toMap(),
    });
    if (result == null) return null;
    return AuthResultModel.fromMap(result);
  }

  /// 日志设置
  Future<bool?> setLoggerInfo(LoggerModel logger) async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>('setLoggerInfo', logger.toMap());
  }

  /// 一键登录获取Token
  /// 获取登录Token 调起一键登录授权页面，在用户授权后获取一键登录的Token
  /// timeout 接口超时时间 默认10s
  /// [authResultCallback] 返回结果回调
  Future<bool?> getLoginToken({
    Duration timeout = const Duration(seconds: 10),

    /// ios 模拟环境
    bool isDebug = false,
  }) async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>('getLoginToken',
        {'timeout': timeout.inMilliseconds, 'isDebug': isDebug});
  }

  /// 加速拉起授权页
  /// [authResultCallback] 返回结果回调
  Future<bool?> accelerateLoginPage(
      {Duration timeout = const Duration(seconds: 10)}) async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>(
        'accelerateLoginPage', timeout.inMilliseconds);
  }

  /// SDK环境检查函数，检查终端是否支持号码认证，带返回code的
  /// [authResultCallback] 返回结果回调
  Future<bool?> checkEnvAvailable(AuthType type) async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>(
        'checkEnvAvailable', type.index + 1);
  }

  /// 注销登录页面
  Future<bool?> quitLoginPage({
    /// 仅支持ios
    bool animated = true,
  }) async {
    if (!_supported) return null;
    return await _channel
        .invokeMethod<bool>('quitLoginPage', {'animated': animated});
  }

  /// 获取版本号
  Future<String?> getVersion() async {
    if (!_supported) return null;
    return await _channel.invokeMethod<String>('getVersion');
  }

  /// 设置授权页协议框是否勾选
  Future<bool?> setCheckboxIsChecked(bool isCheck) async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>('setCheckboxIsChecked', isCheck);
  }

  /// 获取授权页协议勾选框选中状态
  /// true 选中 false 未选中 null 未初始化
  Future<bool?> queryCheckBoxIsChecked() async {
    return await _channel.invokeMethod<bool>('queryCheckBoxIsChecked');
  }

  /// 结束授权页loading动画
  Future<bool?> hideLoginLoading() async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>('hideLoginLoading');
  }

  /// 获取上网卡运营商 CMCC(中国移动)、CUCC(中国联通)、CTCC(中国电信)
  Future<String?> getCurrentCarrierName() async {
    if (!_supported) return null;
    return await _channel.invokeMethod<String>('getCurrentCarrierName');
  }

  /// 二次弹窗取消事件
  Future<bool?> quitPrivacyAlert() async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>('quitPrivacyAlert');
  }

  AuthUIModelForAndroid? _androidAuthUi;

  AuthUIModelForAndroid? get androidAuthUi => _androidAuthUi;

  AuthUIModelForIOS? _iosAuthUi;

  AuthUIModelForIOS? get iosAuthUi => _iosAuthUi;

  /// 设置授权页UI
  Future<bool?> setAuthUI({
    /// android 授权页配置
    AuthUIModelForAndroid? android,

    /// ios 授权页配置
    AuthUIModelForIOS? ios,
  }) async {
    if (!_supported) return null;
    _androidAuthUi = android;
    _iosAuthUi = ios;
    return await _channel.invokeMethod<bool>('setAuthUI', {
      if (_isAndroid && android != null) ...android.toMap(),
      if (_isIOS && ios != null) ...ios.toMap(),
    });
  }

  /// 设置监听器
  void _setMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'onAuthResult':
          AuthResultModel? model;
          try {
            model = AuthResultModel.fromMap(
                call.arguments as Map<dynamic, dynamic>);
          } catch (e) {
            debugPrint("AuthResultCallback : $e");
          }
          _authResultCallback?.call(model);
          break;
        case 'onViewFrameBlock':
          _iosAuthUi?.onViewFrameBlock(call.arguments as Map<dynamic, dynamic>);
          break;
        case 'onActivityResult':
          _androidAuthUi?.onActivityResultHandler(
              call.arguments as Map<dynamic, dynamic>);
          break;
        case 'onAuthUIClick':
          _androidAuthUi
              ?.onAuthUIClickHandler(call.arguments as Map<dynamic, dynamic>);
          break;
        case 'onLoggerHandler':
          _androidAuthUi
              ?.onLoggerHandler(call.arguments as Map<dynamic, dynamic>);
          break;
        default:
      }
    });
  }

  /// 授权页协议内容动画执行，注意：必须设置privacyAnimation属性，才会执行动画
  Future<bool?> privacyAnimationStart() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<bool>('privacyAnimationStart');
  }

  /// 授权页checkbox动画执行，注意：必须设置checkboxAnimation属性，才会执行动画
  Future<bool?> checkBoxAnimationStart() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<bool>('checkBoxAnimationStart');
  }
}

bool _supported = _isAndroid || _isIOS;

bool _isAndroid = defaultTargetPlatform == TargetPlatform.android;

bool _isIOS = defaultTargetPlatform == TargetPlatform.iOS;

class FlAliYunNumberAuthForIOS {
  factory FlAliYunNumberAuthForIOS() =>
      _singleton ??= FlAliYunNumberAuthForIOS._();

  FlAliYunNumberAuthForIOS._();

  static FlAliYunNumberAuthForIOS? _singleton;

  /// 判断当前设备蜂窝数据网络是否开启，即3G/4G
  Future<String?> checkDeviceCellularDataEnable() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<String>('checkDeviceCellularDataEnable');
  }

  /// 判断当前上网卡运营商是否是中国联通
  Future<bool?> isChinaUnicom() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<bool>('isChinaUnicom');
  }

  /// 判断当前上网卡运营商是否是中国移动
  Future<bool?> isChinaMobile() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<bool>('isChinaMobile');
  }

  /// 判断当前上网卡运营商是否是中国电信
  Future<bool?> isChinaTelecom() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<bool>('isChinaTelecom');
  }

  /// 获取当前上网卡网络类型，比如WiFi，4G
  Future<String?> getNetworkType() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<String>('getNetworkType');
  }

  ///  判断wwan是否开着（通过p0网卡判断，无wifi或有wifi情况下都能检测到）
  Future<bool?> isWWANOpen() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<bool>('isWWANOpen');
  }

  ///  判断wwan是否开着（仅无wifi情况下））
  Future<bool?> reachableViaWWAN() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<bool>('reachableViaWWAN');
  }

  ///  获取设备当前网络私网IP地址
  Future<String?> getMobilePrivateIPAddress(bool preferIPv4) async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<String>(
        'getMobilePrivateIPAddress', preferIPv4);
  }

  /// 获取当前设备的唯一标识ID
  Future<String?> getUniqueID() async {
    if (!_isIOS) return null;
    return await _channel.invokeMethod<String>('getUniqueID');
  }
}

class FlAliYunNumberAuthForAndroid {
  factory FlAliYunNumberAuthForAndroid() =>
      _singleton ??= FlAliYunNumberAuthForAndroid._();

  FlAliYunNumberAuthForAndroid._();

  static FlAliYunNumberAuthForAndroid? _singleton;

  /// 加速拉起 Verify
  /// [authResultCallback] 返回结果回调
  Future<bool?> accelerateVerify(
      {Duration timeout = const Duration(seconds: 10)}) async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>(
        'accelerateVerify', timeout.inMilliseconds);
  }

  /// getVerifyToken
  /// timeout 接口超时时间 默认10s
  /// [authResultCallback] 返回结果回调
  Future<bool?> getVerifyToken(
      {Duration timeout = const Duration(seconds: 10)}) async {
    if (!_supported) return null;
    return await _channel.invokeMethod<bool>(
        'getVerifyToken', timeout.inMilliseconds);
  }

  /// 授权页隐藏导航栏
  Future<bool?> keepAllPageHideNavigationBar() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('keepAllPageHideNavigationBar');
  }

  /// 授权页是否跟随系统深色模式
  Future<bool?> setAuthPageUseDayLight(bool authPageUseDayLight) async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>(
        'setAuthPageUseDayLight', authPageUseDayLight);
  }

  /// 授权页物理返回键禁用
  Future<bool?> closeAuthPageReturnBack(bool close) async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('closeAuthPageReturnBack', close);
  }

  /// 横屏水滴屏全屏适配
  Future<bool?> keepAuthPageLandscapeFullScreen(bool fullScreen) async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>(
        'keepAuthPageLandscapeFullScreen', fullScreen);
  }

  /// 删除预取号码信息
  Future<bool?> clearPreInfo() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('clearPreInfo');
  }

  /// 用户控制返回键及左上角返回按钮效果
  /// 调用此方法后用户在setUIClickListener方法中收到ResultCode.CODE_ERROR_USER_CANCEL回调后控制授权页关闭逻辑
  Future<bool?> userControlAuthPageCancel() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('userControlAuthPageCancel');
  }

  /// 用户禁止使用utdid
  /// 调用该方法后移除相关utdid的使用。
  Future<bool?> prohibitUseUtdid() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('prohibitUseUtdid');
  }

  /// 授权页是否扩大协议按钮选择范围至我已阅读并同意
  Future<bool?> expandAuthPageCheckedScope(Duration expand) async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>(
        'expandAuthPageCheckedScope', expand);
  }

  /// addAuthRegisterViewConfig
  /// 动态添加控件
  Future<bool?> addAuthRegisterViewConfig() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('addAuthRegisterViewConfig');
  }

  /// 移除所有动态添加的控件
  /// 在调用addAuthRegisterViewConfig之前调用removeAuthRegisterViewConfig先移除所有动态添加的控件
  Future<bool?> removeAuthRegisterViewConfig() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('removeAuthRegisterViewConfig');
  }

  /// 添加自定义布局
  Future<bool?> addAuthRegisterXmlConfig() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('addAuthRegisterXmlConfig');
  }

  /// 移除所有添加的自定义布局
  Future<bool?> removeAuthRegisterXmlConfig() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('removeAuthRegisterXmlConfig');
  }

  /// 添加自定义布局
  Future<bool?> addPrivacyRegisterXmlConfig() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('addPrivacyRegisterXmlConfig');
  }

  /// 移除所有添加的自定义布局
  Future<bool?> removePrivacyRegisterXmlConfig() async {
    if (!_isAndroid) return null;
    return await _channel.invokeMethod<bool>('removePrivacyRegisterXmlConfig');
  }

  /// 二次弹窗动态添加控件
  Future<bool?> addPrivacyAuthRegisterViewConfig() async {
    if (!_isAndroid) return null;
    return await _channel
        .invokeMethod<bool>('addPrivacyAuthRegisterViewConfig');
  }

  /// 移除所有动态添加的控件
  /// 在调用addPrivacyAuthRegistViewConfig之前调用removePrivacyAuthRegisterViewConfig先移除所有动态添加的控件。
  Future<bool?> removePrivacyAuthRegisterViewConfig() async {
    if (!_isAndroid) return null;
    return await _channel
        .invokeMethod<bool>('removePrivacyAuthRegisterViewConfig');
  }
}
