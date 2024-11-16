import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum AuthServiceType { auth, login }

class FlAliYunNumberAuth {
  const FlAliYunNumberAuth._();

  static const MethodChannel _channel = MethodChannel('fl_aliyun_number_auth');

  static bool _isInit = false;

  /// 初始化设置
  static Future<bool> setAuthInfo(AuthInfo authInfo) async {
    if (_isAndroid || _isIOS) {
      final result =
          await _channel.invokeMethod<bool>('setAuthSDKInfo', authInfo.toMap());
      if (result == true) _isInit = true;
      return result ?? false;
    }
    return false;
  }

  /// 设置监听器
  static void setHandler() {
    _channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        default:
      }
    });
  }

  /// SDK环境检查函数，检查终端是否支持号码认证，带返回code的
  static Future<bool> checkEnvAvailable(AuthServiceType type) async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>(
              'checkEnvAvailable', {'serviceType': type.index}) ??
          false;
    }
    return false;
  }

  static Future<bool> setAuthUIConfig(AuthUiModel model) async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>(
              'setAuthUIConfig', model.toMap()) ??
          false;
    }
    return false;
  }

  /// 设置授权页协议框是否勾选
  static Future<bool> setProtocolChecked(bool isCheck) async {
    if (_isInit) {
      return await _channel
              .invokeMethod<bool>('setProtocolChecked', {'isCheck': isCheck}) ??
          false;
    }
    return false;
  }

  /// 获取授权页协议勾选框选中状态
  /// true 选中 false 未选中 null 未初始化
  static Future<bool?> queryCheckBoxIsChecked(bool isCheck) async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('queryCheckBoxIsChecked');
    }
    return null;
  }

  /// 授权页是否跟随系统深色模式
  static Future<bool> setAuthPageUseDayLight(bool authPageUseDayLight) async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('setAuthPageUseDayLight',
              {'authPageUseDayLight': authPageUseDayLight}) ??
          false;
    }
    return false;
  }

  /// 授权页物理返回键禁用
  static Future<bool> closeAuthPageReturnBack(bool close) async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>(
              'closeAuthPageReturnBack', {'close': close}) ??
          false;
    }
    return false;
  }

  /// 横屏水滴屏全屏适配
  static Future<bool> keepAuthPageLandscapeFullScreen(bool fullScreen) async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>(
              'keepAuthPageLandscapeFullScreen', {'fullScreen': fullScreen}) ??
          false;
    }
    return false;
  }

  /// 删除预取号码信息
  static Future<bool> clearPreInfo() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('clearPreInfo') ?? false;
    }
    return false;
  }

  /// 获取上网卡运营商 CMCC(中国移动)、CUCC(中国联通)、CTCC(中国电信)
  static Future<String?> getCurrentCarrierName() async {
    if (_isInit) {
      return await _channel.invokeMethod<String>('getCurrentCarrierName');
    }
    return null;
  }

  /// 用户控制返回键及左上角返回按钮效果
  /// 调用此方法后用户在setUIClickListener方法中收到ResultCode.CODE_ERROR_USER_CANCEL回调后控制授权页关闭逻辑
  static Future<bool> userControlAuthPageCancel() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('userControlAuthPageCancel') ??
          false;
    }
    return false;
  }

  /// 用户禁止使用utdid
  /// 调用该方法后移除相关utdid的使用。
  static Future<bool> prohibitUseUtdid() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('prohibitUseUtdid') ?? false;
    }
    return false;
  }

  /// 授权页是否扩大协议按钮选择范围至我已阅读并同意
  static Future<bool> expandAuthPageCheckedScope(Duration expand) async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>(
              'expandAuthPageCheckedScope', {'expand': expand}) ??
          false;
    }
    return false;
  }

  /// 一键登录获取Token
  /// 获取登录Token 调起一键登录授权页面，在用户授权后获取一键登录的Token
  /// timeout 接口超时时间 默认10s
  static Future<String?> getLoginToken(
      {Duration timeout = const Duration(seconds: 10)}) async {
    if (_isInit) {
      return await _channel.invokeMethod<String>(
          'getLoginToken', {'timeout': timeout.inMilliseconds});
    }
    return null;
  }

  /// 注销登录页面
  static Future<bool> quitLoginPage() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('quitLoginPage') ?? false;
    }
    return false;
  }

  /// 结束授权页loading动画
  static Future<bool> hideLoginLoading() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('hideLoginLoading') ?? false;
    }
    return false;
  }

  /// 加速拉起授权页
  static Future<bool> accelerateLoginPage(
      {Duration timeout = const Duration(seconds: 10)}) async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>(
              'accelerateLoginPage', {'timeout': timeout.inMilliseconds}) ??
          false;
    }
    return false;
  }

  /// 获取版本号
  static Future<String?> getVersion() async {
    if (_isInit) {
      return await _channel.invokeMethod<String>('getVersion');
    }
    return null;
  }

  /// addAuthRegisterViewConfig
  /// 动态添加控件
  static Future<bool> addAuthRegisterViewConfig() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('addAuthRegisterViewConfig') ??
          false;
    }
    return false;
  }

  /// 移除所有动态添加的控件
  /// 在调用addAuthRegisterViewConfig之前调用removeAuthRegisterViewConfig先移除所有动态添加的控件
  static Future<bool> removeAuthRegisterViewConfig() async {
    if (_isInit) {
      return await _channel
              .invokeMethod<bool>('removeAuthRegisterViewConfig') ??
          false;
    }
    return false;
  }

  /// 添加自定义布局
  static Future<bool> addAuthRegisterXmlConfig() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('addAuthRegisterXmlConfig') ??
          false;
    }
    return false;
  }

  /// 移除所有添加的自定义布局
  static Future<bool> removeAuthRegisterXmlConfig() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('removeAuthRegisterXmlConfig') ??
          false;
    }
    return false;
  }

  /// 添加自定义布局
  static Future<bool> addPrivacyRegisterXmlConfig() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('addPrivacyRegisterXmlConfig') ??
          false;
    }
    return false;
  }

  /// 移除所有添加的自定义布局
  static Future<bool> removePrivacyRegisterXmlConfig() async {
    if (_isInit) {
      return await _channel
              .invokeMethod<bool>('removePrivacyRegisterXmlConfig') ??
          false;
    }
    return false;
  }

  /// 二次弹窗取消事件
  static Future<bool> quitPrivacyPage() async {
    if (_isInit) {
      return await _channel.invokeMethod<bool>('quitPrivacyPage') ?? false;
    }
    return false;
  }

  /// 二次弹窗动态添加控件
  static Future<bool> addPrivacyAuthRegisterViewConfig() async {
    if (_isInit) {
      return await _channel
              .invokeMethod<bool>('addPrivacyAuthRegisterViewConfig') ??
          false;
    }
    return false;
  }

  /// 移除所有动态添加的控件
  /// 在调用addPrivacyAuthRegistViewConfig之前调用removePrivacyAuthRegisterViewConfig先移除所有动态添加的控件。
  static Future<bool> removePrivacyAuthRegisterViewConfig() async {
    if (_isInit) {
      return await _channel
              .invokeMethod<bool>('removePrivacyAuthRegisterViewConfig') ??
          false;
    }
    return false;
  }
}

bool _isAndroid = defaultTargetPlatform == TargetPlatform.android;

bool _isIOS = defaultTargetPlatform == TargetPlatform.iOS;
