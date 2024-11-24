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
        navTextSize: 20.toPX(context),
        navTypeface: Typeface.sansSerif,
        navReturnImgPath: AS.close,
        navReturnImgWidth: 18.toPX(context),
        navReturnImgHeight: 18.toPX(context),
        navReturnImgScaleType: ImageScaleType.fitCenter,
        navReturnHidden: false,
        navHidden: false,
        webNavColor: Colors.white,
        webNavTextColor: Colors.black,
        webNavTextSize: 18.toPX(context),
        webNavReturnImgPath: AS.back,
        webHiddeProgress: true,
        webViewStatusBarColor: Colors.transparent,
        bottomNavColor: Colors.white,
      ),
      logoUi: LogoUIModelForAndroid(
        logoHidden: false,
        logoImgPath: AS.logo,
        logoWidth: 100.toPX(context),
        logoHeight: 100.toPX(context),
        logoOffsetY: 8.toPX(context),
        logoScaleType: ImageScaleType.fitCenter,
      ),
      sloganUi: SloganUIModelForAndroid(
        sloganText: '欢迎来到阿里云号码登录',
        sloganTextColor: primaryColor,
        sloganTextSize: 14.toPX(context),
        sloganOffsetY: 120.toPX(context),
        sloganTypeface: Typeface.serif,
      ),
      numberUi: NumberUIModelForAndroid(
        numberColor: primaryColor,
        numberTextSize: 20.toPX(context),
        numFieldOffsetY: 148.toPX(context),
        numberTypeface: Typeface.monospace,
        numberTextSpace: 1,
      ),
      loginBtnUi: LoginBtnUIModelForAndroid(
        logBtnText: '一键登录',
        logBtnTextColor: Colors.white,
        logBtnTextSize: 20.toPX(context),
        logBtnWidth: 200.toPX(context),
        logBtnHeight: logBtnHeight.toPX(context),
        logBtnBackgroundPath: AS.loginBtnNormal,
        logBtnOffsetY: 190.toPX(context),
        loadingImgPath: AS.close,
        logBtnTypeface: Typeface.sansSerif,
      ),
      switchUi: SwitchUIModelForAndroid(
        switchAccHidden: false,
        switchAccText: '其他的',
        switchAccTextColor: primaryColor,
        switchAccTextSize: 20.toPX(context),
        switchTypeface: Typeface.sansSerif,
      ),
      privacyUi: PrivacyUIModelForAndroid(
        privacyOne: PrivacyTextUrl(text: '《用户协议》', url: 'www.baidu.com'),
        privacyTwo: PrivacyTextUrl(text: '《隐私政策》', url: 'www.baidu.com'),
        privacyThree: PrivacyTextUrl(text: '《隐私政策》', url: 'www.baidu.com'),
        privacyColor: bodyColor,
        privacyUrlColor: primaryColor,
        privacyState: false,
        privacyTextSize: 12.toPX(context),
        privacyBefore: 'Before',
        privacyEnd: 'End',
        checkboxHidden: false,
        uncheckedImgPath: AS.uncheckIcon,
        checkedImgPath: AS.checkIcon,
        checkBoxMarginTop: 10.toPX(context),
        vendorPrivacyPrefix: '《',
        vendorPrivacySuffix: '》',
        logBtnToastHidden: false,
        protocolTypeface: Typeface.monospace,
        checkBoxHeight: 20.toPX(context),
      ),
      pageUi: PageUIModelForAndroid(
        screenOrientation: PageOrientation.portrait,
        dialogWidth: (width - 30).toPX(context),
        dialogHeight: (400).toPX(context),
        dialogAlpha: 0.6,
        pageBackgroundPath: AS.appBg,
        dialogOffsetX: 15.toPX(context),
        dialogOffsetY: (height - 400 - top - 15).toPX(context),
        tapAuthPageMaskClosePage: false,
      ),
      privacyAlertUi: PrivacyAlertUIModelForAndroid(
        privacyAlertIsNeedShow: true,
        privacyAlertIsNeedAutoLogin: true,
        privacyAlertMaskIsNeedShow: true,
        privacyAlertCornerRadiusArray: [
          4.toPX(context),
          4.toPX(context),
          4.toPX(context),
          4.toPX(context)
        ],
        privacyAlertAlignment: Gravity.center,
        privacyAlertWidth: (width - 30).toPX(context),
        privacyAlertHeight: 200.toPX(context),
        privacyAlertTitleBackgroundColor: Colors.red,
        privacyAlertTitleContent: '设置标题文本',
        privacyAlertTitleTextSize: 18.toPX(context),
        privacyAlertTitleColor: bodyColor,
        privacyAlertContentBackgroundColor: Colors.white,
        privacyAlertContentTextSize: 14.toPX(context),
        privacyAlertContentColor: bodyColor,
        privacyAlertContentBaseColor: bodyColor,
        privacyAlertContentHorizontalMargin: 20.toPX(context),
        privacyAlertContentVerticalMargin: 20.toPX(context),
        privacyAlertBtnBackgroundImgPath: AS.loginBtnNormal,
        privacyAlertBtnTextColor: Colors.white,
        privacyAlertBtnTextSize: 18.toPX(context),
        privacyAlertBtnWidth: 200.toPX(context),
        privacyAlertBtnHeight: logBtnHeight.toPX(context),
        privacyAlertBtnOffsetY: ((width - 100) ~/ 2).toPX(context),
        privacyAlertCloseBtnShow: true,
        privacyAlertCloseImgPath: AS.close,
        privacyAlertCloseScaleType: ImageScaleType.fitCenter,
        privacyAlertCloseImgWidth: 18.toPX(context),
        privacyAlertCloseImgHeight: 18.toPX(context),
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
