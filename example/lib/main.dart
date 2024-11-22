import 'dart:math';

import 'package:example/config.dart';
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

class _HomePageState extends State<HomePage> {
  AuthInfo authInfo = AuthInfo(
      android: AuthInfoForAndroid(
          secret: androidSecret,
          enableActivityResultListener: true,
          enableAuthUIControlClickListener: true),
      ios: AuthInfoForIOS(secret: iosSecret));

  String resultText = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: double.infinity,
          height: 120,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
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
          ElevatedText('getLoginToken', onPressed: getLoginToken),
          ElevatedText('accelerateLoginPage', onPressed: accelerateLoginPage),
          ElevatedText('setCheckboxIsChecked', onPressed: setCheckboxIsChecked),
          ElevatedText('queryCheckBoxIsChecked',
              onPressed: queryCheckBoxIsChecked),
          ElevatedText('getCurrentCarrierName',
              onPressed: getCurrentCarrierName),
          ElevatedText('getVersion', onPressed: getVersion),
        ])
      ]))),
    ]);
  }

  void getCurrentCarrierName() async {
    final result = await FlAliYunNumberAuth.getCurrentCarrierName();
    setResultText = 'getCurrentCarrierName:$result';
  }

  void queryCheckBoxIsChecked() async {
    final result = await FlAliYunNumberAuth.queryCheckBoxIsChecked();
    setResultText = 'queryCheckBoxIsChecked:$result';
  }

  void setCheckboxIsChecked() async {
    final result =
        await FlAliYunNumberAuth.setCheckboxIsChecked(Random().nextBool());
    setResultText = 'setCheckboxIsChecked:$result';
  }

  void getVersion() async {
    final result = await FlAliYunNumberAuth.getVersion();
    setResultText = 'getVersion:$result';
  }

  void setAuthInfo() async {
    final result = await FlAliYunNumberAuth.setAuthInfo(authInfo);
    setResultText = 'setAuthInfo:${result?.toMap()}';
  }

  void checkEnvAvailable() async {
    final result = await FlAliYunNumberAuth.checkEnvAvailable(AuthType.login);
    setResultText = 'checkEnvAvailable:${result?.toMap()}';
  }

  void getLoginToken() async {
    final result = await FlAliYunNumberAuth.getLoginToken();
    setResultText = 'getLoginToken:${result?.toMap()}';
  }

  void accelerateLoginPage() async {
    final result = await FlAliYunNumberAuth.accelerateLoginPage();
    setResultText = 'accelerateLoginPage:${result?.toMap()}';
  }

  void setAuthUI() async {
    final result =
        await FlAliYunNumberAuth.setAuthUI(android: androidUI, ios: iosUI);
    setResultText = 'setAuthUI:$result';
  }

  set setResultText(String text) {
    resultText = text;
    log(resultText);
    setState(() {});
  }

  AuthUIModelForAndroid androidUI = AuthUIModelForAndroid();
  AuthUIModelForIOS iosUI = AuthUIModelForIOS(
      statusBarUi: StatusBarUIModelForIOS(
          preferredStatusBarStyle: UIStatusBarStyle.darkContent),
      navUi: NavUIModelForIOS(
        navBackImage: 'assets/icon_close_gray.png',
        navColor: Colors.deepPurpleAccent,
        navTitle: NSAttributedString(
            text: 'Title',
            color: Colors.amber,
            backgroundColor: Colors.grey,
            wordSpacing: 10,
            font: UIFont(size: 24, weight: UIFontWeight.bold)),
        navMoreView: UILabel('更多'),
        navBackButtonFrameBlock:
            (Size screenSize, Size superViewSize, Rect frame) {
          log("navBackButtonFrameBlock: screenSize:$screenSize superViewSize:$superViewSize frame:$frame");
        },
        navTitleFrameBlock: (Size screenSize, Size superViewSize, Rect frame) {
          log("navTitleFrameBlock: screenSize:$screenSize superViewSize:$superViewSize frame:$frame");
        },
        navMoreViewFrameBlock:
            (Size screenSize, Size superViewSize, Rect frame) {
          log("navTitleFrameBlock: screenSize:$screenSize superViewSize:$superViewSize frame:$frame");
        },
        privacyNavColor: Colors.red,
        privacyNavTitleFont: UIFont(size: 24, weight: UIFontWeight.light),
        privacyNavTitleColor: Colors.black,
        privacyNavBackImage: 'assets/icon_close_gray.png',
      ));
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
