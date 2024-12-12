import 'dart:math';

import 'package:example/src/android_ui.dart';
import 'package:example/src/ios_ui.dart';
import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: const Text('FlAliYunNumberAuth')),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: HomePage(),
            )));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const androidSecret = 'androidSecret';
const iosSecret = 'iosSecret';

class _HomePageState extends State<HomePage> {
  AuthInfoForAndroid androidAuthInfo = AuthInfoForAndroid(
      secret: androidSecret,
      enableActivityResultListener: true,
      enableAuthUIControlClickListener: true);
  AuthInfoForIOS iosAuthInfo = AuthInfoForIOS(secret: iosSecret);

  String resultText = "";

  @override
  void initState() {
    super.initState();

    /// 添加result 回调
    FlAliYunNumberAuth().addCallback((result) {
      setResultText = 'addCallback:${result?.toMap()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: double.infinity,
          height: 120,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8)),
          child: Text(resultText, textAlign: TextAlign.center)),
      SizedBox(height: 10),
      Expanded(
          child: SingleChildScrollView(
              child: Column(children: [
        Wrap(runSpacing: 12, spacing: 12, children: [
          ElevatedText('setAuthInfo', onPressed: setAuthInfo),
          ElevatedText('setAuthUI', onPressed: setAuthUI),
          ElevatedText('checkEnvAvailable', onPressed: checkEnvAvailable),
          ElevatedText('accelerateLoginPage', onPressed: accelerateLoginPage),
          ElevatedText('getLoginToken', onPressed: getLoginToken),
          ElevatedText('quitLoginPage', onPressed: quitLoginPage),
          ElevatedText('hideLoginLoading', onPressed: hideLoginLoading),
          ElevatedText('quitPrivacyAlert', onPressed: quitPrivacyAlert),
          ElevatedText('setCheckboxIsChecked', onPressed: setCheckboxIsChecked),
          ElevatedText('queryCheckBoxIsChecked',
              onPressed: queryCheckBoxIsChecked),
          ElevatedText('getCurrentCarrierName',
              onPressed: getCurrentCarrierName),
          ElevatedText('privacyAnimationStart',
              onPressed: privacyAnimationStart),
          ElevatedText('checkBoxAnimationStart',
              onPressed: checkBoxAnimationStart),
          ElevatedText('getVersion', onPressed: getVersion),
        ])
      ]))),
    ]);
  }

  void setAuthInfo() async {
    final result = await FlAliYunNumberAuth()
        .setAuthInfo(android: androidAuthInfo, ios: iosAuthInfo);
    setResultText = 'setAuthInfo:${result?.toMap()}';
  }

  void setAuthUI() async {
    final result = await FlAliYunNumberAuth().setAuthUI(
        android: buildAndroidDialogUi(context), ios: buildIOSDialogUi(context));
    setResultText = 'setAuthUI:$result';
  }

  void checkEnvAvailable() async {
    final result = await FlAliYunNumberAuth().checkEnvAvailable(AuthType.login);
    setResultText = 'checkEnvAvailable:$result';
  }

  void accelerateLoginPage() async {
    final result = await FlAliYunNumberAuth().accelerateLoginPage();
    setResultText = 'accelerateLoginPage:$result';
  }

  void getLoginToken() async {
    final result = await FlAliYunNumberAuth().getLoginToken();
    setResultText = 'getLoginToken:$result';
  }

  void quitLoginPage() async {
    final result = await FlAliYunNumberAuth().quitLoginPage();
    setResultText = 'quitLoginPage:$result';
  }

  void hideLoginLoading() async {
    final result = await FlAliYunNumberAuth().hideLoginLoading();
    setResultText = 'hideLoginLoading:$result';
  }

  void quitPrivacyAlert() async {
    final result = await FlAliYunNumberAuth().quitPrivacyAlert();
    setResultText = 'quitPrivacyAlert:$result';
  }

  void setCheckboxIsChecked() async {
    final result =
        await FlAliYunNumberAuth().setCheckboxIsChecked(Random().nextBool());
    setResultText = 'setCheckboxIsChecked:$result';
  }

  void queryCheckBoxIsChecked() async {
    final result = await FlAliYunNumberAuth().queryCheckBoxIsChecked();
    setResultText = 'queryCheckBoxIsChecked:$result';
  }

  void getCurrentCarrierName() async {
    final result = await FlAliYunNumberAuth().getCurrentCarrierName();
    setResultText = 'getCurrentCarrierName:$result';
  }

  void privacyAnimationStart() async {
    final result = await FlAliYunNumberAuth().privacyAnimationStart();
    setResultText = 'privacyAnimationStart:$result';
  }

  void checkBoxAnimationStart() async {
    final result = await FlAliYunNumberAuth().checkBoxAnimationStart();
    setResultText = 'checkBoxAnimationStart:$result';
  }

  void getVersion() async {
    final result = await FlAliYunNumberAuth().getVersion();
    setResultText = 'getVersion:$result';
  }

  set setResultText(String text) {
    resultText = text;
    log(resultText);
    setState(() {});
  }
}

void log(String? message) {
  debugPrint("FlAliYunNumberAuth:$message");
}

class ElevatedText extends StatelessWidget {
  const ElevatedText(this.text, {this.onPressed, super.key});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}

extension ExtensionInt on int {
  // 将 int 转换为 px
  int toPx(BuildContext context) =>
      (this * MediaQuery.of(context).devicePixelRatio).toInt();
}

extension ExtensionDouble on double {
  // 将 double 转换为 px
  double toPx(BuildContext context) =>
      this * MediaQuery.of(context).devicePixelRatio;
}
