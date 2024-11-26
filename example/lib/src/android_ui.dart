import 'package:example/main.dart';
import 'package:example/src/const.dart';
import 'package:fl_aliyun_number_auth/fl_aliyun_number_auth.dart';
import 'package:flutter/material.dart';

AuthUIModelForAndroid buildAndroidUi(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  final width = mediaQuery.size.width.toInt();
  final height = mediaQuery.size.height.toInt();
  final top = mediaQuery.viewPadding.top.toInt();
  final logBtnHeight = 44;

  final primaryColor = Theme.of(context).primaryColor;
  final bodyColor = Theme.of(context).textTheme.bodyMedium?.color;
  return AuthUIModelForAndroid(
      statusBarUi: StatusBarUIModelForAndroid(
        statusBarColor: Colors.transparent,
        webViewStatusBarColor: Colors.transparent,
      ),
      navUi: NavUIModelForAndroid(
        navColor: Colors.transparent,
        navText: '一键登录',
        navTextColor: Colors.black,
        navTextSize: 20.toPx(context),
        navTypeface: Typeface.sansSerif,
        navReturnImgPath: AS.close,
        navReturnImgWidth: 18.toPx(context),
        navReturnImgHeight: 18.toPx(context),
        navReturnImgScaleType: ImageScaleType.fitCenter,
        navReturnHidden: false,
        navHidden: false,
        webNavColor: Colors.white,
        webNavTextColor: Colors.black,
        webNavTextSize: 18.toPx(context),
        webNavReturnImgPath: AS.back,
        webHiddeProgress: true,
        webViewStatusBarColor: Colors.transparent,
        bottomNavColor: Colors.white,
      ),
      logoUi: LogoUIModelForAndroid(
        logoHidden: false,
        logoImgPath: AS.logo,
        logoWidth: 100.toPx(context),
        logoHeight: 100.toPx(context),
        logoOffsetY: 8.toPx(context),
        logoScaleType: ImageScaleType.fitCenter,
      ),
      sloganUi: SloganUIModelForAndroid(
        sloganText: '欢迎来到阿里云号码登录',
        sloganTextColor: primaryColor,
        sloganTextSize: 14.toPx(context),
        sloganOffsetY: 120.toPx(context),
        sloganTypeface: Typeface.serif,
      ),
      numberUi: NumberUIModelForAndroid(
        numberColor: primaryColor,
        numberTextSize: 20.toPx(context),
        numFieldOffsetY: 148.toPx(context),
        numberTypeface: Typeface.monospace,
        numberTextSpace: 1,
      ),
      loginBtnUi: LoginBtnUIModelForAndroid(
        logBtnText: '一键登录',
        logBtnTextColor: Colors.white,
        logBtnTextSize: 20.toPx(context),
        logBtnWidth: 200.toPx(context),
        logBtnHeight: logBtnHeight.toPx(context),
        logBtnBackgroundPath: AS.loginBtnNormal,
        logBtnOffsetY: 190.toPx(context),
        loadingImgPath: AS.close,
        logBtnTypeface: Typeface.sansSerif,
      ),
      switchUi: SwitchUIModelForAndroid(
        switchAccHidden: false,
        switchAccText: '其他的',
        switchAccTextColor: primaryColor,
        switchAccTextSize: 20.toPx(context),
        switchTypeface: Typeface.sansSerif,
      ),
      privacyUi: PrivacyUIModelForAndroid(
        privacyOne: PrivacyTextUrl(text: '《用户协议》', url: 'www.baidu.com'),
        privacyTwo: PrivacyTextUrl(text: '《隐私政策》', url: 'www.baidu.com'),
        privacyThree: PrivacyTextUrl(text: '《隐私政策》', url: 'www.baidu.com'),
        privacyColor: bodyColor,
        privacyUrlColor: primaryColor,
        privacyState: false,
        privacyTextSize: 12.toPx(context),
        privacyBefore: 'Before',
        privacyEnd: 'End',
        checkboxHidden: false,
        uncheckedImgPath: AS.uncheckIcon,
        checkedImgPath: AS.checkIcon,
        checkBoxMarginTop: 10.toPx(context),
        vendorPrivacyPrefix: '《',
        vendorPrivacySuffix: '》',
        logBtnToastHidden: false,
        protocolTypeface: Typeface.monospace,
        checkBoxHeight: 20.toPx(context),
      ),
      pageUi: PageUIModelForAndroid(
        screenOrientation: PageOrientation.portrait,
        dialogWidth: (width - 30).toPx(context),
        dialogHeight: (400).toPx(context),
        dialogAlpha: 0.6,
        pageBackgroundPath: AS.appBg,
        dialogOffsetX: 15.toPx(context),
        dialogOffsetY: (height - 400 - top - 15).toPx(context),
        tapAuthPageMaskClosePage: false,
      ),
      privacyAlertUi: PrivacyAlertUIModelForAndroid(
        privacyAlertIsNeedShow: true,
        privacyAlertIsNeedAutoLogin: true,
        privacyAlertMaskIsNeedShow: true,
        privacyAlertCornerRadiusArray: [
          4.toPx(context),
          4.toPx(context),
          4.toPx(context),
          4.toPx(context)
        ],
        privacyAlertAlignment: Gravity.center,
        privacyAlertWidth: (width - 30).toPx(context),
        privacyAlertHeight: 200.toPx(context),
        privacyAlertTitleBackgroundColor: Colors.red,
        privacyAlertTitleContent: '设置标题文本',
        privacyAlertTitleTextSize: 18.toPx(context),
        privacyAlertTitleColor: bodyColor,
        privacyAlertContentBackgroundColor: Colors.white,
        privacyAlertContentTextSize: 14.toPx(context),
        privacyAlertContentColor: bodyColor,
        privacyAlertContentBaseColor: bodyColor,
        privacyAlertContentHorizontalMargin: 20.toPx(context),
        privacyAlertContentVerticalMargin: 20.toPx(context),
        privacyAlertBtnBackgroundImgPath: AS.loginBtnNormal,
        privacyAlertBtnTextColor: Colors.white,
        privacyAlertBtnTextSize: 18.toPx(context),
        privacyAlertBtnWidth: 200.toPx(context),
        privacyAlertBtnHeight: logBtnHeight.toPx(context),
        privacyAlertBtnOffsetY: ((width - 100) ~/ 2).toPx(context),
        privacyAlertCloseBtnShow: true,
        privacyAlertCloseImgPath: AS.close,
        privacyAlertCloseScaleType: ImageScaleType.fitCenter,
        privacyAlertCloseImgWidth: 18.toPx(context),
        privacyAlertCloseImgHeight: 18.toPx(context),
        privacyAlertBtnContent: '同意登录',
        tapPrivacyAlertMaskCloseAlert: false,
        privacyAlertTitleTypeface: Typeface.sansSerif,
        privacyAlertContentTypeface: Typeface.monospace,
        privacyAlertBtnTypeface: Typeface.serif,
        privacyAlertBefore: 'Before',
        privacyAlertEnd: 'End',
        privacyAlertOneColor: primaryColor,
        privacyAlertTwoColor: primaryColor,
        privacyAlertThreeColor: primaryColor,
        privacyAlertOperatorColor: primaryColor,
      ),
      onActivityResult: (int requestCode, int resultCode, dynamic data) {
        log('onActivityResult: requestCode:$requestCode resultCode:$resultCode data:$data');
      },
      onAuthUIClick: (String? code, String? jsonString) {
        log('onAuthUIClick: code:$code jsonString:$jsonString');
      });
}
