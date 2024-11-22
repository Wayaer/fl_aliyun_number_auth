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
        home: Scaffold(
            appBar: AppBar(title: const Text('FlAliYunNumberAuth')),
            body: HomePage()));
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

  void setAuthInfo() async {
    final result = await FlAliYunNumberAuth.setAuthInfo(authInfo);
    resultText = 'setAuthInfo:${result?.toMap()}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8)),
          child: Text(resultText)),
      ElevatedText('setAuthInfo', onPressed: setAuthInfo)
    ]);
  }
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
