# 阿里云号码认证插件

## 官方文档

- [android官方文档](https://help.aliyun.com/zh/pnvs/developer-reference/the-android-client-access)
- [ios官方文档](https://help.aliyun.com/zh/pnvs/developer-reference/the-ios-client-access)

- 插件仅连接原生 sdk 的方法和参数，包含 UI 配置（自定义 UI 还未实现完整）
- 一键登录和预取号码流程，请参数官方文档

## 配置

### android 配置  `android/app/src/main/AndroidManifest.xml`

添加 http 支持配置

```xml
<!--如果有配置其他 networkSecurityConfig 请添加行替换  或者复制 number_auth_network_security_config 中的添加至自己的 xml-->
<application
        android:networkSecurityConfig="@xml/number_auth_network_security_config"
        android:requestLegacyExternalStorage="true"
        tools:replace="android:networkSecurityConfig">
</application>
```

## 使用

```dart
/// 设置SDK密钥
void setAuthInfo() async {
  final result = await FlAliYunNumberAuth()
      .setAuthInfo(android: androidAuthInfo, ios: iosAuthInfo);
}

/// 设置授权页UI
/// 所有 UI 单位均为 px 参考 example 转换为 px
void setAuthUI() async {
  final result = await FlAliYunNumberAuth()
      .setAuthUI(android: buildAndroidUi(context), ios: buildIOSUi(context));
}

/// SDK环境检查函数，检查终端是否支持号码认证
void checkEnvAvailable() async {
  final result = await FlAliYunNumberAuth().checkEnvAvailable(AuthType.login);
}

/// 一键登录预取号
void accelerateLoginPage() async {
  final result = await FlAliYunNumberAuth().accelerateLoginPage();
}

/// 一键登录获取Token
void getLoginToken() async {
  final result = await FlAliYunNumberAuth().getLoginToken();
}

/// 退出登录页面
/// code600024 时调用
void quitLoginPage() async {
  final result = await FlAliYunNumberAuth().quitLoginPage();
  setResultText = 'quitLoginPage:$result';
}

/// 结束授权页loading动画
void hideLoginLoading() async {
  final result = await FlAliYunNumberAuth().hideLoginLoading();
}

/// 二次授权弹窗取消事件
void quitPrivacyAlert() async {
  final result = await FlAliYunNumberAuth().quitPrivacyAlert();
}

/// 设置授权页协议框是否勾选
void setCheckboxIsChecked() async {
  final result =
  await FlAliYunNumberAuth().setCheckboxIsChecked(Random().nextBool());
}

/// 获取授权页协议勾选框选中状态
/// true 选中 false 未选中 null 未初始化
void queryCheckBoxIsChecked() async {
  final result = await FlAliYunNumberAuth().queryCheckBoxIsChecked();
}

/// 获取上网卡运营商 CMCC(中国移动)、CUCC(中国联通)、CTCC(中国电信)
void getCurrentCarrierName() async {
  final result = await FlAliYunNumberAuth().getCurrentCarrierName();
}

/// 授权页协议内容动画执行，注意：必须设置privacyAnimation属性，才会执行动画
void privacyAnimationStart() async {
  final result = await FlAliYunNumberAuth().privacyAnimationStart();
}

/// 授权页checkbox动画执行，注意：必须设置checkboxAnimation属性，才会执行动画
void checkBoxAnimationStart() async {
  final result = await FlAliYunNumberAuth().checkBoxAnimationStart();
}

/// 获取sdk 版本号
void getVersion() async {
  final result = await FlAliYunNumberAuth().getVersion();
}

/// ios 特有方法
void iosMethod() async {
  final result = await FlAliYunNumberAuth().iosMethod();
}

/// android 特有方法
void androidMethod() async {
  final result = await FlAliYunNumberAuth().androidMethod();
}

```

