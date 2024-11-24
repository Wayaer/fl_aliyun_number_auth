import 'package:example/main.dart';
import 'package:example/src/const.dart';
import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/material.dart';

AuthUIModelForIOS buildIOSDialogUi(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  final width = mediaQuery.size.width.toInt();
  final height = mediaQuery.size.height.toInt();
  final top = mediaQuery.viewPadding.top.toInt();
  final logBtnHeight = 44;

  final primaryColor = Theme.of(context).primaryColor;
  final bodyColor = Theme.of(context).textTheme.bodyMedium?.color;
  return AuthUIModelForIOS();
}

AuthUIModelForIOS buildIOSFullScreenUi(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  final width = mediaQuery.size.width.toInt();
  final height = mediaQuery.size.height.toInt();
  final top = mediaQuery.viewPadding.top.toInt();
  final logBtnHeight = 44;

  final primaryColor = Theme.of(context).primaryColor;
  final bodyColor = Theme.of(context).textTheme.bodyMedium?.color;
  return AuthUIModelForIOS();
}
